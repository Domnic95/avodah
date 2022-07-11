import 'package:flutter/material.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/home/career_tab/components/chart.dart';
import 'package:southwind/UI/home/career_tab/page/congratsScreen.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';
import 'package:southwind/utils/helpers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SummaryScreen extends StatelessWidget {
  final int totalquestion;
  final List<int> unAnsweredQuestion;
  // final VoidCallback? onTaps;
  const SummaryScreen(
      {Key? key,
      required this.totalquestion,
      // required this.onTaps,
      required this.unAnsweredQuestion})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    int answeredQuestion = totalquestion - unAnsweredQuestion.length;
    const double radius = 20;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        // leading: SizedBox(
        //   width: AppBar().preferredSize.height - 8,
        //   height: AppBar().preferredSize.height - 8,
        //   child: Material(
        //     borderRadius: BorderRadius.only(
        //         topRight: Radius.circular(20),
        //         bottomRight: Radius.circular(20)),
        //     color: Colors.transparent,
        //     child: InkWell(
        //       borderRadius: BorderRadius.circular(
        //           AppBar().preferredSize.height),
        //       child: Center(
        //         // if you use your own menu view UI you add form initialization
        //         child: widget.menuView != null
        //             ? widget.menuView
        //             : AnimatedIcon(
        //                 icon: widget.animatedIconData != null
        //                     ? widget.animatedIconData
        //                     : AnimatedIcons.close_menu,
        //                 color: Colors.black,
        //                 size: 30,
        //                 progress: iconAnimationController),
        //       ),
        //       onTap: () {
        //         FocusScope.of(context)
        //             .requestFocus(FocusNode());
        //         onDrawerClick();
        //       },
        //     ),
        //   ),
        // ),
        // shadowColor: Colors.red,
        backgroundColor: Colors.white,
        title: Container(
          // color: Colors.teal,
          height: 30,
          child: Image.asset("assets/images/southwind_logo.png"),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
              )),
        ],
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    child: Row(
                      children: [
                        SingleChart(
                          per: (answeredQuestion * 100 / totalquestion)
                              .round()
                              .toDouble(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Summary",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 20),
                            ),
                            Text(
                              "Total Questions : $totalquestion",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                            ),
                            Text(
                              "Answered Questions : $answeredQuestion",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                data,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
            ),
            const Spacer(),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, -1),
                        blurRadius: 10,
                        spreadRadius: 0)
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                child: Row(
                  children: [
                    CommonButton(
                      isExpanded: true,
                      ontap: () {
                        Navigator.popUntil(context, (route) {
                          return route.settings.name == Routes.splashScreen;
                        });
                      },
                      // ontap: () async {
                      //   if (unAnsweredQuestion.isEmpty) {
                      //     final res = await context
                      //         .read(carerNotifierProvider)
                      //         .submitAnswers();
                      //     if (res) {
                      //       Navigator.push(context,
                      //           MaterialPageRoute(builder: (context) {
                      //         return const CongratsScreen();
                      //       }));
                      //     }
                      //   } else {
                      //     showToast('Some questions are not answered');
                      //   }
                      // },
                      lable: "Thank You!",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const data =
    '''You have no view on the whole life cycle of your application, only on the value of a variable at a given time or the assurance or not that your code is following its logical flow. It often happens that console.log are forgotten in several places in the code, which besides a hypothetical loss of performance (tiny, but whose size varies according to the data called through the log method), is not very clean.''';
