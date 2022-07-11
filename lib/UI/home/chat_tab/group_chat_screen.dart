// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unnecessary_new, unused_import, implementation_imports, unnecessary_import

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loadmore/loadmore.dart';
import 'package:southwind/Models/Group/GroupMessages.dart';
import 'package:southwind/Models/MessageModel.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/home/chat_tab/single_chat_screen.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/group_notifier.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';

class GroupChatScreen extends StatefulHookWidget {
  GroupChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  GroupMessagesinfo? groupinfo;
  // int? lastpage;
  ScrollController _scrollController = new ScrollController();
  List<GroupMessage> list = [];
  bool loading = false;
  Timer? timer;
  TextEditingController textController = TextEditingController();

  // GroupNotifier? _groupProviders;

  @override
  void initState() {
    //  loadData();
    super.initState();
  }

  String? from;
  int? lastpage;
  int cn = 0;
  int stop = 0;
  loadData() async {
    // cn = 0;
    // final _groupProvider = useProvider(groupProvider);
    //   lastpage = _groupProvider.groupinfo!.lastPage;
    //   log('messagesss as' + _groupProvider!.groupinfo!.lastPage.toString());
    //   periodic
    timer = Timer.periodic(Duration(seconds: 1), (c) async {
      await context.read(groupProvider).getfirstpage(cn, stop);
      _loadMore();
      timer!.cancel();
    });

    // _groupProvider.listOfMessage.clear();
    //  await context.read(groupProvider).getfirstpage(cn, stop);
    //   log('messageee' + loading.toString()
  }

  Future<bool> _loadMore() async {
    stop == 1 ? cn = 1 : stop = 0;
    // final _groupProvider = useProvider(groupProvider);
    // print("onLoadMore");
    // lastpage = groupinfo!.lastPage;
    //  log('messagesss' + lastpage.toString());
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    setState(() {
      context.read(groupProvider).getIndividualGroupMessages(cn = cn + 1, stop);
      log("stop ${stop}");
      log("fromss ${from}");
      stop = 0;
      //  cn == lastpage ? cn = 0 : stop;
    });
    return true;
  }

  // counter() async {
  //   context.read(groupProvider).getIndividualGroupMessages(cn++);
  // }
  // Future _refresh(cn) async {
  //   final _groupProvider = useProvider(groupProvider);

  //   await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
  //   setState(() {
  //     _groupProvider.listOfMessage.clear();
  //     cn = 0;
  //     context.read(groupProvider).getIndividualGroupMessages(cn + 1);
  //   });
  // }

