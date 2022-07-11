// import 'package:flutter/material.dart';
// import 'package:YouMoveMe/UI/components/common_appbar.dart';
// import 'package:YouMoveMe/UI/components/common_button.dart';
// import 'package:YouMoveMe/UI/home/career_tab/components/chart.dart';
// import 'package:YouMoveMe/UI/home/career_tab/page/congratsScreen.dart';
// import 'package:YouMoveMe/UI/theme/apptheme.dart';
// import 'package:YouMoveMe/routes/routes.dart';

// import 'congratspage.dart';

// class SummaryTab extends StatelessWidget {
//   int totalquestion;
//   SummaryTab({Key? key, required this.totalquestion}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final double radius = 20;
//     return Scaffold(
//       appBar: CommonAppbar(),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Card(
//               elevation: 5,
//               child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Container(
//                   child: Row(
//                     children: [
//                       SingleChart(),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Summary",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 20),
//                           ),
//                           Text(
//                             "Total Questions : ${totalquestion}",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 14),
//                           ),
//                           Text(
//                             "Answered Questions : 8",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 14),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18),
//             child: Text(
//               data,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText2!
//                   .copyWith(color: Colors.black),
//               textAlign: TextAlign.justify,
//             ),
//           ),
//           Spacer(),
//           Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.grey,
//                       offset: Offset(0, -1),
//                       blurRadius: 10,
//                       spreadRadius: 0)
//                 ],
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(radius),
//                   topRight: Radius.circular(radius),
//                 )),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
//               child: Row(
//                 children: [
//                   CommonButton(
//                     isExpanded: true,
//                     ontap: () {
//                       Navigator.pushNamed(context, Routes.congrat_Tab);
//                     },
//                     lable: "Submit",
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// final data =
//     '''You have no view on the whole life cycle of your application, only on the value of a variable at a given time or the assurance or not that your code is following its logical flow. It often happens that console.log are forgotten in several places in the code, which besides a hypothetical loss of performance (tiny, but whose size varies according to the data called through the log method), is not very clean.''';
