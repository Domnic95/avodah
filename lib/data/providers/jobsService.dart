import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:southwind/Models/jobs/job_modal.dart';
import 'package:southwind/Models/jobs/my_job_modal.dart';
import 'package:southwind/Models/team/team_member.dart';
import 'package:southwind/data/http_client/dio_client.dart';
import 'package:southwind/data/providers/base_notifer.dart';
import 'package:southwind/utils/helpers.dart';

class JobsService extends BaseNotifier {
  JobsService() {
    loadTeamMember();
    fetchTodaysJob();
  }
  List<String> typeJob = ["Residential", "Commercial"];
  List<String> typePayment = ["Select payment type", "Check", "Credit Card"];
  List<String> typeMember = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10+"
  ];
  List<String> additionalMembers = ["Aarion Jenkins", "Aaron Hosack"];
  List<TeamMember> teamMembers = [];
  MyJobs? todaysMyJob;
  MyJobs? archeive;

  List<JobModal> todaysJob = [];
  List<JobModal> pastJobs = [];
  Future loadTeamMember() async {
    final response = await dioClient.getRequest(apiEnd: api_teamMember);
    if (response is Response) {
      if (response.statusCode == 200) {
        teamMembers = (response.data["team_members"] as List)
            .map((e) => TeamMember.fromJson(e))
            .toList();
      }
      notifyListeners();
    }
  }

  Future addService({
    required String job_id,
    required String team_member,
    required String job_type,
    required String job_date,
    required String my_credit_card_tip,
    required String total_job_revenue,
    required String number_of_team_member,
    required String additional_team_member,
    required String additional_my_job_revenue,
    required String payment_type,
  }) async {
    Map<String, dynamic> data = {
      "job_id": job_id,
      "team_member": team_member,
      "job_type": job_type == typeJob.first ? 1 : 2,
      "job_date": job_date,
      "my_credit_card_tip": my_credit_card_tip,
      "total_job_revenue": total_job_revenue,
      "my_job_revenue": 1500,
      "number_of_team_member": number_of_team_member,
      if (additional_team_member == "2")
        "additional_team_member": additional_team_member,
      if (additional_team_member == "2")
        "additional_my_job_revenue": additional_my_job_revenue,
      if (payment_type == typePayment.first)
        "payment_type": payment_type == typePayment.first ? 1 : 2,
    };
    log(data.toString());
    // await dioClient.postWithFormData(apiEnd: api_addPost, data: data);
    // notifyListeners();
  }

  Future<bool> createJob({
    required String jobid,
    required String teamMemberId,
    required String jobType,
    required String date,
    required String cardTips,
    required double totalRevenue,
    required double myRevenue,
    required int numberOfMember,
    int? adiitionMemberId,
    required String aditionRevenue,
    required String paymentType,
  }) async {
    Map<String, dynamic> data = {
      "job_id": jobid,
      "team_member": teamMemberId,
      "job_type": jobType == typeJob.first ? 1 : 2,
      "job_date": date,
      "my_credit_card_tip": cardTips,
      "total_job_revenue": totalRevenue,
      "my_job_revenue": myRevenue,
      "number_of_team_member": numberOfMember,
      if (numberOfMember == 2) "additional_team_member": adiitionMemberId,
      if (numberOfMember == 2) "additional_my_job_revenue": aditionRevenue,
      if (paymentType != typePayment[0])
        "payment_type": paymentType == typePayment[1] ? 1 : 2,
    };
    final res =
        await dioClient.postWithFormData(apiEnd: api_addPost, data: data);
    print("ressss" + data.toString());
    if (res is Response) {
      print(res.data.toString());
      if (res.statusCode == 200 && res.data["isSuccess"]) {
        //log("ressss"+res.data.toString());
        fetchTodaysJob();
        return true;
      }
    }
    return false;
  }

  Future fetchTodaysJob() async {
    DateTime time = DateTime.now();

    log("time =" + time.toString());
    final res = await dioClient.getRequest(
        apiEnd: api_todaysJob + "?job_date=" + DateToYYMMDD(time));
    if (res is Response) {
      if (res.statusCode == 200) {
        log("data not founnd " + res.data["my_jobs"].toString());
        if (res.data["my_jobs"] != null) {
          todaysMyJob = MyJobs.fromJson(res.data["my_jobs"]);
          final int job_count = res.data["my_jobs"]["jobs_count"];
          if (res.data["my_jobs"]["jobs"] != null) {
            todaysJob = (res.data["my_jobs"]["jobs"] as List)
                .map((e) => JobModal.fromJson(e)..setAJS(job_count))
                .toList();
          }
        } else {
          todaysJob.clear();
        }

        notifyListeners();
        return;
      }
    }
  }

  Future fetchPastJobs(DateTime date) async {
    print(date.toString());
    final res = await dioClient.getRequest(
        apiEnd: api_todaysJob + "?job_date=" + DateToYYMMDD(date));
    if (res is Response) {
      if (res.statusCode == 200) {
        if (res.data["my_jobs"] != null) {
          archeive = MyJobs.fromJson(res.data["my_jobs"]);
          final int job_count = res.data["my_jobs"]["jobs_count"];
          if (res.data["my_jobs"]["jobs"] != null) {
            pastJobs = (res.data["my_jobs"]["jobs"] as List)
                .map((e) => JobModal.fromJson(e)..setAJS(job_count))
                .toList();
          }
        } else {
          pastJobs = [];
          archeive = null;
        }

        notifyListeners();
        return;
      }
    }
  }
}
