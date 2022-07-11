import 'package:southwind/UI/surveys_tab/Page/chartScreen.dart';
import 'package:flutter/material.dart';
import 'package:southwind/Models/survey/individual_survey.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/home/career_tab/page/congratsScreen.dart';

import 'package:southwind/UI/theme/apptheme.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/utils/helpers.dart';

class Questions_Tab extends StatefulWidget {
  const Questions_Tab({
    Key? key,
  }) : super(key: key);

  @override
  _Questions_TabState createState() => _Questions_TabState();
}

class _Questions_TabState extends State<Questions_Tab> {
  int currentQuestion = 0;
  TextEditingController textEditingController = TextEditingController();
  IndividualSurvey? individualSurvey;
  List<int> unAnsweredQuestion = [];
  bool loading = true;
  PageController _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  animateToQuestion() {
    _pageController.jumpToPage(currentQuestion);
    // _pageController.animateToPage(currentQuestion,
    //     duration: Duration(milliseconds: 400), curve: Curves.linear);
  }

  loadData() async {
    final _provider = await context.read(surveyNotifierProvider);
    await _provider.individualSurvey();
    for (int i = 0;
        i < _provider.selectedSurvey!.surveyNotificationQuestion!.length;
        i++) {
      unAnsweredQuestion.add(i + 1);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.read(surveyNotifierProvider);
    final size = MediaQuery.of(context).size;
    final double radius = 20;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppbar(),
      body: loading
          ? LoadingWidget()
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primarySwatch.shade300),
                        height: 20,
                      ),
                      Container(
                        width: currentQuestion /
                            surveyProvider.selectedSurvey!
                                .surveyNotificationQuestion!.length *
                            size.width,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primarySwatch.shade900),
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Question : ${currentQuestion + 1} / ${surveyProvider.selectedSurvey!.surveyNotificationQuestion!.length}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: primarySwatch.shade900),
                      ),
                    ),
                  ),
                  Expanded(
                      child: PageView(
                    controller: _pageController,
                    children: [
                      for (int i = 0;
                          i <
                              surveyProvider.selectedSurvey!
                                  .surveyNotificationQuestion!.length;
                          i++)
                        QuestionAnswerWidget(
                          textEditingController: textEditingController,
                          onChange: (i) {
                            setState(() {
                              unAnsweredQuestion.remove(i + 1);
                            });
                          },
                          i: i,
                        ),
                    ],
                    onPageChanged: (a) {
                      currentQuestion = a;

                      setState(() {});
                    },
                  )),
                  // Spacer(),
                  Container(
                    decoration: BoxDecoration(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 18),
                      child:
                          //  Row(
                          //   children: [
                          //     CommonButton(
                          //       isExpanded: true,
                          //       lable: "Answer it",
                          //       isLeading: true,
                          //       ontap: () {
                          //         setState(() {
                          //           if (currentQuestion <
                          //               surveyProvider.selectedSurvey!
                          //                   .surveyNotificationQuestion!.length) {
                          //             currentQuestion++;
                          //           }

                          //           animateToQuestion();
                          //           if (currentQuestion ==
                          //               surveyProvider.selectedSurvey!
                          //                   .surveyNotificationQuestion!.length) {
                          //             Navigator.pushNamed(
                          //                 context, Routes.question_summary);
                          //             // Navigator.push(context,
                          //             //     MaterialPageRoute(builder: (context) {
                          //             //   return SummaryTab(
                          //             //     totalquestion: Questions.length,
                          //             //   );
                          //             // }));
                          //           }
                          //         });
                          //         // animateToQuestion();
                          //       },
                          //     ),

                          //   ],
                          // )
                          Row(
                        children: [
                          currentQuestion > 0
                              ? CommonButton(
                                  isExpanded: true,
                                  lable: "Previous",
                                  ontap: () {
                                    if (currentQuestion + 1 > 1) {
                                      setState(() {
                                        currentQuestion--;
                                        animateToQuestion();
                                      });
                                    }

                                    // animateToQuestion();
                                    // if (currentQuestion == Questions.length) {
                                    //   Navigator.push(context,
                                    //       MaterialPageRoute(builder: (context) {
                                    //     // return SummaryScreen(
                                    //     //   totalquestion: Questions.length,
                                    //     // );
                                    //   }));
                                    // }
                                  },
                                  isLeading: true,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Icon(
                                      Icons.west,
                                      size: 25,
                                      color: primarySwatch[900],
                                    ),
                                  ),
                                )
                              : Expanded(child: Container()),
                          CommonButton(
                            isExpanded: true,
                            lable: surveyProvider.textReadibility &&
                                    currentQuestion + 1 ==
                                        surveyProvider.selectedSurvey!
                                            .surveyNotificationQuestion!.length
                                ? "See result"
                                : currentQuestion + 1 <
                                        surveyProvider.selectedSurvey!
                                            .surveyNotificationQuestion!.length
                                    ? "Next"
                                    : "Submit",
                            ontap: () async {
                              if (surveyProvider.textReadibility &&
                                  currentQuestion + 1 ==
                                      surveyProvider.selectedSurvey!
                                          .surveyNotificationQuestion!.length) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ChartScreen( );
                                }));
                              } else {
                                if (currentQuestion + 1 <
                                    surveyProvider.selectedSurvey!
                                        .surveyNotificationQuestion!.length) {
                                  setState(() {
                                    currentQuestion++;

                                    animateToQuestion();
                                  });
                                } else {
                                  if (unAnsweredQuestion.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return LoadingWidget();
                                        });
                                    final res =
                                        await surveyProvider.submitAnswers();
                                    Navigator.pop(context);
                                    if (res) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CongratsScreen(
                                          survey: true,
                                          title: "Survey",
                                          unAnsweredQuestion:
                                              unAnsweredQuestion,
                                          totalquestion: surveyProvider
                                              .selectedSurvey!
                                              .surveyNotificationQuestion!
                                              .length,
                                        );
                                      }));
                                    }
                                  } else {
                                    showToast(
                                        'Some questions are not answered');
                                  }

                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return SummaryScreen(
                                  //     unAnsweredQuestion: unAnsweredQuestion,
                                  //     totalquestion: surveyProvider
                                  //         .selectedSurvey!
                                  //         .surveyNotificationQuestion!
                                  //         .length,
                                  //     onTaps: () async {

                                  //     },
                                  //   );
                                  // }));
                                }
                              }

                              // animateToQuestion();
                              // if (currentQuestion == Questions.length) {
                              //   Navigator.push(context,
                              //       MaterialPageRoute(builder: (context) {
                              //     // return SummaryScreen(
                              //     //   totalquestion: Questions.length,
                              //     // );
                              //   }));
                              // }
                            },
                            isLeading: false,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.east,
                                size: 25,
                                color: primarySwatch[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
    );
  }
}

