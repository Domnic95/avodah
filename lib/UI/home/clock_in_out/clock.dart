// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/component/popup.dart';
import 'package:southwind/constant/Global.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/utils/helpers.dart';
import 'package:southwind/utils/utilsContstant.dart';

class FlutterStopWatch extends StatefulHookWidget {
  @override
  _FlutterStopWatchState createState() => _FlutterStopWatchState();
}

class _FlutterStopWatchState extends State<FlutterStopWatch> {
  bool flag = true;
  late Stream<int> timerStream;
  late StreamSubscription<int> timerSubscription;
  String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';
  int counter = 0;
  bool isClockOn = false;
  late Timer timer;
  @override
  void dispose() {
    if (timer != null) timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    if (sharedPreferences.containsKey(key_punchInDate)) {
      DateTime now = DateTime.now();
      DateTime setedTime = DateTime.parse(Utils.getPref(key_punchInDate)!);
      counter = now.difference(setedTime).inSeconds;
      isClockOn = true;
      timerStream = stopWatchStream();
      clockCounter();
    }
  }

  Stream<int> stopWatchStream() {
    late StreamController<int> streamController;

    Duration timerInterval = Duration(seconds: 1);

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        // timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
      if (!flag) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  void clockCounter() {
    timerSubscription = timerStream.listen((int newTick) {
      setState(() {
        hoursStr =
            ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
        minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
        secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
        isClockOn = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = useProvider(timerNotifierProvider);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // color: Colors.red,
            height: 100,
            child: Center(
              child: Text(
                "CLOCK IN / OUT",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 300,
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "$hoursStr:$minutesStr:$secondsStr",
                        style: TextStyle(
                          fontSize: 60.0,
                        ),
                      ),
                    ),
                  ),
                  CommonButton(
                    lable: isClockOn ? "Clock Out" : "Clock In",
                    ontap: () {
                      showToast("This functionality is temporarily disabled");
                    },
                    // ontap: isClockOn
                    //     ? () async {
                    //         await timerProvider.punchOut();
                    //         timerSubscription.pause();
                    //         timerStream;
                    //         isClockOn = false;
                    //         setState(() {});
                    //         showDialog(
                    //             context: context,
                    //             builder: (context) {
                    //               return CustomPopUp(
                    //                 title: "Clock out!",
                    //                 subTitle:
                    //                     "You have been successfully clocked out.Have a great day.",
                    //               );
                    //             });
                    //       }
                    //     : () async {
                    //         await timerProvider.punchIn();
                    //         timerStream = stopWatchStream();
                    //         clockCounter();

                    //         showToast("You have succesfully clocked in.");
                    //       },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // RaisedButton(
              //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              //   onPressed: () {
              // timerStream = stopWatchStream();
              // timerSubscription = timerStream.listen((int newTick) {
              //   setState(() {
              //     hoursStr = ((newTick / (60 * 60)) % 60)
              //         .floor()
              //         .toString()
              //         .padLeft(2, '0');
              //     minutesStr = ((newTick / 60) % 60)
              //         .floor()
              //         .toString()
              //         .padLeft(2, '0');
              //     secondsStr =
              //         (newTick % 60).floor().toString().padLeft(2, '0');
              //   });
              // });
              //   },
              //   color: Colors.green,
              //   child: Text(
              //     'START',
              //     style: TextStyle(
              //       fontSize: 20.0,
              //     ),
              //   ),
              // ),
              SizedBox(width: 40.0),
              // RaisedButton(
              //   padding:
              //       EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              //   onPressed: () {
              // timerSubscription.pause();
              // timerStream;
              //     /*setState(() {
              //       hoursStr = '00';
              //       minutesStr = '00';
              //       secondsStr = '00';
              //     });*/
              //   },
              //   color: Colors.red,
              //   child: Text(
              //     'STOP',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 20.0,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
