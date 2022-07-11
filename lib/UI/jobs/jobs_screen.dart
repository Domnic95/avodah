// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/jobs/job_modal.dart';
import 'package:southwind/UI/jobs/components/add_jobScreen.dart';
import 'package:southwind/UI/login/log_in.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/jobsService.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';
import 'package:southwind/utils/helpers.dart';

class JobScreen extends StatefulHookWidget {
  JobScreen({Key? key}) : super(key: key);

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  List<String> tabs = ["Today's Jobs", "Archive"];
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read(jobsNotifierProvider).fetchTodaysJob();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = 8.0;
    final jobService = useProvider(jobsNotifierProvider);
   
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            height: 55,
            // width: 300,
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: Row(
                children: [
                  Column(
                    children: [
                      if (selectedIndex == 0 && jobService.todaysMyJob == null)
                        Text("0.00")
                      else
                        selectedIndex == 0 && jobService.todaysMyJob != null
                            ? Text(jobService.todaysMyJob!.myRevShare!)
                            : jobService.archeive != null
                                ? Text(jobService.archeive!.myRevShare!)
                                : Text("0.00"),
                      Text(
                        'Total Profit Share',
                        style: TextStyle(fontSize: 9),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      if (selectedIndex == 0 && jobService.todaysMyJob == null)
                        Text("0.00")
                      else
                        selectedIndex == 0 && jobService.todaysMyJob != null
                            ? Text(jobService.todaysMyJob!.totalTip!)
                            : jobService.archeive != null
                                ? Text(jobService.archeive!.totalTip!)
                                : Text("0.00"),
                    Text(
                        'TIP',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
              backgroundColor: primarySwatch[700],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: selectedIndex != i
                                    ? TextStyle(
                                        color: primarySwatch[900],
                                        fontWeight: FontWeight.bold,
                                      )
                                    : TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
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
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  const TodaysJobWidget(),
                  const PastJobs(),
                ],
              ),
            ),
            // Expanded(child:selectedIndex == 0 ?  TodaysJobWidget() : PastJobs()),
            // Container(
            //   height: 50,
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemExtent: (size.width - padding) / 2,
            //       itemCount: titleList.length,
            //       itemBuilder: (context, index) {
            //         return Padding(
            //           padding: EdgeInsets.symmetric(horizontal: padding),
            //           child: InkWell(
            //             onTap: () {
            //               setState(() {
            //                 jobIndex = index;
            //               });
            //             },
            //             child: Container(
            //               width: (size.width - padding) / 2,
            //               decoration: BoxDecoration(
            //                   color: jobIndex == index
            //                       ? primarySwatch[700]
            //                       : Colors.transparent,
            //                   border: Border.all(color: primaryColor),
            //                   borderRadius: BorderRadius.circular(10)),
            //               child: Center(
            //                   child: Text(
            //                 titleList[index],
            //                 style: TextStyle(
            //                     color: jobIndex == index
            //                         ? Colors.white
            //                         : primarySwatch[700]),
            //               )),
            //             ),
            //           ),
            //         );
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}

class PastJobs extends StatefulHookWidget {
  const PastJobs({Key? key}) : super(key: key);

  @override
  _PastJobsState createState() => _PastJobsState();
}

class _PastJobsState extends State<PastJobs> {
  final dateController = TextEditingController();
  _selectDate(BuildContext context) async {
    DateTime time = DateTime.now();
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.utc(time.year, time.month, time.day)
          .subtract(Duration(days: 1)),
    );

    if (selected != null) {
      selectedDate = selected;
      context.read(jobsNotifierProvider).fetchPastJobs(selectedDate);
      dateController.text = DateToYYMMDD(selectedDate);
    }
    // if (selected != null && selected != selectedDate)
    //   setState(() {
    //     selectedDate = selected;
    //     dateController.text =
    //         "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    //   });
  }

  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    selectedDate = selectedDate.subtract(Duration(days: 1));
    context.read(jobsNotifierProvider).fetchPastJobs(selectedDate);
    dateController.text = DateToYYMMDD(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final jobService = useProvider(jobsNotifierProvider);
    return Column(
      children: [
        EditTextfild(
          readibility: true,
          suffixicon: InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Icon(Icons.calendar_today)),
          controller: dateController,
          hint: "Select job date",
        ),
        SizedBox(
          height: 10,
        ),
        if (jobService.archeive != null)
          Card(
            color: primarySwatch[700],
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "AJS",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white, height: 1),
                            ),

                            // Text("Average Job Size",style: TextStyle(fontSize: 8,color: Colors.white),),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              (double.parse(jobService
                                          .archeive!.totalMyJobRevenue!) ~/
                                      jobService.archeive!.jobsCount!)
                                  .toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "MTR",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white, height: 1),
                            ),
                            // Text("Revenue",style: TextStyle(fontSize: 8,color: Colors.white),),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                                (jobService.archeive!.totalMyJobRevenue!)
                                    .toString(),
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "REV",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white, height: 1),
                            ),
                            //Text("Revenue",style: TextStyle(fontSize: 8,color: Colors.white),),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              jobService.archeive!.totalJobRevenue.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "RPH",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white, height: 1),
                            ),
                            // Text("Revenue Per Hour",style: TextStyle(fontSize: 8,color: Colors.white),),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              jobService.archeive!.revenuePerHour.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        Expanded(
          child: jobService.archeive == null
              ? Container(
                  child: Center(
                    child: Text("No Job found"),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return SingleJobCard(
                        jobModal: jobService.archeive!.jobs![index]);
                  },
                  itemCount: jobService.archeive!.jobs!.length,
                  padding: EdgeInsets.only(bottom: 50),
                ),
        ),
      ],
    );
  }
}

