// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/team/team_member.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/login/log_in.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/utils/helpers.dart';

class AddJob extends StatefulHookWidget {
  AddJob({Key? key}) : super(key: key);

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  late String selectedJob;

  late String selectedPayment;
  late String selectedMember;
  dynamic selectedAdditionalMember;
  DateTime selectedDate = DateTime.now();
  TeamMember? selectedTeamMember;
  // List<String> typeJob = ["Residencial", "Commercial"];
  // List<String> typePayment = ["Select payment type", "Check", "Credit Card"];
  // List<String> typeMember = [
  //   "1",
  //   "2",
  //   "3",
  //   "4",
  //   "5",
  //   "6",
  //   "7",
  //   "8",
  //   "9",
  //   "10+"
  // ];
  // List<String> additionalMembers = ["Aarion Jenkins", "Aaron Hosack"];

  TextEditingController jobIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController creditTipController = TextEditingController();
  TextEditingController myCreditTipController = TextEditingController();
  TextEditingController totalJobRevenue = TextEditingController();
  TextEditingController myJobRevenue = TextEditingController();
  TextEditingController additionalMyJobRevenue = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final jobsService = context.read(jobsNotifierProvider);
    selectedJob = jobsService.typeJob.first;
    selectedPayment = jobsService.typePayment.first;
    selectedMember = jobsService.typeMember.first;
    dateController.text =
        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    setState(() {});
  }

  calcualteRevenue() {
    myJobRevenue.text =
        (double.parse(totalJobRevenue.text) / int.parse(selectedMember))
            .toString();
    additionalMyJobRevenue.text = myJobRevenue.text;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final jobsService = useProvider(jobsNotifierProvider);

    double ver = 15;
    return Scaffold(
      appBar: CommonAppbar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
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
                  height: ver,
                ),
                EditTextfild(
                  controller: jobIdController,
                  hint: "Enter Job Id",
                ),
                SizedBox(
                  height: ver,
                ),
                DropDownWidget(
                  labelTitle: "Job type",
                  onChanged: (c) {
                    setState(() {
                      selectedJob = c!;
                    });
                  },
                  title: jobsService.typeJob,
                  selectedvalue: selectedJob,
                ),
                SizedBox(
                  height: ver,
                ),
                EditTextfild(
                  controller: creditTipController,
                  hint: "Enter my credit card tip",
                ),
                SizedBox(
                  height: ver,
                ),
                EditTextfild(
                  onChnage: (c) {
                    calcualteRevenue();
                  },
                  controller: totalJobRevenue,
                  hint: "Enter total job revenue",
                ),

                SizedBox(
                  height: ver,
                ),

                DropDownWidget(
                  labelTitle: "Number of team member",
                  onChanged: (c) {
                    setState(() {
                      selectedMember = c!;
                    });
                    calcualteRevenue();
                  },
                  title: jobsService.typeMember,
                  selectedvalue: selectedMember,
                ),
                SizedBox(
                  height: ver,
                ),
                EditTextfild(
                  controller: myJobRevenue,
                  hint: "Enter my job revenue",
                ),
                SizedBox(
                  height: ver,
                ),
                DropDownWidget(
                  labelTitle: "Payment type",
                  onChanged: (c) {
                    setState(() {
                      selectedPayment = c!;
                    });
                  },
                  title: jobsService.typePayment,
                  selectedvalue: selectedPayment,
                ),

                // SizedBox(
                //   height: ver,
                // ),

                if (selectedMember == "2" && jobsService.teamMembers.length > 0)
                  Column(
                    children: [
                      SizedBox(
                        height: ver,
                      ),
                      InkWell(
                        onTap: () async {
                          print("aa");
                          final res = await showSearch<TeamMember>(
                              context: context,
                              delegate: CustomSearchDeleget(
                                jobsService.teamMembers,
                              ));
                          if (res != null) {
                            setState(() {
                              selectedTeamMember = res;
                            });
                          }
                          print(res);
                        },
                        child: Container(
                          // color: Colors.pink,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  selectedTeamMember?.profileFirstName ??
                                      "Select Team Member",
                                  style: TextStyle(
                                      color: selectedTeamMember == null
                                          ? Colors.grey[500]
                                          : Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // InkWell(
                      //   onTap: (){
                      //       print("aa");
                      //   },
                      //   child: DropDownWidget2(
                      //     labelTitle: "Additional team member",
                      //     onChanged: (c) {
                      //       setState(() {
                      //         selectedAdditionalMember = c!;
                      //       });
                      //     },
                      //     title: jobsService.teamMembers.map((e) => DropDownItemModal(label: e.profileFirstName.toString(),val: e.id)).toList(),
                      //     selectedvalue: selectedAdditionalMember != null ? selectedAdditionalMember : jobsService.teamMembers.first.id,
                      //   ),
                      // ),
                      SizedBox(
                        height: ver,
                      ),
                      EditTextfild(
                        controller: additionalMyJobRevenue,
                        hint: "Additional my job revenue",
                      ),
                    ],
                  ),
                SizedBox(
                  height: ver,
                ),
                InkWell(
                  onTap: () async {
                    _AddJob();
                  },
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Add Job',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(),
                //     onPressed: () {},
                //     child: Text('Add Job'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _AddJob() async {
    final job = context.read(jobsNotifierProvider);
    if (jobIdController.text.isEmpty) {
      showToast("Enter Job Id");
      return;
    }
    if (creditTipController.text.isEmpty) {
      showToast("Enter credit trips");
      return;
    }
    if (selectedPayment == job.typePayment.first) {
      showToast("Select payment type");
      return;
    }
    if (selectedMember == "2" && selectedTeamMember == null) {
      showToast("Select aditional member");
      return;
    }
    if (totalJobRevenue.text.isEmpty) {
      showToast("Enter revenue");
    }

    final res = await job.createJob(
      jobid: jobIdController.text,
      teamMemberId: (context.read(authProvider).userData?.id).toString(),
      jobType: selectedJob,
      cardTips: creditTipController.text,
      date: dateController.text,
      paymentType: selectedPayment,
      numberOfMember: int.parse(selectedMember),
      totalRevenue: double.parse(totalJobRevenue.text),
      myRevenue: double.parse(myJobRevenue.text),
      adiitionMemberId:
          selectedTeamMember == null ? null : selectedTeamMember!.id,
      aditionRevenue: additionalMyJobRevenue.text,
    );
    // await jobsService.addService(
    //     job_id: jobIdController.text,
    //     team_member: selectedMember,
    //     job_type: selectedJob,
    //     job_date: dateController.text,
    //     my_credit_card_tip: myCreditTipController.text,
    //     total_job_revenue: totalJobRevenue.text,
    //     number_of_team_member: selectedMember,
    //     additional_team_member: selectedAdditionalMember,
    //     additional_my_job_revenue: additionalMyJobRevenue.text,
    //     payment_type: selectedPayment);
    if (res) {
      showToast("Add sucessfully");
      Navigator.pop(context);
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        dateController.text =
            "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      });
  }
}

class CustomSearchDeleget extends SearchDelegate<TeamMember> {
  List<TeamMember> members;
  CustomSearchDeleget(this.members);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [Text("a")];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print("Result");

    final list = members
        .where((element) => element.profileFirstName!
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    if (list.isEmpty) {
      return Text("No match found");
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              Navigator.pop(context, list[index]);
            },
            child: getSingleResult(list[index]));
      },
      itemCount: list.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final list = members
        .where((element) => element.profileFirstName!
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    if (list.isEmpty) {
      return Text("No match found");
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pop(context, list[index]);
          },
          child: getSingleResult(list[index]),
        );
      },
      itemCount: list.length,
    );
  }

  Widget getSingleResult(TeamMember member) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
          member.profileFirstName! + "  " + member.profileLastName.toString()),
    );
  }
}
