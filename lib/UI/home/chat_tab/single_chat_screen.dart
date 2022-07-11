// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:southwind/Models/Group/GroupMessages.dart';
import 'package:southwind/Models/MessageModel.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/text_form_field.dart';
import 'package:southwind/UI/home/chat_tab/components/FullScreenImage.dart';
import 'package:southwind/UI/home/chat_tab/components/FullscreenVideo.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/constant/Global.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:video_player/video_player.dart';

double videoHeightAspect = 0.25;

double videoWidthAspect = 0.7;
// class SingleChatScreen extends StatelessWidget {
//   const SingleChatScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 50,
//         titleSpacing: 0,
//         iconTheme: IconThemeData(color: primarySwatch[900]),
//         backgroundColor: Colors.white,
//         title: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               // color: Co,
//               width: 50,
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(1000),
//                   child: Image.network(
//                     "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 5,
//             ),
//             Center(
//               child: Text(
//                 "Domic lakra",
//                 style: TextStyle(fontSize: 18, color: primarySwatch[900]),
//               ),
//             ),
//             // Column(
//             //   mainAxisSize: MainAxisSize.max,
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     const SizedBox(
//             //       height: 5,
//             //     ),
//             //   ],
//             // )
//           ],
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: InkWell(
//                 onTap: () {
//                   // Navigator.pushNamed(context, '/ProfileInfo');
//                 },
//                 child: Icon(Icons.more_vert_outlined)),
//           )
//         ],
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 reverse: true,
//                 itemBuilder: (context, index) {
//                   return SingleMessage(
//                     index: index,
//                     messageModel: _g[index],
//                   );
//                 },
//                 itemCount: messages.length,
//               ),
//             ),
//             // Expanded(child: ListView.builder(itemBuilder: (context, index) {
//             //   return Container();
//             // })),
//             Container(
//               // height: 60,
//               // constraints: BoxConstraints(maxHeight: 100),
//               // decoration: BoxDecoration(
//               //   color: primarySwatch[100],
//               //   borderRadius: BorderRadius.only(
//               //       topLeft: Radius.circular(20),
//               //       topRight: Radius.circular(20)),
//               // ),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     left: 10, right: 10, bottom: 10, top: 18),
//                 child: Center(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           maxLines: 4,
//                           minLines: 1,
//                           decoration: InputDecoration(
//                               filled: true,
//                               suffixIcon: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   // Icon(Icons.file_copy),
//                                   Image.asset(
//                                     "assets/images/attachments.png",
//                                     color: primarySwatch[900],
//                                     width: 25,
//                                   ),
//                                   SizedBox(
//                                     width: 15,
//                                   ),
//                                   // Icon(Icons.send_outlined),
//                                   Image.asset(
//                                     "assets/images/send.png",
//                                     color: primarySwatch[900],
//                                     width: 25,
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                 ],
//                               ),
//                               fillColor: Colors.white,
//                               hintText: "Send Message",
//                               hintStyle: TextStyle(color: Colors.grey),
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 10),
//                               isCollapsed: true,
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(
//                                       width: .5, color: primarySwatch[900]!)),
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(
//                                       width: .5, color: primarySwatch[900]!)),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(
//                                       width: 1, color: primaryColor))),
//                         ),
//                       ),
//                       // SizedBox(
//                       //   width: 10,
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class SingleMessage extends StatelessWidget {
  final int index;
  bool? isGroup;
  final GroupMessage messageModel;
  SingleMessage(
      {required this.index, required this.messageModel, this.isGroup = false});

  @override
  Widget build(BuildContext context) {
    final _groupProvider = context.read(groupProvider);

    bool isLeft = _groupProvider.listOfMessage[index].profileId !=
            _groupProvider.userData!.id
        ? true
        : false;
    // BorderRadius borderRadius = BorderRadius.circular(radius);
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(isLeft ? 0 : radius),
      bottomRight: Radius.circular(isLeft ? radius : 0),
    );
    final String message = messageModel.message!;
    // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets conta";
    return Align(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (isLeft) _getProfile,
            Container(
              constraints: BoxConstraints(
                  maxWidth:
                      MediaQuery.of(context).size.width * videoWidthAspect),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
                child: Padding(
                  padding: isGroup! && isLeft
                      ? EdgeInsets.fromLTRB(8, 4, 8, 4)
                      : EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: isLeft
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      if (isGroup! && isLeft)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 2, 8, 0),
                              child: Text(
                                messageModel.fullName!,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      Builder(builder: (context) {
                        switch (messageModel.mediaType!) {
                          case MediaTypes.message:
                            return TextMessage(
                                isLeft: isLeft,
                                messageModel: messageModel,
                                borderRadius: borderRadius);

                          case MediaTypes.Image:
                            return ImageMessage(
                              messageModel: messageModel,
                              isLeft: isLeft,
                            );
                          case MediaTypes.Video:
                            return VideoApp(
                              isLeft: isLeft,
                              groupMessage: messageModel,
                            );
                            return FileMessage(
                              radius: borderRadius,
                            );
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
            if (!isLeft) _getProfile,
          ],
        ),
      ),
    );
  }

  Widget get _getProfile {
    return Container(
      height: 20,
      width: 20,
      child: CircleAvatar(
        backgroundImage: NetworkImage(messageModel.userImage!),
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  final GroupMessage messageModel;
  final BorderRadius borderRadius;
  final bool isLeft;
  const TextMessage(
      {required this.messageModel,
      required this.borderRadius,
      required this.isLeft,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetAddressFromLatLong();
    String Address = "";
    DateTime time =
        DateTime.parse(messageModel.createdOn.toString() + '-04:00').toLocal();
    // time = time.add(Duration(hours: 9, minutes: 30));
    // log('dfdfdfdcv ='  + Address);
    // log('dfdfdfdcv =' + time.timeZoneOffset.toString());
    // log("timeee" + time.toString());
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          crossAxisAlignment:
              isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 0,
            ),
            Text(messageModel.message!),
            isLeft
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      Address.toString().contains('United States')
                          ? messageModel.time!.toString()
                          : DateFormat.jm().format(time),
                      // messageModel.displayFormat!.toString(),

                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Text(
                    Address.toString().contains('United States')
                        ? messageModel.time!.toString()
                        // time.toString(),
                        : DateFormat.jm().format(time),
                    // messageModel.displayFormat!.toString(),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
          ],
        ),
      ),
    );
  }
}

Future<Position> _getGeoLocationPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<void> GetAddressFromLatLong() async {
  Position position = await _getGeoLocationPosition();
  String Address;
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

  Placemark place = placemarks[0];
  // log("placeee" + place.toString());
  Address =
      '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  log('sdjushudhsuh' + Address);
}

class ImageMessage extends StatelessWidget {
  final GroupMessage messageModel;
  final bool isLeft;
  const ImageMessage(
      {required this.messageModel, required this.isLeft, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _groupProvider = context.read(groupProvider);
    final size = MediaQuery.of(context).size;

    // BorderRadius borderRadius = BorderRadius.circular(radius);
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(isLeft ? 0 : radius),
      bottomRight: Radius.circular(isLeft ? radius : 0),
    );
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ShowImageScreen(
              mediaUrl: messageModel.mediaUrl!,
              title: _groupProvider
                  .listGroup[_groupProvider.selectedGroupIndex!]
                  .group!
                  .groupName!);
        }));
      },
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(borderRadius: borderRadius),
          height: size.height * videoHeightAspect,
          width: size.width * videoWidthAspect,
          child: Image.network(
            messageModel.mediaUrl!,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class FileMessage extends StatelessWidget {
  final BorderRadius radius;
  const FileMessage({required this.radius, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 4.5,
      width: size.width / 4.5,
      child: Stack(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/pdf.png"),
          )),
          Container(
            decoration: BoxDecoration(
              borderRadius: radius,
              color: Colors.black.withOpacity(.6),
            ),
            child: Center(
              child: Icon(
                Icons.download_for_offline_outlined,
                size: 50,
                color: Colors.white.withOpacity(0.8),
                // color: primarySwatch[900],
              ),
            ),
          )
        ],
      ),
    );
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 4,
            ),
            Icon(
              Icons.picture_as_pdf,
              color: primarySwatch[700],
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(child: Text("Pdf of something")),
            Icon(Icons.download),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class VideoApp extends StatefulWidget {
  final bool isLeft;
  final GroupMessage groupMessage;
  const VideoApp({required this.isLeft, required this.groupMessage});
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.groupMessage.mediaUrl!)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(widget.isLeft ? 0 : radius),
      bottomRight: Radius.circular(widget.isLeft ? radius : 0),
    );
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FullScreenVideoApp(
            url: widget.groupMessage.mediaUrl!,
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: borderRadius),
        height: size.height * videoHeightAspect,
        width: size.width * videoWidthAspect,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: borderRadius, child: VideoPlayer(_controller)),
            Center(
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primarySwatch.shade300),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.play_arrow),
                    ))),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
