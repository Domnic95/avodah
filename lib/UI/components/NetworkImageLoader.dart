import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

import '../../Models/news/postModal.dart';
import '../../data/providers/providers.dart';

class Showimage extends StatelessWidget {
  final String imageurl;
  const Showimage({Key? key, required this.imageurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: InteractiveViewer(
          panEnabled: true, // Set it to false to prevent panning.
          boundaryMargin: EdgeInsets.all(0),

          maxScale: 4,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(imageurl),
          ),
        ),
      ),
    );
  }
}

class NetworkImagesLoader extends StatefulWidget {
  String url;
  BoxFit? fit;
  double? radius;
  PostModal? post;
  int? index;

  NetworkImagesLoader({
    required this.url,
    this.fit = BoxFit.cover,
    this.radius = 0.0,
    this.post,
    this.index,
  });

  @override
  State<NetworkImagesLoader> createState() => _NetworkImagesLoaderState();
}

class _NetworkImagesLoaderState extends State<NetworkImagesLoader> {
  bool heart = false;
  bool isheartanimating = false;
  @override
  Widget build(BuildContext context) {
    final _newsNotifier = context.read(newsNotifierProvider);
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Showimage(imageurl: widget.url)));
            //Showimage(imageurl: url);
          },
          onDoubleTap: () {
            if (widget.post!.liked == false) {
              _newsNotifier.like(widget.index!);
            }
            setState(() {
              heart = true;
              isheartanimating = true;
            });
            // setState(() {
            //   heart = true;
            // });
            // Future.delayed(const Duration(milliseconds: 500), () {
            //   setState(() {
            //     heart = false;
            //   });
            // });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius!),
            child: Image.network(
              widget.url,
              fit: widget.fit,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  child: Center(
                      child: Text(
                    "Can't load the image",
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  )),
                );
              },
            ),
          ),
        ),
        // heart == true
        //?
        Heartanimating(
            isAnimating: isheartanimating,
            duration: Duration(milliseconds: 700),
            child: Icon(
              Icons.favorite,
              size: isheartanimating ? 80 : 0,
              color: Colors.white,
            ),
            onEnd: () => setState(() => isheartanimating = false))
        // : Icon(
        //     Icons.favorite,
        //     size: 0,
        //   )
      ],
    );
  }
}

class Heartanimating extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final bool alwaysAnimated;
  final Duration duration;
  final VoidCallback? onEnd;
  Heartanimating(
      {Key? key,
      required this.child,
      required this.isAnimating,
      this.alwaysAnimated = false,
      this.duration = const Duration(milliseconds: 150),
      this.onEnd})
      : super(key: key);

  @override
  State<Heartanimating> createState() => _HeartanimatingState();
}

class _HeartanimatingState extends State<Heartanimating>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final halfDuration = widget.duration.inMilliseconds ~/ 2;
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: halfDuration));
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant Heartanimating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      doAnimation();
    }
  }

  Future doAnimation() async {
    if (widget.isAnimating || widget.alwaysAnimated) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(Duration(milliseconds: 400));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: scale,
        child: widget.child,
      );
}

class videoNetworkImagesLoader extends StatefulWidget {
  String url;
  BoxFit? fit;
  double? radius;
  PostModal? post;
  int? index;
  videoNetworkImagesLoader({
    required this.url,
    this.fit = BoxFit.cover,
    this.radius = 0.0,
    this.post,
    this.index,
  });

  @override
  State<videoNetworkImagesLoader> createState() =>
      _videoNetworkImagesLoaderState();
}

class _videoNetworkImagesLoaderState extends State<videoNetworkImagesLoader> {
  bool heart = false;
  bool isheartanimating = false;
  @override
  Widget build(BuildContext context) {
    final _newsNotifier = context.read(newsNotifierProvider);
    return Stack(  alignment: Alignment.center,
      children: [
        GestureDetector(
          onDoubleTap: () {
            if (widget.post!.liked == false) {
              _newsNotifier.like(widget.index!);
            }
            setState(() {
              heart = true;
              isheartanimating = true;
            });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius!),
            child: Image.network(
              widget.url,
              fit: widget.fit,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  child: Center(
                      child: Text(
                    "Can't load the image",
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  )),
                );
              },
            ),
          ),
        ),
           Heartanimating(
            isAnimating: isheartanimating,
            duration: Duration(milliseconds: 700),
            child: Icon(
              Icons.favorite,
              size: isheartanimating ? 80 : 0,
              color: Colors.white,
            ),
            onEnd: () => setState(() => isheartanimating = false))
      ],
    );
  }
}
