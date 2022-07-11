import 'package:flutter/material.dart';
import 'package:southwind/UI/home/clock_in_out/clock_in_out.dart';
import 'package:southwind/UI/home/clock_in_out/work_history.dart';
import 'package:southwind/UI/theme/apptheme.dart';

class TimeCardScreen extends StatelessWidget {
  const TimeCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: "Work History",
                ),
                Tab(
                  text: "Clock in / out",
                ),
              ],
              labelStyle: TextStyle(
                  color: primarySwatch[900], fontWeight: FontWeight.bold),
              labelColor: primarySwatch[900],
            ),
            Expanded(
                child: TabBarView(children: [WorkHistory(), ClockInOut()])),
          ],
        ));
  }
}
