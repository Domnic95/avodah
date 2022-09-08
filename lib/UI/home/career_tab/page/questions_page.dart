import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/career/careerModel.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/feedback_screen/feedbackScreen.dart';
import 'package:southwind/UI/home/career_tab/components/information_dialog.dart';
import 'package:southwind/UI/home/career_tab/page/congratsScreen.dart';
import 'package:southwind/UI/home/career_tab/page/summary_screen.dart';
import 'package:southwind/UI/surveys_tab/Page/chartScreen.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/utils/helpers.dart';

class QuestionsPage extends StatefulHookWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
   CareerAchievement selectedAchievement =
      CareerAchievement(careerPathNotificationAchievementQuestion: []);
  int currentQuestion = 0;
  final PageController _pageController = PageController();
  List<int> unAnsweredQuestion = [];
  int questionLength = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CareerAchievement achievement =
          context.read(carerNotifierProvider).selectedAchievement;
      if ((achievement.attachmentUrl != null &&
              achievement.attachmentUrl != '') ||
          (achievement.cloudinarySecureUrl != "" &&
              achievement.cloudinarySecureUrl != null))
        showInformationDialog(context);
    });
    loadData();
  }

  loadData() async {
    final _careerProvider = context.read(carerNotifierProvider);

    questionLength = _careerProvider
        .selectedAchievement.careerPathNotificationAchievementQuestion!.length;

    for (int i = 0; i < questionLength; i++) {
      unAnsweredQuestion.add(i + 1);
    }
    setState(() {});
  }

  animateToQuestion() {
    _pageController.jumpToPage(currentQuestion);
    // _pageController.animateToPage(currentQuestion,
    //     duration: Duration(milliseconds: 400), curve: Curves.linear);
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final careerProvider = useProvider(carerNotifierProvider);

    bool readibility = careerProvider.textReadibility;
    final size = MediaQuery.of(context).size;
    const double radius = 20;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CommonAppbar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
              color: Colors.transparent,
              margin: const EdgeInsets.all(0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              )),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radius),
                        bottomRight: Radius.circular(radius),
                      )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          careerProvider.selectedAchievement.name.toString(),
                          style: TextStyle(
                              color: primarySwatch[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 50,
                        child: QuestionsTab(
                          totalQuestion: questionLength,
                          currentQuestion: currentQuestion,
                          onTap: (a) {
                            currentQuestion = a;

                            setState(() {});
                            animateToQuestion();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: PageView(
              controller: _pageController,
              children: [
                for (int i = 0; i < questionLength; i++)
                  QuestionAnswerWidget(
                    onChange: (c) {
                      // controller.text = c;

                      setState(() {
                        log('selectedIndex after ${unAnsweredQuestion}');
                        unAnsweredQuestion.remove(i + 1);
                        log('selectedIndex before ${unAnsweredQuestion}');
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
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, -1),
                        blurRadius: 10,
                        spreadRadius: 0),
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
                    currentQuestion > 0
                        ? CommonButton(
                            isExpanded: true,
                            lable: "Previous",
                            isLeading: true,
                            ontap: () {
                              if (currentQuestion != 0) currentQuestion--;

                              setState(() {});
                              animateToQuestion();
                            },
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
                    currentQuestion == questionLength - 1 && readibility
                        ? Builder(builder: (context) {
                            if (careerProvider
                                .selectedAchievement.userAchievemnts!.isEmpty) {
                              return Expanded(child: Container());
                            }
                            final feedback = careerProvider.selectedAchievement
                                .userAchievemnts!.first.feedback;
                            if (feedback == null || feedback == "") {
                              return Expanded(child: Container());
                            }
                            return CommonButton(
                              lable: "Feedback",
                              ontap: () {
                                print((careerProvider.selectedAchievement
                                        .userAchievemnts?.first.id)
                                    .toString());
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return FeedBackScreen(
                                    notificationData: {
                                      "title": careerProvider
                                          .selectedAchievement.name,
                                      "career_path_user_achivement_id":
                                          careerProvider.selectedAchievement
                                              .userAchievemnts!.first.id
                                    },
                                  );
                                }));
                              },
                              isExpanded: true,
                            );
                          })
                        : CommonButton(
                            isExpanded: true,
                            lable: currentQuestion == questionLength - 1
                                ? "Submit"
                                : "Next",
                            ontap: () async {
                              // showToast("s");
                              // if (controller.text.isNotEmpty) {
                              //   await careerProvider.updateAnswer(
                              //       currentQuestion, controller.text);
                              //   controller.clear();
                              //   unAnsweredQuestion.remove(currentQuestion + 1);
                              // }

                              if (currentQuestion + 1 < questionLength) {
                                currentQuestion++;
                                animateToQuestion();
                                setState(() {});
                              } else {
                                if (currentQuestion == questionLength - 1 &&
                                    !careerProvider.textReadibility) {
                                  if (unAnsweredQuestion.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return LoadingWidget();
                                        });
                                    final res = await context
                                        .read(carerNotifierProvider)
                                        .submitAnswers();
                                    await Future.delayed(Duration(seconds: 1));
                                    // final res = true;
                                    Navigator.pop(context);
                                    final score = await context
                                        .read(carerNotifierProvider)
                                        .getScore();
                               
                                    final total = context
                                        .read(carerNotifierProvider)
                                        .selectedAchievement
                                        .careerPathNotificationAchievementQuestion!
                                        .length;
                                    if (res) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CongratsScreen(
                                          survey: false,
                                          title: "Career path",
                                          customTitle:
                                              "You  got $score out of $total questions correct",
                                          summaryBool: false,
                                          unAnsweredQuestion:
                                              unAnsweredQuestion,
                                          totalquestion: questionLength,
                                        );
                                      }));
                                    }
                                  } else {
                                    showToast(
                                        'Some questions are not answered');
                                  }

                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return SummaryScreen(r
                                  //     unAnsweredQuestion: unAnsweredQuestion,
                                  //     totalquestion: questionLength,
                                  //     onTaps: () async {

                                  //     },
                                  //   );
                                  // }));
                                } else {}
                              }

                              // animateToQuestion();
                              // log('selectedIndex before ${currentQuestion} \\ ${questionLength - 1}  ');
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

class QuestionAnswerWidget extends StatefulHookWidget {
  final int i;
  final ValueChanged<int> onChange;
  const QuestionAnswerWidget(
      {Key? key, required this.i, required this.onChange})
      : super(key: key);

  @override
  _QuestionAnswerWidgetState createState() => _QuestionAnswerWidgetState();
}

class _QuestionAnswerWidgetState extends State<QuestionAnswerWidget> {
  Set selected = {};
  Set selected1 = {};
  int currentindex = -1;
  bool vlaue = false;
  @override
  void initState() {
    super.initState();
    final careerProvider = context.read(carerNotifierProvider);
    if (careerProvider.textReadibility) {
      CareerPathNotificationAchievementQuestion loc = careerProvider
          .selectedAchievement
          .careerPathNotificationAchievementQuestion![widget.i];
      for (int i = 0; i < loc.options!.length; i++) {
        if (loc.careerPathNotificationAchievementAnswer!.first
                .selectedAnswerId! ==
            loc.options![i].id) {
          currentindex = i;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final careerProvider = useProvider(carerNotifierProvider);
    bool readibility = careerProvider.textReadibility;
    // String answer = readibility
    //     ? careerProvider
    //         .selectedAchievement
    //         .careerPathNotificationAchievementQuestion![widget.i]
    //         .careerPathNotificationAchievementAnswer!
    //         .first
    //         .answer
    //         .toString()
    //     : careerProvider.selectedAchievement
    //         .careerPathNotificationAchievementQuestion![widget.i].answer
    //         .toString();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              careerProvider.selectedAchievement
                  .careerPathNotificationAchievementQuestion![widget.i].question
                  .toString(),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Answer :",
              style: TextStyle(fontSize: 14, color: primarySwatch[700]),
            ),
            const SizedBox(
              height: 2,
            ),
            // TextFormField(
            //   readOnly: readibility,
            //   initialValue: answer,
            //   maxLines: 6,
            //   onChanged: widget.onchnage,
            //   style: const TextStyle(
            //     fontSize: 16,
            //   ),
            //   decoration: InputDecoration(
            //       hintText: "Enter Your Answer",
            //       hintStyle: const TextStyle(color: Colors.grey),
            //       contentPadding:
            //           const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //       isCollapsed: true,
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(5),
            //           borderSide:
            //               BorderSide(width: .5, color: primarySwatch[700]!)),
            //       enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(5),
            //           borderSide:
            //               BorderSide(width: .5, color: primarySwatch[700]!)),
            //       focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(5),
            //           borderSide:
            //               const BorderSide(width: 1, color: primaryColor))),
            // )

            Container(
              height: 68 *
                  careerProvider
                      .selectedAchievement
                      .careerPathNotificationAchievementQuestion![widget.i]
                      .options!
                      .length
                      .toDouble(),
              child: ListView.builder(
                itemCount: careerProvider
                    .selectedAchievement
                    .careerPathNotificationAchievementQuestion![widget.i]
                    .options!
                    .length,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!careerProvider.textReadibility) {
                                  widget.onChange(widget.i);
                                  careerProvider
                                          .selectedAchievement
                                          .careerPathNotificationAchievementQuestion![
                                              widget.i]
                                          .optionId =
                                      careerProvider
                                          .selectedAchievement
                                          .careerPathNotificationAchievementQuestion![
                                              widget.i]
                                          .options![index]
                                          .id;
                                  selected1.contains(index)
                                      ? selected1.remove(index)
                                      : selected1.add(index);

                                  currentindex = index;
                                  // surveyProvider.updateAnswer(widget.i,
                                  //     widget.textEditingController.text, index);
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
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Text(
                                          "${careerProvider.selectedAchievement.careerPathNotificationAchievementQuestion![widget.i].options![index].optionName}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: currentindex == index
                                                ? primarySwatch.shade900
                                                : Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Radio(
                                      groupValue: index,
                                      value: currentindex,
                                      onChanged: (val) {
                                        setState(() {
                                          if (!careerProvider.textReadibility) {
                                            widget.onChange(widget.i);
                                            selected1.contains(index)
                                                ? selected1.remove(index)
                                                : selected1.add(index);
                                            currentindex = -1;
                                            currentindex = index;
                                            careerProvider.updateAnswer(
                                                widget.i, index);
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