class TodaysJobWidget extends StatefulHookWidget {
  const TodaysJobWidget({Key? key}) : super(key: key);

  @override
  State<TodaysJobWidget> createState() => _TodaysJobWidgetState();
}

class _TodaysJobWidgetState extends State<TodaysJobWidget> {
  @override
  void initState() {
    super.initState();
    print("init state called");
  }

  @override
  Widget build(BuildContext context) {
    print("build method called");
    final jobService = useProvider(jobsNotifierProvider);
    // log("data found"+ jobService.todaysJob.length.t);

    if (jobService.todaysMyJob == null) {
      return Center(child: Text("No Job found"));
    }
    // print("job data " + jobService.todaysMyJob!.totalJobRevenue.toString());
    final todaysJob = jobService.todaysMyJob!.jobs!;
    return Column(
      children: [
        Card(
          color: primarySwatch[700],
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "AJS",
                            style: TextStyle(
                                fontSize: 14, color: Colors.white, height: 1),
                          ),

                          // Text("Average Job Size",style: TextStyle(fontSize: 8,color: Colors.white),),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            (double.parse(jobService
                                        .todaysMyJob!.totalMyJobRevenue!) ~/
                                    jobService.todaysMyJob!.jobsCount!)
                                .toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "MTR",
                            style: TextStyle(
                                fontSize: 14, color: Colors.white, height: 1),
                          ),
                          // Text("Revenue",style: TextStyle(fontSize: 8,color: Colors.white),),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            (jobService.todaysMyJob!.totalMyJobRevenue)
                                .toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "REV",
                            style: TextStyle(
                                fontSize: 14, color: Colors.white, height: 1),
                          ),
                          // Text("Revenue",style: TextStyle(fontSize: 8,color: Colors.white),),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            jobService.todaysMyJob!.totalJobRevenue.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "RPH",
                            style: TextStyle(
                                fontSize: 14, color: Colors.white, height: 1),
                          ),
                          // Text("Revenue Per Hour",style: TextStyle(fontSize: 8,color: Colors.white),),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            jobService.todaysMyJob!.revenuePerHour.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return SingleJobCard(
                jobModal: todaysJob[index],
              );
            },
            itemCount: todaysJob.length,
            padding: EdgeInsets.only(bottom: 100),
          ),
        ),
      ],
    );
  }
}

class SingleJobCard extends StatelessWidget {
  final JobModal jobModal;
  const SingleJobCard({required this.jobModal, Key? key}) : super(key: key);
  Widget getKeyValue(String label, String value, {String? fullForm}) {
    return Flexible(
        flex: 1,
        child: Center(
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 16, height: 1),
              ),
              // if (fullForm != null)
              //   Text(
              //     fullForm.toString(),
              //     style: TextStyle(fontSize: 8),
              //   ),
              SizedBox(
                height: 2,
              ),
              Text(
                value,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 14);
    final valueStyle = TextStyle(fontSize: 10);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 2),
        child: Container(
          child: Row(
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Column(
              //         children: [
              //           Text("JI",style: TextStyle(fontSize: 14,height: 1),),
              //            Text("Job Id",style: TextStyle(fontSize: 8),),
              //            SizedBox(height: 2,),
              //           Text(jobModal.title.toString()),
              //         ],
              //       ),
              // ),
              getKeyValue(
                "ID",
                jobModal.title.toString(),
                fullForm: "Job Id",
              ),
              // getKeyValue(
              //   "Total MTR",
              //   jobModal.myJobRevenue.toString(),
              //   fullForm: "My Total Revenue",
              // ),
              getKeyValue(
                "REV",
                jobModal.totalJobRevenue.toString(),
                fullForm: "My Total Revenue",
              ),
              SizedBox(
                width: 6,
              ),
              getKeyValue(
                "TIP",
                jobModal.myCreditCardTip.toString(),
                fullForm: "Total Revenue",
              ),
              // getKeyValue("RPH",jobModal.revenuePerHour.toString(),fullForm: "Rev Per Hour"),
              // getKeyValue("AJS",jobModal.AJS.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
