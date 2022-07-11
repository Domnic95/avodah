import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/data/config.dart';
import 'package:southwind/data/http_client/dio_client.dart';
import 'package:southwind/Models/feedback/feedback.dart';

class FeedBackScreen extends StatefulWidget {
  final Map<String, dynamic> notificationData;
  FeedBackScreen({this.notificationData = const {}, Key? key})
      : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  @override
  void initState() {
    super.initState();
    print("d"+widget.notificationData.toString());
  }
  Future<FeedbackModal?> getFeedBack() async {
    final res =
        await DioClient().getRequest(apiEnd: api_getFeedBack, queryParameter: {
      "career_path_user_achivement_id":
          widget.notificationData["career_path_user_achivement_id"],
    });
    print('hello' + widget.notificationData["career_path_user_achivement_id"]);

    if (res is Response) {
      print('hello' + res.data["feedback"]);
      if (res.data["feedback"] != null) {
        return FeedbackModal.fromJson(res.data["feedback"]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(),
      body: FutureBuilder<FeedbackModal?>(
          future: getFeedBack(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return Center(
                child: Text("Something Went Wrong"),
              );
            }
            const double radius = 20;
            return SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radius),
                        bottomRight: Radius.circular(radius),
                      )),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(radius),
                          bottomRight: Radius.circular(radius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.notificationData["title"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          // Text(widget.notificationData["title"].toString(),style: TextStyle(
                          //   fontWeight: FontWeight.w600,
                          //   fontSize: 26
                          // ),),
                          Text("Feedback from admin",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 14)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (snapshot.data!.adminFeedback == ""
                                      ? "Feedback is not available"
                                      : snapshot.data!.adminFeedback)
                                  .toString(),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),
                      )),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(radius),
                          topLeft: Radius.circular(radius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 15),
                          child: CommonButton(
                            lable: "Ok",
                            ontap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),

                    // SizedBox(r
                    //   height: 10,
                    // ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
