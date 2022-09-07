// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:southwind/UI/components/NetworkImageLoader.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/component/dateFormattor.dart';
import 'package:southwind/data/providers/providers.dart';

import '../../data/providers/auth__notifier.dart';
import '../components/loadingWidget.dart';

class Profile extends StatefulHookWidget {
  @override
  _ProfileState createState() => _ProfileState();
  // ProfileState createState() => ProfileState();
}

class _ProfileState extends State<Profile> {
  final imgPicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final _userProvider = useProvider(authProvider);
    String firstLetter =
        _userProvider.userData!.profileFirstName.substring(0, 1).toUpperCase();
    String lastFirstLetter = _userProvider.userData!.profileFirstName
        .substring(1, _userProvider.userData!.profileFirstName.length);
    String firstName = firstLetter + lastFirstLetter;
    String lastNameFirst =
        _userProvider.userData!.profileLastName.substring(0, 1).toUpperCase();
    String lastName = lastNameFirst +
        _userProvider.userData!.profileLastName
            .substring(1, _userProvider.userData!.profileLastName.length);
    String location = _userProvider.userData!.teamName;

    final size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String gap =
        (now.difference(_userProvider.userData!.startDate).inDays / 365)
            .toString();

    return Container(
      color: primarySwatch[800],
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: size.height * 0.35,
                  width: size.width,
                  color: primarySwatch[800],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Stack(
                          children: [
                            CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    "${_userProvider.userData!.userImage}")
                                // Container(
                                //   height: size.height * 0.19,
                                //   width: size.width * 0.29,
                                //   color: Colors.transparent,
                                //   child: NetworkImagesLoader(
                                //       url: _userProvider.userData!.userImage,
                                //       radius: 20,
                                //       fit: BoxFit.fill),
                                // ),
                                ),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  radius: 15,
                                  child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        editPicDilogue(_userProvider);
                                      },
                                      icon: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 20,
                                      )),
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              // width: size.width,
                              // height: size.height * 0.16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    firstName + " " + lastName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Year of  Service: ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            height: 1,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        gap.split('.')[0],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: -size.height * 0.075,
                //   right: 0,
                //   left: 0,
                //   child: Card(
                //     elevation: 5,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20)),
                //     margin: EdgeInsets.symmetric(horizontal: 20),

                //   ),
                // ),
              ],
            ),
            // SizedBox(
            //   height: size.height * 0.1,
            // ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  )),
              // margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "- My Info",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 20,
                  //   ),
                  // ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline_rounded,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Member ID",
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                        Text(
                          _userProvider.userData!.id.toString(),
                          style: TextStyle(
                              color: primarySwatch[600], fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: 20),
                  // Card(
                  //   elevation: 5,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12)),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 5),
                  //     child: ListTile(
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  //       title: Text(
                  //         "Member ID",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: primarySwatch[700]),
                  //       ),
                  //       // subtitle: Text(
                  //       //   "27",
                  //       //   style: TextStyle(
                  //       //       // height: 1.5,
                  //       //       fontWeight: FontWeight.bold,
                  //       //       letterSpacing: 2,
                  //       //       wordSpacing: 1,
                  //       //       color: primarySwatch[400]),
                  //       // ),
                  //       trailing: Container(
                  //         padding:
                  //             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             color: Colors.white,
                  //             boxShadow: [
                  //               BoxShadow(
                  //                   blurRadius: 2,
                  //                   spreadRadius: 0,
                  //                   color: primarySwatch,
                  //                   offset: Offset(0, 1.5))
                  //             ]),
                  //         child: Text(_userProvider.userData!.id.toString()),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.005,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.pin_drop_outlined,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Location",
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                        Text(
                          location,
                          style: TextStyle(
                              color: primarySwatch[600], fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: 20),
                  // Card(
                  //   elevation: 5,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12)),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 5),
                  //     child: ListTile(
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  //       title: Text(
                  //         "Location",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: primarySwatch[700]),
                  //       ),
                  //       subtitle: Text(
                  //         location,
                  //         style: TextStyle(
                  //             // height: 1.5,
                  //             fontWeight: FontWeight.normal,
                  //             letterSpacing: 2,
                  //             wordSpacing: 1,
                  //             fontSize: 14,
                  //             color: primarySwatch[400]),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.alternate_email,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Email",
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                        Text(
                          _userProvider.userData!.profileEmail,
                          style: TextStyle(
                              color: primarySwatch[600], fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: 20),
                  // Card(
                  //   elevation: 5,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12)),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 5),
                  //     child: ListTile(
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  //       title: Text(
                  //         "Email",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: primarySwatch[700]),
                  //       ),
                  //       subtitle: Text(
                  //         _userProvider.userData!.profileEmail,
                  //         style: TextStyle(
                  //             // height: 1.5,
                  //             fontWeight: FontWeight.normal,
                  //             letterSpacing: 2,
                  //             wordSpacing: 1,
                  //             fontSize: 14,
                  //             color: primarySwatch[400]),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Start Date",
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                        Text(
                          dateTime_format(_userProvider.userData!.startDate),
                          style: TextStyle(
                              color: primarySwatch[600], fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: 20),

                  // Card(
                  //   elevation: 5,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12)),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 5),
                  //     child: ListTile(
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  //       title: Text(
                  //         "Start Date",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: primarySwatch[700]),
                  //       ),
                  //       subtitle: Text(
                  //         dateTime_format(_userProvider.userData!.startDate),
                  //         style: TextStyle(
                  //             // height: 1.5,
                  //             fontWeight: FontWeight.normal,
                  //             letterSpacing: 2,
                  //             wordSpacing: 1,
                  //             fontSize: 14,
                  //             color: primarySwatch[400]),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  editPicDilogue(AuthNotifier _userProvider) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding:
                EdgeInsets.only(bottom: 0, top: 10, left: 20, right: 20),
            contentPadding: EdgeInsets.only(top: 0),
            title: Text(
              "Edit profile picture!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            //  titleTextStyle: TextStyle(fontSize: 15),
            content: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                // showDialog(
                                //     barrierDismissible: false,
                                //     context: context,
                                //     builder: (c) => LoadingWidget());

                                await _userProvider.imageUpload(
                                    ImageSource.camera,
                                    _userProvider.userData!.profileFirstName
                                        .toString());
                                Navigator.pop(context);
                                // Navigator.pop(context);
                                // openCamera();
                              },
                              icon: Icon(
                                Icons.camera,
                                size: 35,
                              ),
                            ),
                          ),
                          Text(
                            "Camera",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                // showDialog(
                                //     context: context,
                                //     builder: (c) => LoadingWidget());
                                await _userProvider.imageUpload(
                                    ImageSource.gallery,
                                    _userProvider.userData!.profileFirstName
                                        .toString());
                                Navigator.pop(context);
                                // Navigator.pop(context);
                                // openGallery();
                              },
                              icon: Icon(
                                Icons.photo,
                                size: 35,
                              ),
                            ),
                          ),
                          Text(
                            "Gallery",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

// late var imgCamera;
// void openCamera() async {
//   imgCamera = await imgPicker.getImage(source: ImageSource.camera);
//   log("image camera = " + imgCamera);
//   Navigator.of(context).pop();
// }

// late var imgGallery;
// void openGallery() async {
//   imgGallery = await imgPicker.getImage(source: ImageSource.gallery);
//   log("image gallery = " + imgGallery.path.toString());
//   Navigator.of(context).pop();
// }
}

