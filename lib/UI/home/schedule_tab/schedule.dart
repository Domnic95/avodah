// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/schedule/schedule_model.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/home/schedule_tab/request_leave.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/utils/helpers.dart';
import 'package:southwind/utils/utilsContstant.dart';
import 'package:table_calendar/table_calendar.dart';

// final List<int> scheduleDays = [15];

class Schedule extends StatefulHookWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  // CalendarFormat style = CalendarFormat.twoWeeks;
  bool loading = true;
  DateTime currentTime = DateTime.now();
  List<Color> colorList = [Colors.green, Colors.orange, Colors.red];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initilize();
  }

  initilize() async {
    currentTime =
        DateTime(currentTime.year, currentTime.month, currentTime.day);
    await context.read(scheduleNotifierProvider).getScheduleData();
    print(Utils.getPref(key_user_token).toString());
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final _schedule_provider = useProvider(scheduleNotifierProvider);

    TextStyle defaultTextStyle =
        TextStyle(color: primarySwatch[400]!, fontSize: 14);
    final double dotWidth = 8;
    final double rowHeight = 35;
    return loading
        ? LoadingWidget()
        : SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * .78,
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Container(
                        // height: MediaQuery.of(context).size.width,
                        child: TableCalendar(
                            currentDay: currentTime,
                            onDaySelected: (d, da) {
                              setState(() {
                                currentTime = DateTime(
                                  da.year,
                                  da.month,
                                  da.day,
                                  00,
                                  00,
                                  00,
                                  000,
                                );
                              });
                            },
                            eventLoader: (da) {
                              DateTime data = DateTime(
                                  da.year, da.month, da.day, 00, 00, 00, 000);
                              // log('schedule_data = ${_schedule_provider.leaveDays_dates.contains(data)}');
                              if (_schedule_provider.schedule_dates
                                  .contains(data)) {
                                return <int>[0];
                              } else if (_schedule_provider.leaveDays_dates[0]
                                  .contains(data)) {
                                return <int>[1];
                              } else if (_schedule_provider.leaveDays_dates[1]
                                  .contains(data)) {
                                return <int>[2];
                              }
                              //  else if (_schedule_provider.leaveDays_dates[0]
                              //     .contains(data)) {
                              //  return <int>[3];
                              // }
                              else {
                                return [];
                              }
                            },
                            rangeSelectionMode: RangeSelectionMode.toggledOn,
                            // pageAnimationEnabled: false,
                            // pageJumpingEnabled: false,
                            dayHitTestBehavior: HitTestBehavior.deferToChild,
                            calendarBuilders: CalendarBuilders(
                              defaultBuilder: (con, d, data) {
                                return Container(
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                    "${d.day}",
                                    style: defaultTextStyle.copyWith(
                                        color: d.isAfter(DateTime.now())
                                            ? primarySwatch[600]
                                            : primarySwatch[300]),
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
                              outsideBuilder: (context, d, data) {
                                return Center(
                                    child: Text(
                                  "${d.day}",
                                  style: defaultTextStyle.copyWith(
                                      color: Colors.grey.withOpacity(.5)),
                                ));
                              },

                              markerBuilder: (context, d, data) {
                                if (data.isEmpty) return SizedBox();
                                // return Text(d.day.toString());
                                return Center(
                                  child: Container(
                                      height: rowHeight - 4,
                                      width: rowHeight - 4,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: colorList[
                                                int.parse(data[0].toString())],
                                            //  data[0] == 0
                                            //     ? Colors.red
                                            //     : Colors.green,
                                            width: 1.8),
                                      )
                                      // height: dotWidth,
                                      // width: dotWidth,
                                      ),
                                );
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Card(
                                    margin: EdgeInsets.all(0),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10000),
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
                              selectedBuilder: (context, d, date) {
                                return Container(
                                  color: Colors.pink,
                                  height: 10,
                                  width: 10,
                                );
                              },
                              todayBuilder: (context, d, data) {
                                return Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: primarySwatch[900]!),
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        height: rowHeight - 8,
                                        width: rowHeight - 8,
                                        decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.circular(4),
                                            shape: BoxShape.circle,
                                            color: primarySwatch[100]),
                                        child: Center(
                                          child: Text(
                                            d.day.toString(),
                                            style: defaultTextStyle.copyWith(
                                              color: primarySwatch[900],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            headerStyle: HeaderStyle(
                              headerPadding: EdgeInsets.zero,
                              titleTextStyle:
                                  Theme.of(context).textTheme.bodyText1!,
                              formatButtonVisible: false,
                              titleCentered: true,
                              // leftChevronVisible: false,
                              // rightChevronVisible: false,
                              rightChevronMargin: EdgeInsets.zero,
                              leftChevronMargin: EdgeInsets.zero,
                              leftChevronPadding: EdgeInsets.zero,
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
                              rightChevronPadding: EdgeInsets.zero,
                              headerMargin: EdgeInsets.only(bottom: 10),
                            ),
                            calendarStyle: CalendarStyle(
                              markerDecoration:
                                  BoxDecoration(color: Colors.red),
                              markerSize: 4,
                              cellPadding: EdgeInsets.zero,
                              markersAutoAligned: true,
                              // weekendTextStyle:
                              //     defaultTextStyle.copyWith(color: Colors.black),
                              // weekendDecoration: BoxDecoration(color: Colors.black),
                              holidayDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: primarySwatch[700]!)),
                              holidayTextStyle:
                                  TextStyle(color: primarySwatch[400]),
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            daysOfWeekVisible: true,
                            // holidayPredicate: (d) {
                            //   return d.day == (DateTime.now().day + 1);
                            // },
                            startingDayOfWeek: StartingDayOfWeek.sunday,
                            focusedDay: currentTime,
                            firstDay: DateTime.utc(2015),
                            lastDay: DateTime.utc(2024)),
                      ),
                    ),
                  ),
                  Expanded(
                      child: getDayCard(_schedule_provider.schedule_dates,
                          _schedule_provider.leaveDays_dates)),
                ],
              ),
            ),
          );
  }

  Widget getDayCard(
      List<DateTime> scheduleDays, List<List<DateTime>> leaveDays) {
    final provider = context.read(scheduleNotifierProvider);
    print(currentTime);
    final l = provider.scheduleModel.profileSchedules
        ?.where((element) => element.day! == currentTime)
        .toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          if ((l?.length ?? 0) > 0)
            if (l!.first.notes != "")
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Notes:",
                              style: TextStyle(fontWeight: FontWeight.w700)),
                          Text(
                            l.first.notes!,
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          //  Text(l.first.notes!),
          if (scheduleDays.contains(currentTime))
            FutureBuilder<List<int>>(
              future: provider.getSchedule(currentTime),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      for (int a in snap.data!)
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          weekDays[provider
                                              .scheduleModel
                                              .profileSchedules![a]
                                              .day!
                                              .weekday]!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        Text(
                                          (provider
                                                  .scheduleModel
                                                  .profileSchedules![a]
                                                  .day!
                                                  .day)
                                              .toString(),
                                          style: TextStyle(
                                              height: 1,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.scheduleModel
                                          .profileSchedules![a].shift!.name
                                          .toString(),
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: primarySwatch[900]),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.schedule,
                                          size: 14,
                                          color: primarySwatch[400],
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "${provider.scheduleModel.profileSchedules![a].shift!.start} - ${provider.scheduleModel.profileSchedules![a].shift!.end}",
                                          style: TextStyle(
                                              color: primarySwatch[400],
                                              fontSize: 14),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      // Expanded(
                      //   child: ListView.builder(
                      //       itemCount: snap.data!.length,
                      //       itemBuilder: (context, snapindex) {
                      //         int index = snap.data![snapindex];
                      //         return Card(
                      //           elevation: 5,
                      //           shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(10)),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Row(
                      //               children: [
                      //                 const SizedBox(
                      //                   width: 8,
                      //                 ),
                      //                 Card(
                      //                   elevation: 5,
                      //                   shape: RoundedRectangleBorder(
                      //                       borderRadius: BorderRadius.circular(5)),
                      //                   child: Container(
                      //                     height: 60,
                      //                     width: 60,
                      //                     child: Column(
                      //                       mainAxisAlignment: MainAxisAlignment.center,
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.center,
                      //                       children: [
                      //                         Text(
                      //                           weekDays[provider
                      //                               .scheduleModel
                      //                               .profileSchedules![index]
                      //                               .day!
                      //                               .weekday]!,
                      //                           style: Theme.of(context)
                      //                               .textTheme
                      //                               .bodyText1,
                      //                         ),
                      //                         Text(
                      //                           (provider
                      //                                   .scheduleModel
                      //                                   .profileSchedules![index]
                      //                                   .day!
                      //                                   .day)
                      //                               .toString(),
                      //                           style: TextStyle(
                      //                               height: 1,
                      //                               fontWeight: FontWeight.bold),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       provider.scheduleModel
                      //                           .profileSchedules![index].shift!.name
                      //                           .toString(),
                      //                       maxLines: 2,
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.w600,
                      //                           fontSize: 16,
                      //                           color: primarySwatch[900]),
                      //                     ),
                      //                     Row(
                      //                       children: [
                      //                         Icon(
                      //                           Icons.schedule,
                      //                           size: 14,
                      //                           color: primarySwatch[400],
                      //                         ),
                      //                         SizedBox(
                      //                           width: 4,
                      //                         ),
                      //                         Text(
                      //                           "${provider.scheduleModel.profileSchedules![index].shift!.start} - ${provider.scheduleModel.profileSchedules![index].shift!.end}",
                      //                           style: TextStyle(
                      //                               color: primarySwatch[400],
                      //                               fontSize: 14),
                      //                         )
                      //                       ],
                      //                     )
                      //                   ],
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         );
                      //       }),
                      // ),
                    ],
                  );
                } else {
                  return LoadingWidget();
                }
              },
            ),
          if (leaveDays[0].contains(currentTime) ||
              leaveDays[1].contains(currentTime)
          // ||leaveDays[2].contains(currentTime)
          )
            FutureBuilder<ProfileTimeOff>(
                future: provider.getLeaveData(currentTime),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          weekDays[
                                              snapshot.data!.offDay!.weekday]!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        Text(
                                          (snapshot.data!.offDay!.day)
                                              .toString(),
                                          style: TextStyle(height: 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Leave Reason",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: primarySwatch[900]),
                                          ),
                                          Text(
                                            snapshot.data!.reqMessage
                                                .toString(),
                                            style: TextStyle(
                                                color: primarySwatch[400],
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      snapshot.data!.status == 0
                                          ? Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 2, 10, 2),
                                              decoration: ShapeDecoration(
                                                color: colorList[1],
                                                shape: StadiumBorder(),
                                              ),
                                              child: Text(
                                                "Pending",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 2, 10, 2),
                                              decoration: ShapeDecoration(
                                                color: colorList[2],
                                                shape: StadiumBorder(),
                                              ),
                                              child: Text(
                                                "Approved",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: LoadingWidget(),
                    );
                  }
                }),
          if (!leaveDays[0].contains(currentTime) &&
              !leaveDays[1].contains(currentTime)
              // ||leaveDays[2].contains(currentTime)
              &&
              !scheduleDays.contains(currentTime))
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: NoScheduleWidget(),
            ),
          if (!leaveDays[0].contains(currentTime) &&
              !leaveDays[1].contains(currentTime)
              // ||leaveDays[2].contains(currentTime)
              &&
              !scheduleDays.contains(currentTime) &&
              currentTime.isAfter(DateTime.now()))
            Center(
                child: CommonButton(
              lable: "Request Leave",
              ontap: () {
                showReuestDialog(context, currentTime);
              },
            )),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class NoScheduleWidget extends StatelessWidget {
  const NoScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("No Shift or Leave Found"),
    );
  }
}

Map<int, String> weekDays = {
  1: "Mon",
  2: "Tue",
  3: "Wed",
  4: "Thu",
  5: "Fri",
  6: "Sat",
  7: "Sun"
};
