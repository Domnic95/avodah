import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/career/careerModel.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/home/career_tab/components/careerPathBottomSheet.dart';
import 'package:southwind/UI/home/career_tab/components/career_sub_tabs.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';

class CareerTab extends StatefulHookWidget {
  const CareerTab({Key? key}) : super(key: key);

  @override
  State<CareerTab> createState() => _CareerTabState();
}

class _CareerTabState extends State<CareerTab> {
  List<String> tabs = ['Career', 'Submitted', 'Completed'];
  int selectedIndex = 0;
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await context.read(carerNotifierProvider).getCareerQuestion();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final careerProvider = useProvider(carerNotifierProvider);
    return loading
        ? LoadingWidget()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  for (int i = 0; i < tabs.length; i++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(1000),
                          onTap: () async {
                            if (i == 0) {
                              await careerProvider.setReadibility(false);
                            } else {
                              await careerProvider.setReadibility(true);
                            }
                            setState(() {
                              selectedIndex = i;
                            });
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: selectedIndex == i ? 10 : 0,
                            borderRadius: BorderRadius.circular(1000),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedIndex == i
                                      ? primarySwatch[700]
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: primarySwatch[900]!, width: .5)),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Text(
                                  tabs[i],
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: selectedIndex != i
                                      ? TextStyle(
                                          color: primarySwatch[900],
                                          fontWeight: FontWeight.bold)
                                      : TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (selectedIndex == 0)
                Expanded(
                    child: CareerPath(
                  achievement: careerProvider.newAchievement,
                  pageIndex: selectedIndex,
                )),
              if (selectedIndex == 1)
                Expanded(
                    child: CareerPath(
                  achievement: careerProvider.submittedAchievement,
                  pageIndex: selectedIndex,
                )),
              if (selectedIndex == 2)
                Expanded(
                    child: CareerPath(
                  achievement: careerProvider.completedAchievement,
                  pageIndex: selectedIndex,
                )),
            ],
          );
  }
}

class CareerPath extends StatefulHookWidget {
  List<CareerAchievement> achievement;
  int pageIndex;
  CareerPath({required this.achievement, required this.pageIndex, Key? key})
      : super(key: key);

  @override
  _CareerPathState createState() => _CareerPathState();
}

class _CareerPathState extends State<CareerPath> {
  bool loading = true;
  loadData() async {
    await context.read(carerNotifierProvider).getCareerQuestion();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final careerProvider = useProvider(carerNotifierProvider);
    // careerProvider.getAchievementWisely();
    // print('asd' +
    //     careerProvider.careerModel
    //         .careerAchievements![careerProvider.selectedCareerPath.id]!.length
    //         .toString());
    print(careerProvider.selectedCareerPathIndex);
    int totalQuestion = careerProvider.allSelectedCareerPath.length;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child:RefreshIndicator(
                  displacement:55,
                    onRefresh: () async {
                      await loadData();
                    },
                    child:  
      Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => CareerpathBottomSheet());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF53ac54),

                      // color: Color(0xFF25AA25),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          "assets/images/premiumquality.png",
                          height: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: .5,
                          height: 55,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.pageIndex == 0)
                              Text(
                                "${careerProvider.newAchievement.length} STEPS LEFT",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            if (widget.pageIndex == 1)
                              Text(
                                "${careerProvider.submittedAchievement.length} / ${totalQuestion} Reviewed",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            if (widget.pageIndex == 2)
                              Text(
                                "${careerProvider.completedAchievement.length} / ${totalQuestion} Reviewed",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            Row(
                              children: [
                                Text(
                                  careerProvider.selectedCareerPath.name
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // SingleCollection(
              //   careerModel: careerProvider.careerModel,
              //   index: index,
              // ),
            ],
          ),
          Expanded(
            child: widget.achievement.length > 0
                ? ListView.builder(
                      padding: EdgeInsets.only(top: 0, bottom: 60),
                      itemBuilder: (context, index) {
                        return SingleCollection(
                          achievement: widget.achievement[index],
                          index: index,
                          pageIndex: widget.pageIndex,
                        );
                      },
                      itemCount: widget.achievement.length,
                    )
                  
                : Center(
                    child: Text('No data found'),
                  ),
          ),
        ],
      )),
    );
  }
}

//
class SingleCollection extends HookWidget {
  int pageIndex;
  CareerAchievement achievement;
  int index;
  SingleCollection(
      {required this.pageIndex,
      required this.achievement,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final careerProvider = context.read(carerNotifierProvider);

    // length = careerProvider
    //     .selectedAchievement.careerPathNotificationAchievementQuestion!.length;

    // careerProvider.careerModel.questions![careerProvider.selectedCareerPath.id.toString()]![achievement.id.toString()]!.length
    final double radius = 12;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () {
          // if (pageIndex == 0)
          careerProvider.setAchievement(achievement);
          Navigator.pushNamed(
            context,
            Routes.QuestionPage,
          );
        },
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            decoration: BoxDecoration(
                // color: primarySwatch[100],
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: primaryColor, width: .5)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: ListTile(
                title: Text(
                  achievement.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: primarySwatch[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: primarySwatch[900],
                ),
                subtitle: Text(
                  // careerModel
                  //         .questions![
                  //             careerModel.careerPath![index].id.toString()]!
                  //         .length
                  //         .toString() +
                  " ${achievement.careerPathNotificationAchievementQuestion!.length} Question",
                  style: TextStyle(color: primarySwatch[500]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