// // ignore_for_file: prefer_const_constructors
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:southwind/UI/components/NetworkImageLoader.dart';
// import 'package:southwind/UI/theme/apptheme.dart';
// import 'package:southwind/component/dateFormattor.dart';
// import 'package:southwind/data/providers/providers.dart';
//
// class Profile extends StatefulHookWidget {
//   @override
//   _ProfileState createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     final _userProvider = useProvider(authProvider);
//     String firstLetter =
//         _userProvider.userData!.profileFirstName.substring(0, 1).toUpperCase();
//     String lastFirstLetter = _userProvider.userData!.profileFirstName
//         .substring(1, _userProvider.userData!.profileFirstName.length);
//     String firstName = firstLetter + lastFirstLetter;
//     String lastNameFirst =
//         _userProvider.userData!.profileLastName.substring(0, 1).toUpperCase();
//     String lastName = lastNameFirst +
//         _userProvider.userData!.profileLastName
//             .substring(1, _userProvider.userData!.profileLastName.length);
//     String location = _userProvider.userData!.teamName;
//
//     final size = MediaQuery.of(context).size;
//     DateTime now = DateTime.now();
//     String gap =
//         (now.difference(_userProvider.userData!.startDate).inDays / 365)
//             .toString();
//
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 height: size.height * 0.2,
//                 width: size.width,
//                 color: primarySwatch,
//               ),
//               Positioned(
//                 bottom: -size.height * 0.075,
//                 right: 0,
//                 left: 0,
//                 child: Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                   margin: EdgeInsets.symmetric(horizontal: 20),
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 5),
//                     width: size.width,
//                     // height: size.height * 0.16,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         left: size.width * 0.37,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             firstName + " " + lastName,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                           // Text(
//                           //   "UI/UX Designer",
//                           //   style: TextStyle(
//                           //       color: primarySwatch[600], fontSize: 15),
//                           // ),
//                           SizedBox(
//                             height: size.height * 0.01,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "Year of  Service: ",
//                                 style: TextStyle(
//                                     height: 1,
//                                     // fontWeight: FontWeight.bold,
//                                     fontSize: 18),
//                               ),
//                               Text(
//                                 gap.split('.')[0],
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: -size.height * 0.05,
//                 child: Card(
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                   margin: EdgeInsets.only(left: 40),
//                   child: Container(
//                     height: size.height * 0.19,
//                     width: size.width * 0.3,
//                     // decoration: BoxDecoration(
//                     //   borderRadius: BorderRadius.circular(20),
//                     //   image: DecorationImage(
//                     //       image: NetworkImage(
//                     //           'https://images.unsplash.com/photo-1638459614085-bdb69b6d3432?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
//                     //       fit: BoxFit.cover),
//                     child: Stack(
//                       children: [
//                         NetworkImagesLoader(
//                             url: _userProvider.userData!.userImage,
//                             radius: 20,
//                             fit: BoxFit.cover),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: size.height * 0.1,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "- My Info",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.01,
//                 ),
//                 Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5),
//                     child: ListTile(
//                       contentPadding: EdgeInsets.symmetric(horizontal: 18),
//                       title: Text(
//                         "Member ID",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: primarySwatch[700]),
//                       ),
//                       // subtitle: Text(
//                       //   "27",
//                       //   style: TextStyle(
//                       //       // height: 1.5,
//                       //       fontWeight: FontWeight.bold,
//                       //       letterSpacing: 2,
//                       //       wordSpacing: 1,
//                       //       color: primarySwatch[400]),
//                       // ),
//                       trailing: Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   blurRadius: 2,
//                                   spreadRadius: 0,
//                                   color: primarySwatch,
//                                   offset: Offset(0, 1.5))
//                             ]),
//                         child: Text(_userProvider.userData!.id.toString()),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // SizedBox(
//                 //   height: size.height * 0.005,
//                 // ),
//                 Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5),
//                     child: ListTile(
//                       contentPadding: EdgeInsets.symmetric(horizontal: 18),
//                       title: Text(
//                         "Location",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: primarySwatch[700]),
//                       ),
//                       subtitle: Text(
//                         location,
//                         style: TextStyle(
//                             // height: 1.5,
//                             fontWeight: FontWeight.normal,
//                             letterSpacing: 2,
//                             wordSpacing: 1,
//                             fontSize: 14,
//                             color: primarySwatch[400]),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5),
//                     child: ListTile(
//                       contentPadding: EdgeInsets.symmetric(horizontal: 18),
//                       title: Text(
//                         "Email",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: primarySwatch[700]),
//                       ),
//                       subtitle: Text(
//                         _userProvider.userData!.profileEmail,
//                         style: TextStyle(
//                             // height: 1.5,
//                             fontWeight: FontWeight.normal,
//                             letterSpacing: 2,
//                             wordSpacing: 1,
//                             fontSize: 14,
//                             color: primarySwatch[400]),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5),
//                     child: ListTile(
//                       contentPadding: EdgeInsets.symmetric(horizontal: 18),
//                       title: Text(
//                         "Start Date",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: primarySwatch[700]),
//                       ),
//                       subtitle: Text(
//                         dateTime_format(_userProvider.userData!.startDate),
//                         style: TextStyle(
//                             // height: 1.5,
//                             fontWeight: FontWeight.normal,
//                             letterSpacing: 2,
//                             wordSpacing: 1,
//                             fontSize: 14,
//                             color: primarySwatch[400]),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
