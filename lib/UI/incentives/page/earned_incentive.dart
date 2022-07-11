import 'package:flutter/material.dart';
import 'package:southwind/Models/Incentive/EarnedIncentive.dart';

class EarnedIncentive extends StatelessWidget {
  BadgesEarned earned;
  EarnedIncentive({required this.earned});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        title: Text(
          earned.title.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              "TOKENS: ${earned.badges}",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
