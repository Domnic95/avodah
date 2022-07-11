// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/surveys_tab/surveys_tab.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/routes/routes.dart';

class CongratTab extends StatelessWidget {
  const CongratTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color.lerp(Colors.black, Colors.white, .8)!,
        child: SafeArea(
          child: Scaffold(
            // appBar: AppBar(
            //   elevation: 0,
            //   backgroundColor: Colors.transparent,
            // ),
            body: Container(
              child: Align(
                alignment: Alignment(0, -.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: primarySwatch.shade200,
                          shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.check,
                          color: primarySwatch.shade900,
                          size: 60,
                        ),
                      ),
                    ),
                    Text(
                      "Done!",
                      style: (TextStyle(
                          letterSpacing: 1,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Your survey has been answered and you get 80\n points",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          letterSpacing: 0.5),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                      bgColor: primarySwatch.shade900,
                      lable: "Thank you!",
                      textStyle: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      ontap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // Navigator.pushNamed(context, Routes.done_screen);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // child: Container(
          //   child: Stack(
          //     children: [
          //       Center(
          //           child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 28),
          //         child: Card(
          //           elevation: 10,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(10),
          //             child: Container(
          //               color: primarySwatch[100],
          //               child: Padding(
          //                 padding: const EdgeInsets.only(top: 50, bottom: 20),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.stretch,
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                     Image.asset(
          //                       "assets/images/trophy.png",
          //                       height: 140,
          //                     ),
          //                     SizedBox(
          //                       height: 20,
          //                     ),
          //                     Center(
          //                       child: Text(
          //                         "Congrats!",
          //                         style: Theme.of(context)
          //                             .textTheme
          //                             .bodyText1!
          //                             .copyWith(fontSize: 22),
          //                       ),
          //                     ),
          //                     // Center(
          //                     //   child: Text(
          //                     //     "90% Score",
          //                     //     style: Theme.of(context)
          //                     //         .textTheme
          //                     //         .bodyText1!
          //                     //         .copyWith(
          //                     //             fontSize: 24,
          //                     //             fontWeight: FontWeight.w700),
          //                     //   ),
          //                     // ),
          //                     SizedBox(
          //                       height: 10,
          //                     ),
          //                     Center(
          //                       child: Text(
          //                         "Quiz completed sucessfully",
          //                         style: TextStyle(
          //                             color: Colors.black,
          //                             fontWeight: FontWeight.normal),
          //                       ),
          //                     ),
          //                     // Center(
          //                     //   child: RichText(
          //                     //       text: TextSpan(children: [
          //                     //     TextSpan(
          //                     //         text: "You attempted ",
          //                     //         style: Theme.of(context)
          //                     //             .textTheme
          //                     //             .bodyText1!
          //                     //             .copyWith(
          //                     //               color: Colors.black,
          //                     //               fontSize: 16,
          //                     //               fontWeight: FontWeight.normal,
          //                     //             )),
          //                     //     TextSpan(
          //                     //         text: "5 questions",
          //                     //         style: Theme.of(context)
          //                     //             .textTheme
          //                     //             .bodyText1!
          //                     //             .copyWith(
          //                     //               color: primarySwatch[900],
          //                     //               fontWeight: FontWeight.w100,
          //                     //             ))
          //                     //   ])),
          //                     // )
          //                   ],
          //                 ),
          //               ),
          //               // width: 50,
          //             ),
          //           ),
          //         ),
          //       )),
          //       Positioned(
          //         child: InkWell(
          //           onTap: () {
          //             Navigator.pop(context);
          //           },
          //           child: Container(
          //             decoration: BoxDecoration(
          //                 shape: BoxShape.circle, color: Colors.white),
          //             child: Icon(
          //               Icons.close,
          //               size: 28,
          //             ),
          //           ),
          //         ),
          //         right: 10,
          //         top: 10,
          //       ),
          //     ],
          //   ),
          // ),
        ));
  }
}
