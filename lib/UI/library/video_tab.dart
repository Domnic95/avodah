
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:southwind/Models/library_model.dart';
import 'package:southwind/UI/components/PdfViewer.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/components/youtubePlayer.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/library__notifier.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class LibraryResource extends StatefulWidget {
  LibraryModel libraryModel;
  LibraryResource({required this.libraryModel});
  @override
  _LibraryResourceState createState() => _LibraryResourceState();
}

class _LibraryResourceState extends State<LibraryResource> {
  late PDFDocument document;

  bool isLoading = true;
  String url = '';
  late LibraryMediaType libraryMediaType;
  void initState() {
    super.initState();
    if (widget.libraryModel.resourceVideoLink != "") {
      libraryMediaType = LibraryMediaType.youtube;
      //     String youtubeUrl =widget.libraryModel.resourceVideoLink !.toString();
      //     int lastPoss = youtubeUrl.lastIndexOf('/');
      //  List<String> listData = youtubeUrl.split('watch?v=');
      //  String videoId  =listData.length<2?youtubeUrl.substring(lastPoss+1)
      //  : youtubeUrl.split('watch?v=')[1];

      //  print('videoIdFind = ${videoId}');

      //     url = widget.libraryModel.resourceVideoLink!;
      //     _controller = YoutubePlayerController(
      //       initialVideoId: url.split('watch?v=')[1],
      //       flags: YoutubePlayerFlags(
      //         autoPlay: true,
      //         mute: true,
      //       ),
      //     );
    } else if (widget.libraryModel.cloudinarySecureUrl != "") {
      libraryMediaType = LibraryMediaType.pdf;
      url = widget.libraryModel.cloudinarySecureUrl!;
      loadPdf();
    } else {
      libraryMediaType = LibraryMediaType.none;
      url = widget.libraryModel.cloudinaryAudioSecureUrl!;
    }
  }

  loadPdf() async {
    document = await PDFDocument.fromURL(
      url,
      /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // if (libraryMediaType == LibraryMediaType.youtube) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: primaryColor,
        title: Text(
          widget.libraryModel.resourceTitle!,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: TextStyle(
              // color: primarySwatch[900],
              ),
        ),
        // title: Container(
        //   // color: Colors.teal,
        //   height: 50,
        //   child: Image.asset("assets/images/logo.png"),
        // ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (libraryMediaType == LibraryMediaType.youtube)
                // AspectRatio(
                //   aspectRatio: 16 / 9,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: YoutubePlayer(
                //       controller: _controller,
                //       showVideoProgressIndicator: true,

                //       // videoProgressIndicatorColor: Colors.amber,
                //       // progressColors: ProgressColors(
                //       //     playedColor: Colors.amber,
                //       //     handleColor: Colors.amberAccent,
                //       // ),
                //       // onReady (v) {
                //       //     _controller.addListener(listener);
                //       // },
                //     ),
                //     // child: BetterPlayer(
                //     //   controller: _betterPlayerController,
                //     // ),
                //   ),
                // ),
                YouTubePlayer(
                  url: widget.libraryModel.resourceVideoLink!.toString(),
                ),
              if (libraryMediaType == LibraryMediaType.pdf)
                isLoading
                    ? LoadingWidget()
                    : PdfViwer(
                        height: size.height * 0.6,
                        document: document,
                      ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.libraryModel.resourceDescription!,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
