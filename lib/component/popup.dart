import 'package:flutter/material.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/theme/apptheme.dart';

class CustomPopUp extends StatefulWidget {
  final String title;
  final String subTitle;
  CustomPopUp({required this.title, required this.subTitle});

  @override
  _CustomPopUpState createState() => _CustomPopUpState();
}

class _CustomPopUpState extends State<CustomPopUp> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color.lerp(Colors.black, primarySwatch[700], .8)!,
        child: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: primarySwatch[100],
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 20),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/images/trophy.png",
                                height: 140,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  widget.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 22),
                                ),
                              ),
                              // Center(
                              //   child: Text(
                              //     "90% Score",
                              //     style: Theme.of(context)
                              //         .textTheme
                              //         .bodyText1!
                              //         .copyWith(
                              //             fontSize: 24,
                              //             fontWeight: FontWeight.w700),
                              //   ),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  widget.subTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Container(
                              //     width: 150,
                              //     height: 50,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(10),
                              //         color: primarySwatch.shade400),
                              //     child: Center(
                              //       child: Text(
                              //         'Okay',
                              //         style: TextStyle(
                              //             fontSize: 18, color: Colors.white),
                              //       ),
                              //     )),
                              CommonButton(
                                lable: "Completed",
                                ontap: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                        // width: 50,
                      ),
                    ),
                  ),
                )),
                Positioned(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        Icons.close,
                        size: 28,
                      ),
                    ),
                  ),
                  right: 10,
                  top: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