  @override
  void dispose() {
    //   timer!.cancel();
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _groupProvider = useProvider(groupProvider);
    from = _groupProvider.groupinfo?.from.toString();
    lastpage = _groupProvider.groupinfo?.lastPage;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: primarySwatch[900]),
        backgroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // color: Co,
              width: 50,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.asset('assets/images/southwind_logo_single.png'),
                  //  Image.network(
                  //   "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
                  // ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Center(
              child: Text(
                _groupProvider.listGroup[_groupProvider.selectedGroupIndex!]
                    .group!.groupName!,
                style: TextStyle(fontSize: 18, color: primarySwatch[900]),
              ),
            ),
            // Column(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const SizedBox(
            //       height: 5,
            //     ),
            //   ],
            // )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
                onTap: () {
                  //context.read(groupProvider).fetchlastpage(cn);

                  Navigator.pushNamed(context, Routes.groupInfo);
                },
                child: Icon(Icons.more_vert_outlined)),
          )
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  LoadMore(
                    delegate: DefaultLoadMoreDelegate(),
                    textBuilder: DefaultLoadMoreTextBuilder.english,
                    whenEmptyLoad: true,
                    isFinish: cn == lastpage,
                    // _groupProvider.groupinfo?.lastPage,
                    onLoadMore: _loadMore,
                    child: ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        // log("dnjd" +
                        //     _groupProvider.groupinfo!.lastPage.toString());
                        bool isLeft =
                            _groupProvider.listOfMessage[index].profileId ==
                                _groupProvider.userData!.id;
                        return SingleMessage(
                          isGroup: true,
                          index: index,
                          messageModel: _groupProvider.listOfMessage[index],
                        );
                      },
                      itemCount: _groupProvider.listOfMessage.length,
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(child: ListView.builder(itemBuilder: (context, index) {
            //   return Container();
            // })),
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
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10),
                                    isCollapsed: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: .5,
                                            color: Colors.transparent)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: .5,
                                            color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                          onPressed: () async {
                                                            await _groupProvider
                                                                .imageUpload(
                                                                    ImageSource
                                                                        .camera);
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .camera_alt_outlined,
                                                            size: 30,
                                                          ))),
                                                  Text(
                                                    'Camera',
                                                    style: TextStyle(
                                                        color: primaryColor,
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
                                                          onPressed: () async {
                                                            await _groupProvider
                                                                .videoUpload(
                                                                    ImageSource
                                                                        .camera);
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .video_call_outlined,
                                                            size: 30,
                                                          ))),
                                                  Text(
                                                    'Video',
                                                    style: TextStyle(
                                                        color: primaryColor,
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
                                                          onPressed: () async {
                                                            await _groupProvider
                                                                .imageUpload(
                                                                    ImageSource
                                                                        .gallery);
                                                          },
                                                          icon: Icon(
                                                            Icons.image,
                                                            size: 30,
                                                          ))),
                                                  Text(
                                                    'Gallery',
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 15),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                );
                                // showModalBottomSheet(
                                //     context: context,
                                //     // backgroundColor: Colors.transparent,
                                //     builder: (context) {
                                //       return Column(
                                //         mainAxisSize: MainAxisSize.min,
                                //         children: [
                                //           bottomSheetWidget(() async {
                                //             await _groupProvider
                                //                 .imageUpload(ImageSource.gallery);
                                //           }, "Gallery"),
                                //           Divider(
                                //             color: primarySwatch.shade800,
                                //           ),
                                //           bottomSheetWidget(() async {
                                //             await _groupProvider
                                //                 .imageUpload(ImageSource.camera);
                                //           }, "Camera"),
                                //           Divider(
                                //             color: primarySwatch.shade800,
                                //           ),
                                // bottomSheetWidget(() async {
                                //   await _groupProvider
                                //       .videoUpload(ImageSource.camera);
                                // }, "Video")
                                //         ],
                                //       );
                                //     });
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
                                print('heelo');
                                if (textController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Enter Message",
                                        textAlign: TextAlign.center,
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(milliseconds: 1000),
                                      backgroundColor: primaryColor,
                                      margin: EdgeInsets.only(
                                          bottom: 70, right: 110, left: 110),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  );
                                } else {
                                  await _groupProvider.sendMessage(
                                      textController.text, 1, stop = 1);
                                  textController.clear();
                                  loadData();
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
            //  child: Padding(
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
            //                         // Icon(Icons.file_copy),

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
            //                             width: .5, color: Colors.transparent)),
            //                     enabledBorder: OutlineInputBorder(
            //                         borderRadius: BorderRadius.circular(5),
            //                         borderSide: BorderSide(
            //                             width: .5, color: Colors.transparent)),
            //                     focusedBorder: OutlineInputBorder(
            //                         borderRadius: BorderRadius.circular(5),
            //                         borderSide: BorderSide(
            //                             width: 1, color: Colors.transparent))),
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
            //                             await _groupProvider
            //                                 .imageUpload(ImageSource.gallery);
            //                           }, "Gallery"),
            //                           Divider(
            //                             color: primarySwatch.shade800,
            //                           ),
            //                           bottomSheetWidget(() async {
            //                             await _groupProvider
            //                                 .imageUpload(ImageSource.camera);
            //                           }, "Camera"),
            //                           Divider(
            //                             color: primarySwatch.shade800,
            //                           ),
            //                           bottomSheetWidget(() async {
            //                             await _groupProvider
            //                                 .videoUpload(ImageSource.camera);
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
            //             SizedBox(
            //               width: 15,
            //             ),
            //             // Icon(Icons.send_outlined),
            //             InkWell(
            //               onTap: () async {
            //                 print('heelo');
            //                 if (textController.text.isEmpty) {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             content: Text("Enter Message",textAlign: TextAlign.center,),
            //             behavior: SnackBarBehavior.floating,
            //             duration: Duration(milliseconds: 1000),
            //             backgroundColor: primaryColor,
            //             margin:
            //                 EdgeInsets.only(bottom: 70, right: 120, left: 120),
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(24),
            //             ),
            //           ),
            //         );
            //                 } else {
            //                   await _groupProvider
            //                       .sendMessage(textController.text);
            //                   textController.clear();
            //                 }
            //               },
            //               child: Image.asset(
            //                 "assets/images/send.png",
            //                 color: primarySwatch[900],
            //                 width: 25,
            //               ),
            //             ),
            //             SizedBox(
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
      ),
    );
  }

  Widget bottomSheetWidget(VoidCallback voidCallback, String title) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        voidCallback();
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

class DefaultLoadMoreDelegate extends LoadMoreDelegate {
  const DefaultLoadMoreDelegate();

  @override
  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.english}) {
    String text = builder(status);
    if (status == LoadMoreStatus.fail) {
      return Container(
        child: Text(text),
      );
    }
    if (status == LoadMoreStatus.idle) {
      return Text(text);
    }
    if (status == LoadMoreStatus.loading) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 25,
              height: 25,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('Loading'),
            // ),
          ],
        ),
      );
    }
    if (status == LoadMoreStatus.nomore) {
      return Text(text);
    }

    return Text(text);
  }
}
