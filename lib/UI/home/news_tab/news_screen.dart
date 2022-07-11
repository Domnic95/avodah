// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps

import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:southwind/UI/components/youtubePlayer.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/news/postModal.dart';
import 'package:southwind/Models/news/singleNews.dart';
import 'package:southwind/UI/components/NetworkImageLoader.dart';

import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/home/news_tab/comment_tab.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

const String profilePath = "assets/images/image2.jpg";

class NewsScreen extends StatefulHookWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedIndex = 0;
  ScrollController controller = ScrollController();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    loadData();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  loadData() async {
    await context.read(newsNotifierProvider).fetchNews();
    setState(() {
      loading = false;
    });
  }

  void _scrollListener() async {
    if (context.read(newsNotifierProvider).lazyLoading) {
      if (controller.position.extentAfter < 500) {
        await context.read(newsNotifierProvider).lazyData();
        // setState(() {
        //   // items.addAll(List.generate(42, (index) => 'Inserted $index'));
        // });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _newsNotifier = useProvider(newsNotifierProvider);
    // return SingleChildScrollView(child: FeedPost());
    return Scaffold(
        body: loading
            ? LoadingWidget()
            : _newsNotifier.total_news.length > 0
                ? RefreshIndicator(
                    onRefresh: () async {
                      await loadData();
                    },
                    child: ListView.builder(
                      controller: controller,
                      padding: EdgeInsets.only(top: 3),
                      itemBuilder: (context, index) {
                        return FeedPost(
                          post: _newsNotifier.total_news[index],
                          index: index,
                        );
                      },
                      itemCount: _newsNotifier.total_news.length,
                    ),
                  )
                : Center(
                    child: Text('No news found'),
                  )
        // FutureBuilder(
        //     future: _newsNotifier.fetchNews(),
        //     builder: (context, AsyncSnapshot snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         return ListView.builder(
        //           padding: EdgeInsets.only(top: 3),
        //           itemBuilder: (context, index) {
        //             return FeedPost(post: _newsNotifier.total_news[index]);
        //           },
        //           itemCount: _newsNotifier.total_news.length,
        //         );
        //       } else {
        //         return LoadingWidget();
        //       }
        //     }),
        // bottomNavigationBar: FFNavigationBar(
        //   theme: FFNavigationBarTheme(
        //     barBackgroundColor: Colors.white,
        //     selectedItemBackgroundColor: primarySwatch[50]!,
        //     selectedItemIconColor: Colors.black,
        //     selectedItemLabelColor: Colors.black,
        //   ),
        //   selectedIndex: selectedIndex,
        //   onSelectTab: (index) {
        //     setState(() {
        //       selectedIndex = index;
        //     });
        //   },
        //   items: [
        //     FFNavigationBarItem(
        //       iconData: Icons.feed_outlined,
        //       label: 'News',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.schedule_outlined,
        //       label: 'Schedule',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.school_outlined,
        //       label: 'Career',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.groups_outlined,
        //       label: 'Team',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.account_circle_outlined,
        //       label: 'Settings',
        //     ),
        //   ],
        // ),
        );
  }
}

class FeedPost extends StatefulWidget {
  PostModal post;
  int index;

  FeedPost({
    required this.post,
    required this.index,
  });

  @override
  _FeedPostState createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  int currentIndex = 0;
  PageController controller = PageController();

  // double heartsize = 20;
  // double? _update() {
  //   setState(() {
  //     heartsize = 30;
  //   });
  //   Future.delayed(Duration(milliseconds: 500), () {
  //     setState(() {
  //       heartsize = 25;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _newsNotifier = context.read(newsNotifierProvider);
    bool popup = true;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:AssetImage('assets/images/logo.png'), 
                    // NetworkImage(
                    //   widget.post.userImage!,
                    // ),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Avodah",
                          // widget.post.firstName!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${widget.post.timeDifference}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black38),
                        ),
                        Text(
                          "${widget.post.title}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  // const Icon(Icons.more_vert),
                  // IconButton(onPressed: () {}, icon: )
                ],
              ),
            ),
            if (widget.post.resourceUrl != null) ...[
              Container(
                width: size.width,
                constraints: BoxConstraints(maxHeight: size.height * .60),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: MultipleImageView(
                      images: [widget.post.resourceUrl],
                      mediaType: MediaType.IMAGE,
                      post: widget.post,
                      index: widget.index,
                      Pagecontroller: controller,
                      onIndexChanged: (a) {
                        currentIndex = a;
                        setState(() {});
                      },
                    )),
              )
            ] else ...[
              widget.post.notificationUrl.toString().isNotEmpty
                  ? YouTubePlayer(
                    post: widget.post,
                    index: widget.index,
                      url: widget.post.notificationUrl!,
                    )
                  : SizedBox(),
            ],
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Heartanimating(
                        isAnimating: widget.post.liked!,
                        alwaysAnimated: true,
                        child: InkWell(
                            onTap: () {
                              !widget.post.liked!
                                  ? _newsNotifier.like(widget.index)
                                  : _newsNotifier.dislike(widget.index);
                              //  _update();
                            },
                            child: widget.post.liked!
                                ? Icon(
                                    Icons.favorite,
                                    size: 28,
                                    color: Colors.red[900],
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    size: 28,
                                  )),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("${widget.post.likesCount}"),
                      SizedBox(
                        width: 10,
                      ),
                      // LikeButton(
                      //   size: 22,
                      //   circleColor: CircleColor(
                      //       start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      //   bubblesColor: BubblesColor(
                      //     dotPrimaryColor: Color(0xff33b5e5),
                      //     dotSecondaryColor: Color(0xff0099cc),
                      //   ),
                      //   // onTap: ( isLiked) {
                      //   //   isLiked != isLiked;
                      //   //   return !widget.post.liked!
                      //   //       ? _newsNotifier.like(widget.index)
                      //   //       : _newsNotifier.dislike(widget.index);
                      //   // },
                      //   likeBuilder: (isLiked) {
                      //     Icon(
                      //       Icons.favorite,
                      //       color: isLiked ? Colors.red : Colors.grey,
                      //       size: 22,
                      //     );

                      //   },

                      //   likeCount: widget.post.likesCount,
                      // ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CommentTab(widget.post, widget.index),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(FontAwesomeIcons.comment),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CommentTab(widget.post, widget.index),
                                  ),
                                );
                              },
                            ),
                            Text("${widget.post.commentCount} comments"),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      // const Text("comment"),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ImageIndicator(
                        pageController: controller, totalIndex: 1),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            DescriptionTextWidget(
              sender: widget.post.firstName,
              text: widget.post.notificationText!,
              index: widget.index,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: RichText(
            //             maxLines: 3,
            //             overflow: TextOverflow.ellipsis,
            //             text: TextSpan(
            //               children: [
            //                 TextSpan(
            //                     text: "${widget.post.firstName}  ",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .bodyText1!
            //                         .copyWith(
            //                             fontWeight: FontWeight.w600,
            //                             fontSize: 14)),
            //                 WidgetSpan(
            //                     alignment: PlaceholderAlignment.baseline,
            //                     baseline: TextBaseline.alphabetic,
            //                     child: DescriptionTextWidget(
            //                       text: widget.post.notificationText!,
            //                     )),
            //                 // TextSpan(ss
            //                 //   text: widget.post.notificationText!.length
            //                 //       .toString(),
            //                 //   style: TextStyle(
            //                 //     fontWeight: FontWeight.w600,
            //                 //     fontSize: 14,
            //                 //     color: Colors.black.withOpacity(.8),
            //                 //   ),
            //                 // ),
            //               ],
            //             )),
            //       )
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageIndicator extends StatefulWidget {
  final int totalIndex;
  final PageController pageController;
  const ImageIndicator(
      {required this.pageController, required this.totalIndex, Key? key})
      : super(key: key);

  @override
  _ImageIndicatorState createState() => _ImageIndicatorState();
}

class _ImageIndicatorState extends State<ImageIndicator> {
  int currentIndex = 0;
  double width = 40;
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    widget.pageController.addListener(() {
      if (mounted) {
        setState(() {
          currentIndex = widget.pageController.page!.round();
        });
      }
      setScoll();
    });
    super.initState();
  }

  setScoll() {
    controller.animateTo(((6 - 2) * currentIndex).toDouble(),
        duration: Duration(milliseconds: 80), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: !(widget.totalIndex > 1)
          ? Container()
          : Container(
              height: 50,
              width: width,
              child: SingleChildScrollView(
                controller: controller,
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int a = 0; a < widget.totalIndex; a++)
                      Container(
                        width: 6.0,
                        height: 6.0,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : primaryColor)
                                    .withOpacity(a == currentIndex ? .9 : 0.4)),
                      )
                  ],
                )),
              ),
            ),
    );
  }
}

