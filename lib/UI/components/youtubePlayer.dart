import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:southwind/UI/components/NetworkImageLoader.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Models/news/postModal.dart';

class YouTubePlayer extends StatefulWidget {
  bool? autoplay;
  String url;

  PostModal? post;
  int? index;
  YouTubePlayer({required this.url, this.autoplay = false, this.post,this.index, Key? key})
      : super(key: key);

  @override
  State<YouTubePlayer> createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  // late YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: int initState
    //loadData();
  }

  // loadData() async {
  //   int lastPoss = widget.url.toString().lastIndexOf('/');
  //   List<String> listData = widget.url.toString().split('watch?v=');
  //   String videoId = listData.length < 2
  //       ? widget.url.toString().substring(lastPoss + 1)
  //       : widget.url.split('watch?v=')[1];

  //   _controller = YoutubePlayerController(
  //     initialVideoId: videoId,
  //     flags: YoutubePlayerFlags(
  //       autoPlay: widget.autoplay!,
  //       hideControls: true,
  //       mute: false,
  //     ),
  //   );
  // }

  @override
  void dispose() {
    // _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (v) => FullScreenYoutube(
                        url: widget.url,
                      )));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            videoNetworkImagesLoader(
                index: widget.index,
                post: widget.post,
                radius: 10,
                url:
                    'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(widget.url.toString())}/0.jpg'),
            // YoutubePlayer(
            //   controller: _controller,
            //   showVideoProgressIndicator: true,
            //   // bottomActions: [
            //   //   yoputubeSubWidgets(),            
            ////   //   IconButton(
            //   //       onPressed: () {
            //   //         // _controller.pause();
            //   //       },
            //   //       icon: Icon(
            //   //         Icons.fullscreen,
            //   //         color: Colors.white,
            //   //       ))
            //   // ],
            // ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.play_arrow),
                )),
          ],
        ),
      ),
    );
  }
}

class FullScreenYoutube extends StatefulWidget {
  final String url;
  const FullScreenYoutube({required this.url, Key? key}) : super(key: key);

  @override
  State<FullScreenYoutube> createState() => _FullScreenYoutubeState();
}

class _FullScreenYoutubeState extends State<FullScreenYoutube> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: int initState
    loadData();
  }

  loadData() async {
    int lastPoss = widget.url.toString().lastIndexOf('/');
    List<String> listData = widget.url.toString().split('watch?v=');
    String videoId = listData.length < 2
        ? widget.url.toString().substring(lastPoss + 1)
        : widget.url.split('watch?v=')[1];

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // widget.controller.flags = YoutubePlayerFlags(
    //   autoPlay: widget.autoplay!,
    //   mute: false,
    // );
    return SafeArea(
      child: Material(
        child: Container(
          color: Colors.black,
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: YoutubePlayer(
                  controller: _controller,
                  // bottomActions: [
                  //   yoputubeSubWidgets(),
                  //   IconButton(
                  //       onPressed: () {
                  //         Navigator.pop(context);
                  //       },
                  //       icon: Icon(
                  //         Icons.fullscreen,
                  //         color: Colors.white,
                  //       ))
                  // ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      shape: BoxShape.circle),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget yoputubeSubWidgets() {
  return Expanded(
    child: Row(
      children: [
        const SizedBox(width: 14.0),
        CurrentPosition(),
        const SizedBox(width: 8.0),
        ProgressBar(
          isExpanded: true,
          // colors: widget.progressColors,
        ),
        RemainingDuration(),
      ],
    ),
  );
}
