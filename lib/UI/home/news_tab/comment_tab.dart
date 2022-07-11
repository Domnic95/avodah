// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:southwind/Models/Group/GroupMessages.dart';
import 'package:southwind/Models/news/comment_modal.dart';
import 'package:southwind/Models/news/postModal.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/home/chat_tab/components/FullScreenImage.dart';
import 'package:southwind/UI/home/chat_tab/components/FullscreenVideo.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/constant/Global.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:video_player/video_player.dart';

class CommentTab extends StatefulHookWidget {
  final PostModal postModal;
  final int index;
  const CommentTab(this.postModal, this.index, {Key? key}) : super(key: key);
  @override
  _CommentTabState createState() => _CommentTabState();
}

class _CommentTabState extends State<CommentTab> {
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await context
        .read(commentNotifierProvider(widget.postModal.id.toString()))
        .loadComments();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final commentNotifier =
        useProvider(commentNotifierProvider(widget.postModal.id.toString()));

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primarySwatch[900]),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? LoadingWidget()
          : Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: commentNotifier.comments.length > 0
                        ? ListView.builder(
                            controller: scrollController,
                            // reverse: true,
                            itemCount: commentNotifier.comments.length,
                            itemBuilder: (context, index) {
                              return CommentWidget(
                                commentModal: commentNotifier.comments[index],
                              );
                            })
                        : const Center(
                            child: Text("No Comment Found"),
                          )),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 18),
                    child: Column(
                      children: [
                        Divider(),
                        Container(
                          // decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     border: Border.all(color: primarySwatch.shade900),
                          //     borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: textController,
                                    maxLines: 4,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                        filled: true,
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Icon(Icons.file_copy),

                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        fillColor: Colors.transparent,
                                        hintText: "Send Message",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        isCollapsed: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                width: .5,
                                                color: Colors.transparent)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                width: .5,
                                                color: Colors.transparent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.transparent))),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 10,
                                // ),
                                InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Column(
                                          children: [
                                            Expanded(
                                                child: GestureDetector(
                                              onTap: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                              },
                                              child: Container(
                                                  color: Colors.transparent),
                                            )),
                                            Container(
                                              padding: EdgeInsets.all(12),
                                              height: 110,
                                              decoration: BoxDecoration(
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                        color: Colors.black54,
                                                        blurRadius: 5,
                                                        offset: Offset(0, 3))
                                                  ],
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Container(
                                                height: 90,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                primaryColor,
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  await commentNotifier.imageUpload(
                                                                      ImageSource
                                                                          .camera,
                                                                      widget
                                                                          .postModal
                                                                          .id
                                                                          .toString());
                                                                  //  Navigator.pop(context);

                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (c) =>
                                                                              LoadingWidget());
                                                                  await commentNotifier.imageUpload(
                                                                      ImageSource
                                                                          .camera,
                                                                      widget
                                                                          .postModal
                                                                          .id
                                                                          .toString());
                                                                  Navigator.pop(
                                                                      context);
                                                                  "Camera";
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .camera_alt_outlined,
                                                                  size: 30,
                                                                ))),
                                                        Text(
                                                          'Camera',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor,
                                                              fontSize: 15),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                primaryColor,
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  await commentNotifier.videoUpload(
                                                                      ImageSource
                                                                          .camera,
                                                                      widget
                                                                          .postModal
                                                                          .id
                                                                          .toString());
                                                                  //  Navigator.pop(context);

                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (c) =>
                                                                              LoadingWidget());
                                                                  await commentNotifier.videoUpload(
                                                                      ImageSource
                                                                          .camera,
                                                                      widget
                                                                          .postModal
                                                                          .id
                                                                          .toString());
                                                                  Navigator.pop(
                                                                      context);
                                                                  "Video";
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .video_call_outlined,
                                                                  size: 30,
                                                                ))),
                                                        Text(
                                                          'Video',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor,
                                                              fontSize: 15),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                primaryColor,
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  await commentNotifier.imageUpload(
                                                                      ImageSource
                                                                          .gallery,
                                                                      widget
                                                                          .postModal
                                                                          .id
                                                                          .toString());
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (c) =>
                                                                              LoadingWidget());
                                                                  await commentNotifier
                                                                      .imageUpload(
                                                                    ImageSource
                                                                        .gallery,
                                                                    widget
                                                                        .postModal
                                                                        .id
                                                                        .toString(),
                                                                  );
                                                                  Navigator.pop(
                                                                      context);
                                                                  "Gallery";
                                                                },
                                                                icon: Icon(
                                                                  Icons.image,
                                                                  size: 30,
                                                                ))),
                                                        Text(
                                                          'Gallery',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor,
                                                              fontSize: 15),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(milliseconds: 5000),
                                        backgroundColor: Colors.transparent,
                                        dismissDirection: DismissDirection.down,
                                        margin: EdgeInsets.only(
                                            bottom: 70, right: 0, left: 0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/images/attachments.png",
                                    color: primarySwatch[900],
                                    width: 23,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                // Icon(Icons.send_outlined),
                                InkWell(
                                  onTap: () async {
                                    String loc = textController.text;

                                    if (textController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Enter Message",
                                            textAlign: TextAlign.center,
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          duration:
                                              Duration(milliseconds: 1000),
                                          backgroundColor: primaryColor,
                                          margin: EdgeInsets.only(
                                              bottom: 70,
                                              right: 120,
                                              left: 120),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                        ),
                                      );
                                    } else {
                                      await commentNotifier.sendComment(
                                          widget.postModal.id.toString(), loc);
                                      updateComment();
                                      scrollController.jumpTo(scrollController
                                          .position.maxScrollExtent);
                                      textController.clear();
                                    }
                                  },
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: primaryColor,
                                      child: Icon(Icons.send)),
                                ),
                                // SizedBox(
                                //   width: 15,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                // Container(
                //   // height: 60,
                //   // constraints: BoxConstraints(maxHeight: 100),
                //   // decoration: BoxDecoration(
                //   //   color: primarySwatch[100],
                //   //   borderRadius: BorderRadius.only(
                //   //       topLeft: Radius.circular(20),
                //   //       topRight: Radius.circular(20)),
                //   // ),
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //         left: 10, right: 10, bottom: 10, top: 18),
                //     child: Container(
                //       decoration: BoxDecoration(
                //           color: Colors.white,
                //           border: Border.all(color: primarySwatch.shade900),
                //           borderRadius: BorderRadius.circular(5)),
                //       child: Center(
                //         child: Row(
                //           children: [
                //             Expanded(
                //               child: TextFormField(
                //                 controller: textController,
                //                 maxLines: 4,
                //                 minLines: 1,
                //                 decoration: InputDecoration(
                //                     filled: true,
                //                     suffixIcon: Row(
                //                       mainAxisSize: MainAxisSize.min,
                //                       children: [
                //                         SizedBox(
                //                           width: 10,
                //                         ),
                //                       ],
                //                     ),
                //                     fillColor: Colors.transparent,
                //                     hintText: "Send Message",
                //                     hintStyle: TextStyle(color: Colors.grey),
                //                     contentPadding: EdgeInsets.symmetric(
                //                         horizontal: 8, vertical: 10),
                //                     isCollapsed: true,
                //                     border: OutlineInputBorder(
                //                         borderRadius: BorderRadius.circular(5),
                //                         borderSide: BorderSide(
                //                             width: .5,
                //                             color: Colors.transparent)),
                //                     enabledBorder: OutlineInputBorder(
                //                         borderRadius: BorderRadius.circular(5),
                //                         borderSide: BorderSide(
                //                             width: .5,
                //                             color: Colors.transparent)),
                //                     focusedBorder: OutlineInputBorder(
                //                         borderRadius: BorderRadius.circular(5),
                //                         borderSide: BorderSide(
                //                             width: 1,
                //                             color: Colors.transparent))),
                //               ),
                //             ),
                //             // SizedBox(
                //             //   width: 10,
                //             // ),
                //             InkWell(
                //               onTap: () {
                //                 showModalBottomSheet(
                //                     context: context,
                //                     // backgroundColor: Colors.transparent,
                //                     builder: (context) {
                //                       return Column(
                //                         mainAxisSize: MainAxisSize.min,
                //                         children: [
                //                           bottomSheetWidget(() async {
                //                             //  showDialog(context: context, builder: (c)=>LoadingWidget());
                //                             await commentNotifier.imageUpload(
                //                                 ImageSource.gallery,
                //                                 widget.postModal.id.toString());
                //                             // Navigator.pop(context);

                //                             showDialog(
                //                                 context: context,
                //                                 builder: (c) =>
                //                                     LoadingWidget());
                //                             await commentNotifier.imageUpload(
                //                               ImageSource.gallery,
                //                               widget.postModal.id.toString(),
                //                             );
                //                             Navigator.pop(context);
                //                           }, "Gallery"),
                //                           Divider(
                //                             color: primarySwatch.shade800,
                //                           ),
                //                           bottomSheetWidget(() async {
                //                             //  showDialog(context: context, builder: (c)=>LoadingWidget());
                //                             await commentNotifier.imageUpload(
                //                                 ImageSource.camera,
                //                                 widget.postModal.id.toString());
                //                             //  Navigator.pop(context);

                //                             showDialog(
                //                                 context: context,
                //                                 builder: (c) =>
                //                                     LoadingWidget());
                //                             await commentNotifier.imageUpload(
                //                                 ImageSource.camera,
                //                                 widget.postModal.id.toString());
                //                             Navigator.pop(context);
                //                           }, "Camera"),
                //                           Divider(
                //                             color: primarySwatch.shade800,
                //                           ),
                //                           bottomSheetWidget(() async {
                //                             //  showDialog(context: context, builder: (c)=>LoadingWidget());
                //                             await commentNotifier.videoUpload(
                //                                 ImageSource.camera,
                //                                 widget.postModal.id.toString());
                //                             //  Navigator.pop(context);

                //                             showDialog(
                //                                 context: context,
                //                                 builder: (c) =>
                //                                     LoadingWidget());
                //                             await commentNotifier.videoUpload(
                //                                 ImageSource.camera,
                //                                 widget.postModal.id.toString());
                //                             Navigator.pop(context);
                //                           }, "Video")
                //                         ],
                //                       );
                //                     });
                //               },
                //               child: Image.asset(
                //                 "assets/images/attachments.png",
                //                 color: primarySwatch[900],
                //                 width: 25,
                //               ),
                //             ),
                //             const SizedBox(
                //               width: 15,
                //             ),
                //             // Icon(Icons.send_outlined),
                //             InkWell(
                //               onTap: () async {
                //                 String loc = textController.text;
                //                 textController.clear();
                //                 if (textController.text.isEmpty) {
                //                   ScaffoldMessenger.of(context).showSnackBar(
                //                     SnackBar(
                //                       content: Text(
                //                         "Enter Message",
                //                         textAlign: TextAlign.center,
                //                       ),
                //                       behavior: SnackBarBehavior.floating,
                //                       duration: Duration(milliseconds: 1000),
                //                       backgroundColor: primaryColor,
                //                       margin: EdgeInsets.only(
                //                           bottom: 70, right: 120, left: 120),
                //                       shape: RoundedRectangleBorder(
                //                         borderRadius: BorderRadius.circular(24),
                //                       ),
                //                     ),
                //                   );
                //                 } else {
                //                   await commentNotifier.sendComment(
                //                       widget.postModal.id.toString(), loc);
                //                   updateComment();
                //                   scrollController.jumpTo(scrollController
                //                       .position.maxScrollExtent);
                //                 }
                //               },
                //               child: Image.asset(
                //                 "assets/images/send.png",
                //                 color: primarySwatch[900],
                //                 width: 25,
                //               ),
                //             ),
                //             const SizedBox(
                //               width: 15,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
    ));
  }

  updateComment() async {
    await context.read(newsNotifierProvider).localCommentUdpate(widget.index);
  }

  Widget bottomSheetWidget(VoidCallback voidCallback, String title) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        voidCallback();
        setState(() {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      },
      child: Container(
        decoration: BoxDecoration(),
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final CommentModal commentModal;
  const CommentWidget({required this.commentModal, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  //margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      commentModal.profile.userImage.isEmpty
                          ? CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage("assets/images/images.jpg"),
                            )
                          : CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                  "${commentModal.profile.userImage}"),
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "${commentModal.profile.profileFirstName} - ${commentModal.profile.teamName}",
                                    // "${commentModal.profile.profileFirstName}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "${commentModal.timeDifference}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Builder(builder: (context) {
                              switch (commentModal.mediaType!) {
                                case MediaTypes.message:
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "${commentModal.comment}",
                                      // overflow: TextOverflow.ellipsis,
                                      // maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  );
                                case MediaTypes.Image:
                                  return CommentImage(
                                    mediaUrl: commentModal.mediaUrl,
                                  );
                                case MediaTypes.Video:
                                  return CommentVideoApp(
                                    mediaUrl: commentModal.mediaUrl,
                                  );
                              }
                            }),
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.6,
                            //   child: Text(
                            //     "\"${commentModal.comment}\"",
                            //     maxLines: 2,
                            //     style:
                            //         TextStyle(fontSize: 12, color: Colors.grey),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          indent: 60,
        ),
      ],
    );
  }
}

double aspectratio = 0.2;

class CommentImage extends StatelessWidget {
  final String mediaUrl;
  const CommentImage({required this.mediaUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ShowImageScreen(
            mediaUrl: mediaUrl,
            title: '',
          );
        }));
      },
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(borderRadius: borderRadius),
          height: size.height * aspectratio,
          width: size.width * aspectratio,
          child: Image.network(
            mediaUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class CommentVideoApp extends StatefulWidget {
  final String mediaUrl;
  const CommentVideoApp({required this.mediaUrl});
  @override
  _CommentVideoAppState createState() => _CommentVideoAppState();
}

class _CommentVideoAppState extends State<CommentVideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.mediaUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    BorderRadius borderRadius = BorderRadius.circular(radius);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FullScreenVideoApp(
            url: widget.mediaUrl,
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: borderRadius),
        height: size.height * aspectratio,
        width: size.width * aspectratio,
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