class MultipleImageView extends StatefulWidget {
  final List<String> images;
  final MediaType mediaType;
  var post;
  var index;
  final Function(int) onIndexChanged;
  final PageController Pagecontroller;
  MultipleImageView(
      {required this.post,
      required this.index,
      required this.images,
      required this.mediaType,
      required this.Pagecontroller,
      required this.onIndexChanged,
      Key? key})
      : super(key: key);

  @override
  _MultipleImageViewState createState() => _MultipleImageViewState();
}

class _MultipleImageViewState extends State<MultipleImageView> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _newsNotifier = context.read(newsNotifierProvider);
    if (widget.images.length == 1) {
      return NetworkImagesLoader(
        post: _newsNotifier.total_news[widget.index],
        index: widget.index,
        url: widget.images.first,
        fit: BoxFit.cover,
      );
    }
    return Container(
      child: PageView(
        controller: widget.Pagecontroller,
        onPageChanged: widget.onIndexChanged,
        children: [
          ...widget.images
              .map((e) => NetworkImagesLoader(
                    post: _newsNotifier.total_news[widget.index],
                    index: widget.index,
                    url: e,
                    fit: BoxFit.cover,
                  ))
              .toList(),
        ],
      ),
    );
    // return CarouselSlider.builder(
    //     itemCount: images.length,
    //     itemBuilder: (con, a, b) {
    //       return Image.network(
    //         images[a],
    //         fit: BoxFit.cover,
    //       );
    //     },
    //     options: CarouselOptions(
    //       viewportFraction: 1,
    //       enlargeCenterPage: false,
    //     ));
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String? sender;
  String? text;
  int index;

  DescriptionTextWidget(
      {required this.sender, required this.text, required this.index});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String? firstHalf;
  String? secondHalf;
  late YoutubePlayerController _controller;
  bool flag = true;
  bool isLink = false;
  List listString = [];
  String showTitle = '';
  String link = '';
  int limit = 120;
  bool linkIsWithIn50 = false;
  List largerList = ["", "", "", ""];
  @override
  void initState() {
    super.initState();
    int firstTagstartIndex = widget.text!.indexOf("<br><a");
    if (firstTagstartIndex != -1) {
      // int firstTagstartIndex = widget.text!.indexOf("<br><a");
      int linkedStartIndex = widget.text!.indexOf("href='");
      int firstTagEndIndex = widget.text!.indexOf("'>", firstTagstartIndex + 1);
      int tagEndIndex = widget.text!.indexOf("</a>", firstTagEndIndex);
      showTitle = widget.text!.substring(firstTagEndIndex + 2, tagEndIndex);
      link = widget.text!.substring(linkedStartIndex + 6, firstTagEndIndex);
      int urlEnd = widget.text!.indexOf("</a>", firstTagEndIndex);
      String removeString =
          widget.text!.substring(firstTagstartIndex, urlEnd + 4);
      listString = widget.text!.split(removeString);
      // String remove = widget.text.split(pattern)

      widget.text = listString[0] + " ${showTitle} " + listString[1];
      isLink = true;
      if (widget.text!.length > limit) {
        if (widget.text!.indexOf(showTitle) > limit) {
          firstHalf = widget.text!.substring(0, limit);
          String lo = widget.text!.substring(limit, widget.text!.length);
          List _local = lo.split(showTitle);
          largerList[2] = _local[0];
          largerList[3] = _local[1];
        } else {
          linkIsWithIn50 = true;
          String lo = widget.text!.substring(0, limit);
          List _local = lo.split(showTitle);
          largerList[0] = _local[0];
          largerList[1] = _local[1];
        }
        // firstHalf = widget.text!.substring(0, 50);
        // secondHalf = widget.text!.substring(50, widget.text!.length);
        secondHalf = " ";
      } else {
        secondHalf = "";
      }
    } else {
      if (widget.text!.length > limit) {
        firstHalf = widget.text!.substring(0, limit);
        secondHalf = widget.text!.substring(limit, widget.text!.length);
      } else {
        firstHalf = widget.text;
        secondHalf = "";
      }
    }
    setState(() {});
  }

  final style = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: Colors.black.withOpacity(.8),
  );
  @override
  Widget build(BuildContext context) {
    final _newsNotifier = context.read(newsNotifierProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: secondHalf!.isEmpty
              ? isLink
                  ? RichText(
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: widget.sender.toString() + " ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                          TextSpan(
                            text: listString[0].toString() + " ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black.withOpacity(.8),
                            ),
                          ),
                          TextSpan(
                            text: showTitle.toString(),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => WebViewExample(
                                              url: link,
                                            )));
                              },
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.blue.withOpacity(.8),
                            ),
                          ),
                          // if (listString.length > 2)
                          //   TextSpan(
                          //     text: listString[1].toString(),
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.w600,
                          //       fontSize: 14,
                          //       color: Colors.black.withOpacity(.8),
                          //     ),
                          //   ),
                        ],
                      ))
                  : RichText(
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: widget.sender.toString() + " ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                          TextSpan(
                            text: firstHalf.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black.withOpacity(.8),
                            ),
                          ),
                        ],
                      ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    isLink
                        ? linkIsWithIn50
                            ? RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: widget.sender.toString() + " ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14)),
                                    TextSpan(
                                      text: largerList[0].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(.8),
                                      ),
                                    ),
                                    TextSpan(
                                      text: showTitle.toString(),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      WebViewExample(
                                                        url: link,
                                                      )));
                                        },
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.blue.withOpacity(.8),
                                      ),
                                    ),
                                    if (!flag)
                                      TextSpan(
                                        text: largerList[1].toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(.8),
                                        ),
                                      ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.baseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: InkWell(
                                        child: Text(
                                          flag ? "  more" : "  less",
                                          style: TextStyle(
                                            color: Colors.blue.shade500,
                                            // fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            flag = !flag;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                            : RichText(
                                // overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: widget.sender.toString() + " ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14)),
                                  TextSpan(
                                    text: flag
                                        ? (firstHalf.toString() + "...")
                                        : (firstHalf.toString() +
                                                largerList[2]!)
                                            .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(.8),
                                    ),
                                  ),
                                  if (!flag)
                                    TextSpan(
                                      text: showTitle.toString(),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      WebViewExample(
                                                        url: link,
                                                      )));
                                        },
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.blue.withOpacity(.8),
                                      ),
                                    ),
                                  if (!flag)
                                    TextSpan(
                                      text: largerList[3].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(.8),
                                      ),
                                    ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: InkWell(
                                      child: Text(
                                        flag ? "  more" : "  less",
                                        style: TextStyle(
                                          color: Colors.blue.shade500,
                                          // fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          flag = !flag;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ))
                        : RichText(
                            // overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                            children: [
                              TextSpan(
                                  text: widget.sender.toString() + " ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                              TextSpan(
                                text: flag
                                    ? (firstHalf.toString() + "...")
                                    : (firstHalf.toString() + secondHalf!)
                                        .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(.8),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: InkWell(
                                  child: Text(
                                    flag ? "  more" : "  less",
                                    style: TextStyle(
                                      color: Colors.blue.shade500,
                                      // fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      flag = !flag;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )),
                  ],
                ),
        ),
      ],
    );
  }
}

class WebViewExample extends StatefulWidget {
  String url;
  WebViewExample({required this.url});
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  WebViewController? controller;
  @override
  void initState() {
    super.initState();

    // Enable virtual display.
    // FlutterWebviewPlugin().onUrlChanged.listen((event) {
    //   log("url cahnged... " + event.toString());
    // });
    // FlutterWebviewPlugin().launch(widget.url);
    // loadData();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  loadData(String url) async {
    if (url.startsWith("mailto") ||
        url.startsWith("whatsup") ||
        url.startsWith("file") ||
        url.startsWith("telnet") ||
        url.startsWith("intent") ||
        url.startsWith("market") ||
        url.startsWith("app://")) {
      // log('Handle your Error Page here');
      Navigator.pop(context);
      await launch(widget.url);
      // if (await canLaunch(url)) {}
    }
  }
//   webView.setWebViewClient(new WebViewClient() {
// @Override
// public boolean shouldOverrideUrlLoading(WebView view, String url) {
//     if (Uri.parse(url).getScheme().equals("market")) {
//         try {
//             Intent intent = new Intent(Intent.ACTION_VIEW);
//             intent.setData(Uri.parse(url));
//             Activity host = (Activity) view.getContext();
//             host.startActivity(intent);
//             return true;
//         } catch (ActivityNotFoundException e) {
//             Uri uri = Uri.parse(url);
//             view.loadUrl("http://play.google.com/store/apps/" + uri.getHost() + "?" + uri.getQuery());
//             return false;
//         }

//     }
//     return false;
// }
// })

  @override
  Widget build(BuildContext context) {
    // log("loadded url " + widget.url);
    // return WebviewScaffold(
    //   url: widget.url,
    //   appBar: new AppBar(
    //     title: new Text("Widget webview"),
    //   ),
    // );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          title: Container(
            // color: Colors.teal,
            height: 50,
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.url,

          onWebViewCreated: (v) {},
          onWebResourceError: (WebResourceError webviewerrr) {
            loadData(webviewerrr.failingUrl!);
            // log("Handle your Error Page here = ${webviewerrr.failingUrl}");
          },
          allowsInlineMediaPlayback: true,
          // onWebViewCreated: (controller) {
          //   log("url" + widget.url);
          //   controller.loadUrl(
          //     widget.url,
          //   );
          //   this.controller = controller;
          // },
          // onPageStarted: (s) {
          //   log("page started " + s);
          // },
          // onWebResourceError: (e) {
          //   if (e.failingUrl?.contains(RegExp('intent://')) ?? false) {
          //     _launchURL(e.failingUrl.toString());
          //   }
          //   log("error " + e.failingUrl.toString());
          //   // controller?.loadUrl(e.failingUrl
          //   //     .toString()
          //   //     .replaceAll("scheme=https", "scheme=http"));
          // },

          debuggingEnabled: true,
          // javascriptMode: JavascriptMode.unrestricted,
          // navigationDelegate: (NavigationRequest request) {
          //   if (request.url.contains("uber")) {
          //     _launchURL(request.url);
          //     return NavigationDecision.prevent;
          //   } else if (request.url.contains("tel:")) {
          //     _launchURL(request.url);
          //     return NavigationDecision.prevent;
          //   } else if (request.url.contains("https://wa.me/")) {
          //     _launchURL(request.url);
          //     return NavigationDecision.prevent;
          //   } else if (request.url.contains("mailto:")) {
          //     _launchURL(request.url);
          //   } else if (request.url.contains("market://")) {
          //     return NavigationDecision.prevent;
          //   }
          // }

          // initialUrl: 'https://youtu.be/3aiAxE53yhA',
        ),
      ),
    );
  }
}

// class WebViewExample extends StatefulWidget {
//   final String url;
//   const WebViewExample({required this.url});
//   @override
//   WebViewExampleState createState() => WebViewExampleState();
// }

// class WebViewExampleState extends State<WebViewExample> {
//   @override
//   void initState() {
//     super.initState();
//     // Enable virtual display.
//     if (Platform.isAndroid) WebView.platform = AndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: primaryColor,
//           title: Container(
//             // color: Colors.teal,
//             height: 50,
//             child: Image.asset("assets/images/logo.png"),
//           ),
//         ),
//         body: WebView(
//           javascriptMode: JavascriptMode.unrestricted,
//           initialUrl: widget.url,
//           // initialUrl: 'https://youtu.be/3aiAxE53yhA',
//         ),
//       ),
//     );
//   }
// }