class QuestionAnswerWidget extends StatefulWidget {
  int i;
  TextEditingController textEditingController;
  ValueChanged<int>? onChange;
  QuestionAnswerWidget(
      {Key? key,
      required this.i,
      required this.textEditingController,
      this.onChange})
      : super(key: key);

  @override
  State<QuestionAnswerWidget> createState() => _QuestionAnswerWidgetState();
}

class _QuestionAnswerWidgetState extends State<QuestionAnswerWidget> {
  Set selected = {};
  Set selected1 = {};
  int currentindex = -1;
  bool vlaue = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final surveyProvider = context.read(surveyNotifierProvider);
    if (surveyProvider.textReadibility) {
      SurveyNotificationQuestion loc =
          surveyProvider.selectedSurvey!.surveyNotificationQuestion![widget.i];
      for (int i = 0; i < loc.surveyNotificationOption!.length; i++) {
        if (loc.surveyNotificationAnswer!.first.optionId! ==
            loc.surveyNotificationOption![i].id) {
          currentindex = i;

          widget.textEditingController.text =
              loc.surveyNotificationAnswer!.first.other.toString().length > 0
                  ? loc.surveyNotificationAnswer!.first.other
                  : " ";
        }
      }
    }
    setState(() {});
    // if (surveyProvider.selectedSurvey!.surveyAnswer![widget.i].other != null) {
    //   widget.textEditingController.text =
    //       surveyProvider.selectedSurvey!.surveyAnswer![widget.i].other;
    // } else {
    //   widget.textEditingController.text = "";
    // }
  }

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.read(surveyNotifierProvider);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "${surveyProvider.selectedSurvey!.surveyNotificationQuestion![widget.i].question}",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Answer :",
              style: TextStyle(fontSize: 14, color: primarySwatch[700]),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: 68 *
                  surveyProvider
                      .selectedSurvey!
                      .surveyNotificationQuestion![widget.i]
                      .surveyNotificationOption!
                      .length
                      .toDouble(),
              child: ListView.builder(
                itemCount: surveyProvider
                    .selectedSurvey!
                    .surveyNotificationQuestion![widget.i]
                    .surveyNotificationOption!
                    .length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!surveyProvider.textReadibility) {
                                  widget.onChange!(widget.i);
                                  selected1.contains(index)
                                      ? selected1.remove(index)
                                      : selected1.add(index);

                                  currentindex = index;
                                  surveyProvider.updateAnswer(widget.i,
                                      widget.textEditingController.text, index);
                                }
                              });
                            },
                            child: Card(
                              // elevation: currentindex == index ? 5 : 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 3),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: currentindex == index
                                          ? primarySwatch.shade900
                                          : Colors.white,
                                      width: 2),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Container(
                                    //   margin: EdgeInsets.only(left: 10),
                                    //   child: Text(
                                    //     "${Chose1[index].char}",
                                    //     style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 30,
                                    //       color: selected1.contains(index)
                                    //           ? primarySwatch.shade900
                                    //           : Colors.grey[700],
                                    //     ),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   width: size.width * 0.05,
                                    // ),
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "${surveyProvider.selectedSurvey!.surveyNotificationQuestion![widget.i].surveyNotificationOption![index].optionName}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: currentindex == index
                                              ? primarySwatch.shade900
                                              : Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    Radio(
                                      groupValue: index,
                                      value: currentindex,
                                      onChanged: (val) {
                                        setState(() {
                                          if (!surveyProvider.textReadibility) {
                                            widget.onChange!(widget.i);
                                            selected1.contains(index)
                                                ? selected1.remove(index)
                                                : selected1.add(index);
                                            currentindex = -1;
                                            currentindex = index;
                                            surveyProvider.updateAnswer(
                                                widget.i,
                                                widget
                                                    .textEditingController.text,
                                                index);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (surveyProvider.selectedSurvey!
                    .surveyNotificationQuestion![widget.i].other ==
                1)
              TextFormField(
                readOnly: surveyProvider.textReadibility,
                controller: widget.textEditingController,
                textInputAction: TextInputAction.done,
                maxLines: 3,
                onChanged: (c) {
                  surveyProvider.updateNotes(widget.i, c);
                },
                style: TextStyle(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                    hintText: "Enter Your Answer",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    isCollapsed: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(width: .5, color: primarySwatch[700]!)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(width: .5, color: primarySwatch[700]!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(width: 1, color: primaryColor))),
              ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionsTab extends StatelessWidget {
  final int totalQuestion;
  final int currentQuestion;
  final Function(int) onTap;

  const QuestionsTab(
      {required this.totalQuestion,
      required this.currentQuestion,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              onTap(index);
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentQuestion == index
                      ? primarySwatch[900]
                      : Colors.white,
                  border: Border.all(color: primarySwatch[800]!)),
              height: 40,
              width: 40,
              child: Center(
                  child: Text(
                "${index + 1}",
                style: TextStyle(
                    color: currentQuestion == index
                        ? Colors.white
                        : primarySwatch[900],
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: totalQuestion,
      padding: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
