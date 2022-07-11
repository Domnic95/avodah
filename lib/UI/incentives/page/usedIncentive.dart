import 'package:flutter/material.dart';
import 'package:southwind/Models/Incentive/usedIncentive.dart';

class Used_Incentive extends StatelessWidget {
  UsedIncentive usedIncentive;
  Used_Incentive({
    required this.usedIncentive,
  });

  @override
  Widget build(BuildContext context) {
    String time =
        "${usedIncentive.dateUsed!.day}/ ${usedIncentive.dateUsed!.month}/${usedIncentive.dateUsed!.year}";
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        title: Text(
          usedIncentive.incentiveTitle!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              "TOKENS: ${usedIncentive.incentiveBadge!} \t\t ${time}",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class Earned {
  String title;
  int tokens;
  String date;

  Earned({required this.title, required this.tokens, required this.date});
}

List<Earned> Earneds = [
  Earned(
      title:
          "Basic Knowledge of city resources, offload sites and restrictions",
      tokens: 4,
      date: "21/01/2020"),
  Earned(title: "test1", tokens: 5, date: "18/12/2019"),
  Earned(title: "7 september first", tokens: 5, date: "26/11/2019"),
  Earned(title: "Exercise QFAs routinely", tokens: 2, date: "26/11/2019"),
  Earned(
      title: "Understands REEAP and executes consistently",
      tokens: 11,
      date: "26/11/2019"),
  Earned(title: "30 september", tokens: 2, date: "09/10/2019"),
  Earned(title: "11", tokens: 6, date: "09/10/2019"),
  Earned(title: "test 2510 - 1", tokens: 17, date: "09/10/2019"),
  Earned(title: "testing", tokens: 20, date: "09/10/2019"),
  Earned(title: "300", tokens: 10, date: "009/10/2019"),
  Earned(title: "Test Career path 2910", tokens: 10, date: "09/10/2019"),
  Earned(title: "Communicating with Ops", tokens: 17, date: "09/10/201"),
];
