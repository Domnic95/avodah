// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/home/schedule_tab/schedule.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/component/popup.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/data/providers/timerCard_notifier.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkHistory extends StatefulHookWidget {
  const WorkHistory({Key? key}) : super(key: key);

  @override
  _WorkHistoryState createState() => _WorkHistoryState();
}

class _WorkHistoryState extends State<WorkHistory> {
  DateTime currentTime = DateTime.now();
  DateTime? startTime;
  DateTime? endTime;
  bool isLoading = true;
  bool isCalenderVisible = false;
  bool isCheckin = false;
  bool isCheckVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    final timerProvider = context.read(timerNotifierProvider);

    await timerProvider.timeCardAccordingToDates();

    setState(() {
      isLoading = false;
      startTime = timerProvider.startDate!;
      endTime = timerProvider.endDate!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = useProvider(timerNotifierProvider);
    final size = MediaQuery.of(context).size;
    TextStyle defaultTextStyle =
        TextStyle(color: primarySwatch[400]!, fontSize: 14);
    final double dotWidth = 5;
    final double rowHeight = 35;

    return Scaffold(
      // appBar: CommonAppbar(),
      body: isLoading
          ? LoadingWidget()
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.22 + 4,
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      child: AnimatedContainer(
                        // height: 200,
                        // color: Colors.green,
                        duration: Duration(seconds: 2),
                        clipBehavior: Clip.none,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                _toggleCalendarVisibilty();
                              },
                              child: Container(
                                height: 80,
                                color: primarySwatch[100],
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            const Text(
                                              "CHECK IN",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Center(
                                              child: Text(
                                                "${startTime!.day} ${monthsList[startTime!.month]} ${startTime!.year}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // VerticalDivider(
                                      //   thickness: 3,
                                      // ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: primarySwatch[900],
                                        size: 25,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          // onTap: _checkVisibilityToggle,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "CHECK OUT",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Center(
                                                  child: Text(
                                                    "${endTime!.day} ${monthsList[endTime!.month]} ${endTime!.year}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (isCalenderVisible)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Column(
                                    children: [
                                      Container(
                                        //height: MediaQuery.of(context).size.width,
                                        child: TableCalendar(
                                            rangeEndDay: endTime,
                                            rangeStartDay: startTime,
                                            // rangeStartDay: DateTime.utc(2021, 11, 27),
                                            // rangeEndDay: DateTime.utc(2021, 12, 29),
                                            onRangeSelected: (d, da, dat) {
                                              startTime = d;
                                              endTime = dat;
                                              // if (da != null) {
                                              //   if (d!.isAfter(dat)) {
                                              //     startTime = dat;
                                              //     endTime = da;
                                              //   } else {
                                              //     endTime = dat;
                                              //     startTime = d;
                                              //   }
                                              // } else {
                                              //   startTime = d;
                                              //   endTime = d;
                                              // }

                                              setState(() {});
                                            },
                                            // currentDay: currentTime,
                                            onDaySelected: (d, da) {
                                              setState(() {
                                                currentTime = da;
                                              });
                                            },
                                            rangeSelectionMode:
                                                RangeSelectionMode.enforced,
                                            // pageAnimationEnabled: false,
                                            // pageJumpingEnabled: false,
                                            // dayHitTestBehavior:
                                            //     HitTestBehavior.deferToChild,
                                            calendarBuilders: CalendarBuilders(
                                              defaultBuilder: (con, d, data) {
                                                return Container(
                                                  color: Colors.white,
                                                  child: Center(
                                                      child: Text(
                                                    "${d.day}",
                                                    style: defaultTextStyle
                                                        .copyWith(
                                                            color: d.isAfter(
                                                                    DateTime
                                                                        .now())
                                                                ? primarySwatch[
                                                                    600]
                                                                : primarySwatch[
                                                                    300]),
                                                  )),
                                                );
                                              },
                                              // dowBuilder: (context, d) {
                                              //   return Container(
                                              //       decoration:
                                              //           BoxDecoration(color: primarySwatch[100]),
                                              //       child: Center(
                                              //           child: Text(
                                              //         weekDays[d.weekday]!,
                                              //         style: TextStyle(
                                              //           color: primarySwatch[900],
                                              //           fontSize: 14,
                                              //         ),
                                              //       )));
                                              // },
                                              outsideBuilder:
                                                  (context, d, data) {
                                                return Center(
                                                    child: Text(
                                                  "${d.day}",
                                                  style:
                                                      defaultTextStyle.copyWith(
                                                          color: Colors.grey
                                                              .withOpacity(.5)),
                                                ));
                                              },
                                              markerBuilder:
                                                  (context, d, data) {
                                                if (data.isEmpty)
                                                  return const SizedBox();
                                                // return Text(d.day.toString());
                                                // return Center(
                                                //   child: Container(
                                                //     height: 10,
                                                //     width: 10,
                                                //     decoration: BoxDecoration(
                                                //       shape: BoxShape.circle,
                                                //       border: Border.all(
                                                //           color: data[0] == 0
                                                //               ? Colors.red
                                                //               : Colors.green),
                                                //       // color: data[0] == 0 ? Colors.red : Colors.green,
                                                //     ),
                                                //     // height: dotWidth,
                                                //     // width: dotWidth,
                                                //   ),
                                                // );
                                                return Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Card(
                                                    margin:
                                                        const EdgeInsets.all(0),
                                                    elevation: 2,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10000),
                                                      // side: BorderSide(color: Colors.red),
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: data[0] == 0
                                                            ? Colors.red
                                                            : Colors.green,
                                                      ),
                                                      height: dotWidth,
                                                      width: dotWidth,
                                                    ),
                                                  ),
                                                );
                                              },
                                              selectedBuilder:
                                                  (context, d, date) {
                                                return Container(
                                                  color: Colors.pink,
                                                  height: 10,
                                                  width: 10,
                                                );
                                              },
                                              // todayBuilder: (context, d, data) {
                                              //   return Container(
                                              //     color: Colors.white,
                                              //     child: Center(
                                              //         child: Text(
                                              //       "${d.day}",
                                              //       style: defaultTextStyle.copyWith(
                                              //           color: d.isAfter(DateTime.now())
                                              //               ? primarySwatch[600]
                                              //               : primarySwatch[300]),
                                              //     )),
                                              //   );
                                              // },
                                            ),
                                            headerStyle: HeaderStyle(
                                              headerPadding: EdgeInsets.zero,
                                              titleTextStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!,
                                              formatButtonVisible: false,
                                              titleCentered: true,
                                              // leftChevronVisible: false,
                                              // rightChevronVisible: false,
                                              rightChevronMargin:
                                                  EdgeInsets.zero,
                                              leftChevronMargin:
                                                  EdgeInsets.zero,
                                              leftChevronPadding:
                                                  EdgeInsets.zero,
                                              leftChevronIcon: Icon(
                                                Icons.chevron_left,
                                                size: 30,
                                                color: primarySwatch[900],
                                              ),
                                              rightChevronIcon: Icon(
                                                Icons.chevron_right,
                                                size: 30,
                                                color: primarySwatch[900],
                                              ),
                                              rightChevronPadding:
                                                  EdgeInsets.zero,
                                              headerMargin:
                                                  const EdgeInsets.only(
                                                      bottom: 10),
                                            ),
                                            calendarStyle: CalendarStyle(
                                              todayDecoration:
                                                  const BoxDecoration(
                                                      color:
                                                          Colors.transparent),
                                              todayTextStyle: defaultTextStyle,
                                              rangeHighlightColor:
                                                  primarySwatch[200]!,
                                              // rowDecoration: Bx,
                                              rangeStartDecoration: const BoxDecoration(
                                                  color: primaryColor,
                                                  // borderRadius: BorderRadius.only(
                                                  //   topLeft: Radius.circular(100),
                                                  //   bottomLeft: Radius.circular(100),
                                                  // ),
                                                  shape: BoxShape.circle),
                                              rangeEndDecoration:
                                                  const BoxDecoration(
                                                      color: primaryColor,
                                                      shape: BoxShape.circle),
                                              // withinRangeDecoration:
                                              //     BoxDecoration(color: primaryColor),

                                              markerDecoration:
                                                  const BoxDecoration(
                                                      color: Colors.red),
                                              markerSize: 4,
                                              cellPadding: EdgeInsets.zero,
                                              markersAutoAligned: true,
                                              // weekendTextStyle:
                                              //     defaultTextStyle.copyWith(color: Colors.black),
                                              // weekendDecoration: BoxDecoration(color: Colors.black),
                                              holidayDecoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color:
                                                          primarySwatch[700]!)),
                                              holidayTextStyle: TextStyle(
                                                  color: primarySwatch[400]),
                                              cellMargin: EdgeInsets.zero,
                                            ),
                                            rowHeight: rowHeight,
                                            daysOfWeekHeight: 40,
                                            // daysOfWeekHeight: 50,
                                            daysOfWeekStyle: DaysOfWeekStyle(
                                              weekdayStyle: TextStyle(
                                                color: primarySwatch[900],
                                                fontWeight: FontWeight.w300,
                                              ),
                                              weekendStyle: TextStyle(
                                                color: primarySwatch[900],
                                                fontWeight: FontWeight.w300,
                                              ),
                                              decoration: BoxDecoration(
                                                color: primarySwatch[100],
                                                border: Border.all(
                                                  color: primarySwatch[900]!,
                                                  width: .2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            daysOfWeekVisible: true,
                                            // holidayPredicate: (d) {
                                            //   return d.day == (DateTime.now().day + 1);
                                            // },
                                            startingDayOfWeek:
                                                StartingDayOfWeek.sunday,
                                            focusedDay: currentTime,
                                            firstDay: DateTime.utc(2015),
                                            lastDay: DateTime.utc(2024)),
                                      ),
                                      const Divider(
                                        height: 30,
                                        thickness: .7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Center(
                                            child: InkWell(
                                              onTap: () {
                                                _toggleCalendarVisibilty();
                                              },
                                              child: Container(
                                                // decoration: BoxDecoration(
                                                //     border: Border.all(
                                                //         color: primarySwatch[900]!)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 6,
                                                      horizontal: 20),
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      color: primarySwatch[900],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: InkWell(
                                              onTap: () async {
                                                _toggleCalendarVisibilty();
                                                // setState(() {
                                                //   isLoading = true;
                                                // });

                                                await timerProvider.setDate(
                                                    endTime!, startTime!);
                                                await timerProvider
                                                    .timeCardAccordingToDates();
                                                // setState(() {
                                                //   isLoading = false;
                                                // });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: primarySwatch[
                                                            900]!)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 6,
                                                      horizontal: 20),
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                        color:
                                                            primarySwatch[900],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (!isCalenderVisible && !isCheckVisible) ...[
                      // ScheduleCard(),
                      Expanded(
                        child: timerProvider.timerCardList.length > 0
                            ? ListView.builder(
                                itemCount: timerProvider.timerCardList.length,
                                itemBuilder: (context, index) {
                                  return ScheduleCard(
                                    index: index,
                                  );
                                })
                            : Center(
                                child: Text('No data found'),
                              ),
                      )
                    ],
                    if (!isCalenderVisible && isCheckVisible) ...[
                      Expanded(
                        child: Center(
                          // width: size.width,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                !isCheckin
                                    ? 'Hello ${timerProvider.userData!.profileFirstName}, you are currently not signed in.'
                                    : "Hello ${timerProvider.userData!.profileFirstName}, you are currently signed in.",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: _checkInAndOutToggle,
                                child: Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primarySwatch.shade400),
                                    child: Center(
                                      child: Text(
                                        !isCheckin ? 'Clock In' : "Clock Out",
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ),
    );
  }

  _toggleCalendarVisibilty() {
    isCalenderVisible = !isCalenderVisible;
    isCheckVisible = false;
    setState(() {});
  }

  _checkVisibilityToggle() {
    isCheckVisible = !isCheckVisible;
    isCalenderVisible = false;
    setState(() {});
  }

  _checkInAndOutToggle() {
    setState(() {
      showDialog(
          context: context,
          builder: (context) {
            return CustomPopUp(
              title: isCheckin ? 'Clock In' : "Clock out!",
              subTitle: isCheckin
                  ? "You have succesfully clocked in."
                  : "You have been successfully clocked out.Have a great day.",
            );
          });

      isCheckin = !isCheckin;
    });
  }

  Widget checinSuccesMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/images/trophy.png",
          height: 140,
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            "Congrats!",
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),
          ),
        ),

        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            "Quiz completed sucessfully",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ),

        // )
      ],
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final int index;

  const ScheduleCard({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.read(timerNotifierProvider);
    DateTime _time = timerProvider.timerCardList[index].createdAt!;

    String _timeIn =
        DateFormat.jm().format(timerProvider.timerCardList[index].timeIn!);

    String _timeOut =
        DateFormat.jm().format(timerProvider.timerCardList[index].timeOut!);
    //${timerProvider.timerCardList[index].totHours!.substring(0, 2)}: ${timerProvider.timerCardList[index].totHours!.substring(8, 10)}

    int hIndex = timerProvider.timerCardList[index].totHours!.indexOf('hours');
    int mIndex =
        timerProvider.timerCardList[index].totHours!.indexOf('minutes');
    int sIndex =
        timerProvider.timerCardList[index].totHours!.indexOf('seconds');
    String hours = timerProvider.timerCardList[index].totHours!
        .substring(0, hIndex)
        .trim();
    String minutes = timerProvider.timerCardList[index].totHours!
        .substring(hIndex + 5, mIndex);
    String second = timerProvider.timerCardList[index].totHours!
        .substring(mIndex + 7, sIndex);
    timerProvider.timerCardList[index].totHours!.substring(0, 2);

    const double cardRadius = 10;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cardRadius),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: primaryColor, width: 6),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      monthsList[
                          timerProvider.timerCardList[index].timeIn!.month],
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      timerProvider.timerCardList[index].timeIn!.day.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 1, fontSize: 20),
                    ),
                    Text(
                      timerProvider.timerCardList[index].timeIn!.year
                          .toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${weekDaysList[_time.weekday]}, ${_timeIn}  to  ${_timeOut} ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "(${hours}:${minutes}:${second})h",
                      style: TextStyle(
                          color: primarySwatch[300],
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          height: 1),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
