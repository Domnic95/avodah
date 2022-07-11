import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/incentives/page/earned_incentive.dart';
import 'package:southwind/UI/incentives/page/usedIncentive.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';

class History extends StatefulHookWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int selectedIndex = 0;
  List<String> tabs = [
    'EARNED',
    'USED',
  ];
  @override
  Widget build(BuildContext context) {
    final incentiveProvider = useProvider(incentiveNotifierProvider);
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppbar(),
        body: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
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
                    Icon(
                      Icons.history,
                      size: 50,
                      color: Colors.white,
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
                        Text(
                          "TOKEN HISTORY",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Tokens Earned: 326",
                          style: TextStyle(
                            // fontSize: 18,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Tokens Used: 76",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                for (int i = 0; i < tabs.length; i++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(1000),
                        onTap: () {
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
                              child: Center(
                                child: Text(
                                  tabs[i],
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: selectedIndex != i
                                      ? TextStyle(
                                          color: primarySwatch[900],
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)
                                      : TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                ),
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
                  child: FutureBuilder(
                      future: incentiveProvider.incentiveEarned(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                              itemCount:
                                  incentiveProvider.earnedIncentiveList.length,
                              itemBuilder: (context, index) {
                                return EarnedIncentive(
                                  earned: incentiveProvider
                                      .earnedIncentiveList[index],
                                );
                              });
                        } else {
                          return LoadingWidget();
                        }
                      })),
            if (selectedIndex == 1)
              Expanded(
                  child: FutureBuilder(
                      future: incentiveProvider.usedIncentive(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Used_Incentive(
                                usedIncentive:
                                    incentiveProvider.usedIncentiveList[index],
                              );
                            },
                          );
                        } else {
                          return LoadingWidget();
                        }
                      })),
          ],
        ),
      ),
    );
  }
}
