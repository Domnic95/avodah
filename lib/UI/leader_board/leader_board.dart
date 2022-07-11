// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:southwind/Models/LeaderBoard/AllLeaderBoard.dart';
import 'package:southwind/Models/team/team.dart';

import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';

class LeaderBoard extends StatefulHookWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  int value = 0;
  int teamIndex = 0;
  String dropdownValue = 'One';
  bool isDropdownOpened = false;
  bool showsecondpop = false;
  List<String> tabs = ['Revenue', 'AJS', 'R.Hour', 'NPS'];
  int selectedIndex = 0;
  String currentValue = 'Southwind';
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await context.read(leaderBoardNotifierProvider).initialize();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _leaderBoardProvider = useProvider(leaderBoardNotifierProvider);
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "LEADERBOARD",
      //     style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
      //   ),
      //   actions: [
      //     Container(margin: EdgeInsets.only(right: 15), child: Icon(Icons.menu))
      //   ],
      // ),
      body: !_leaderBoardProvider.isDataSet
          ? Center(
              child: Text('No Data Available'),
            )
          : loading
              ? LoadingWidget()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 18),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: primarySwatch[900]!),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: Container(),
                            items: _leaderBoardProvider.teamList
                                .map((e) => DropdownMenuItem(
                                      child: Text(e.toString()),
                                      value: e,
                                    ))
                                .toList(),
                            value: currentValue,
                            onChanged: (v) {
                              currentValue = v!;
                              teamIndex = _leaderBoardProvider.teamList
                                  .indexOf(currentValue);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                    // ExpansionTile(
                    //   onExpansionChanged: (v) {
                    //     setState(() {});
                    //   },
                    //   title: Text(
                    //     "revenue".toUpperCase(),
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       letterSpacing: 1,
                    //     ),
                    //   ),
                    //   children: [
                    //     RadioListTile(
                    //       value: 1,
                    //       groupValue: value,
                    //       onChanged: (val) {
                    //         setState(
                    //           () {
                    //             value != val;
                    //           },
                    //         );
                    //       },
                    //       title: Text("Male"),
                    //     ),
                    //     RadioListTile(
                    //       value: 2,
                    //       groupValue: value,
                    //       onChanged: (val) {
                    //         setState(
                    //           () {
                    //             value != val;
                    //           },
                    //         );
                    //       },
                    //       title: Text("Female"),
                    //     ),
                    //   ],
                    // ),
                    Expanded(
                      child: _leaderBoardProvider.isDataSet == false
                          ? LoadingWidget()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      for (int i = 0; i < tabs.length; i++)
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 10),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(1000),
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = i;
                                                  showsecondpop =
                                                      !showsecondpop;
                                                });
                                              },
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation:
                                                    selectedIndex == i ? 10 : 0,
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: selectedIndex == i
                                                          ? primarySwatch[700]
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: primarySwatch[
                                                              900]!,
                                                          width: .5)),
                                                  child: Center(
                                                      child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    child: Text(
                                                      tabs[i],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: selectedIndex != i
                                                          ? TextStyle(
                                                              color:
                                                                  primarySwatch[
                                                                      900],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)
                                                          : TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  // if (selectedIndex == 0)
                                  if (selectedIndex == 0)
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: _leaderBoardProvider
                                              .teamLeaderBoard[teamIndex]
                                              .revenue!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return LeaderBoardCard(
                                              index: index,
                                              leaderDetail: _leaderBoardProvider
                                                  .teamLeaderBoard[teamIndex]
                                                  .revenue![index],
                                            );
                                          }),
                                    ),
                                  if (selectedIndex == 1)
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: _leaderBoardProvider
                                              .teamLeaderBoard[teamIndex]
                                              .ajs!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return LeaderBoardCard(
                                              index: index,
                                              leaderDetail: _leaderBoardProvider
                                                  .teamLeaderBoard[teamIndex]
                                                  .ajs![index],
                                            );
                                          }),
                                    ),
                                  if (selectedIndex == 2)
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: _leaderBoardProvider
                                              .teamLeaderBoard[teamIndex]
                                              .revenuePerHour!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return LeaderBoardCard(
                                              index: index,
                                              leaderDetail: _leaderBoardProvider
                                                  .teamLeaderBoard[teamIndex]
                                                  .revenuePerHour![index],
                                            );
                                          }),
                                    ),
                                  if (selectedIndex == 3)
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: _leaderBoardProvider
                                              .teamLeaderBoard[teamIndex]
                                              .nps!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return LeaderBoardCard(
                                              index: index,
                                              leaderDetail: _leaderBoardProvider
                                                  .teamLeaderBoard[teamIndex]
                                                  .nps![index],
                                            );
                                          }),
                                    )

                                  //   ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
    ));
  }
}

class LeaderBoardCard extends StatelessWidget {
  LeaderDetail leaderDetail;
  int index;
  LeaderBoardCard({required this.leaderDetail, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              "${index + 1}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${leaderDetail.employee}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                if (leaderDetail.team!.isNotEmpty)
                  Text(
                    leaderDetail.team.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Colors.grey, height: 1, fontSize: 14),
                  )
              ],
            ),
            Spacer(),
            Row(
              children: [
                // Icon(
                //   Icons.attach_money,
                //   size: 16,
                // ),
                Text(
                  leaderDetail.price.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      // child: ListTile(
      //   horizontalTitleGap: 0,
      //   leading: Text("${index + 1}"),
      // title: Text(
      //   "${Revenuelist[index].title}",
      //   style: TextStyle(
      //       fontWeight: FontWeight.w600, fontSize: 14),
      // ),
      //   subtitle: Text("${Revenuelist[index].subtitle}"),
      //   trailing: Container(
      //     width: 100,
      // child: Row(
      //   children: [
      //     Icon(Icons.attach_money),
      //     Text(
      //       "${Revenuelist[index].income}",
      //       style: TextStyle(
      //           fontWeight: FontWeight.bold),
      //     )
      //   ],
      // ),
      //   ),
      // ),
    );
  }
}
