import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';

import 'package:southwind/Models/career/careerModel.dart';
import 'package:southwind/UI/components/PdfViewer.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/components/youtubePlayer.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

showInformationDialog(BuildContext context) {
  showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return InformationDialog();
      });
}

class InformationDialog extends StatefulHookWidget {
  const InformationDialog({Key? key}) : super(key: key);

  @override
  _InformationDialogState createState() => _InformationDialogState();
}

enum InformationMediaType { Image, Video, message, PDF, Audio }

class _InformationDialogState extends State<InformationDialog> {
  late YoutubePlayerController _controller;
  Widget? widgets;
  Widget? pdfWidget;
  bool isVideo = false;
  late InformationMediaType mediaTypes;
  late CareerAchievement achievement;
  @override
  void dispose() {
    if (isVideo) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    achievement = context.read(carerNotifierProvider).selectedAchievement;

    if (achievement.attachmentUrl != null && achievement.attachmentUrl != '') {
      //  int lastPoss = achievement.attachmentUrl!.toString().lastIndexOf('/');
      //  List<String> listData = achievement.attachmentUrl!.toString().split('watch?v=');
      //  String videoId  =listData.length<2?achievement.attachmentUrl!.toString().substring(lastPoss+1)
      //  : achievement.attachmentUrl!.split('watch?v=')[1];

      // //  print('videoIdFind = ${videoId}');
      // //     _controller = YoutubePlayerController(
      // //       initialVideoId: videoId,
      // //       flags: YoutubePlayerFlags(
      // //         autoPlay: true,
      // //         mute: true,
      // //       ),
      // //     );
      // //     isVideo = true;

      // //     widgets = YoutubePlayer(
      // //       controller: _controller,
      // //       showVideoProgressIndicator: true,

      // //       // videoProgressIndicatorColor: Colors.amber,
      // //       // progressColors: ProgressColors(
      // //       //     playedColor: Colors.amber,
      // //       //     handleColor: Colors.amberAccent,
      // //       // ),
      // //       // onReady (v) {
      // //       //     _controller.addListener(listener);
      // //       // },
      // //     );
      mediaTypes = InformationMediaType.Video;
    }

    if (achievement.cloudinarySecureUrl != "" &&
        achievement.cloudinarySecureUrl != null) {
      int lastDot = achievement.cloudinarySecureUrl!.lastIndexOf('.');
      String extension = achievement.cloudinarySecureUrl!
          .substring(lastDot + 1, achievement.cloudinarySecureUrl!.length);

      if (extension == 'pdf') {
        PDFDocument document = await PDFDocument.fromURL(
          achievement.cloudinarySecureUrl!,
          /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
        );

        pdfWidget = PdfViwer(
          height: 200,
          document: document,
        );
        mediaTypes = InformationMediaType.PDF;
      } else if (extension == 'jpg') {
        mediaTypes = InformationMediaType.Image;
      } else {
        mediaTypes = InformationMediaType.message;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Material(
        child: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (mediaTypes == InformationMediaType.Video)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: YouTubePlayer(
                                  url: achievement.attachmentUrl!.toString(),
                                ),
                              ),
                            if (mediaTypes == InformationMediaType.PDF)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: pdfWidget,
                              ),
                            if (mediaTypes == InformationMediaType.Image)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  achievement.cloudinarySecureUrl!,
                                  height: size.width * 0.5,
                                  width: size.width,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            if (mediaTypes == InformationMediaType.message &&
                                !isVideo)
                              Center(
                                child: Text('No data found'),
                              )
                          ],
                        ),
                      ),
                    )),
                    CommonButton(
                      lable: "Continue",
                      ontap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage("assets/images/demo.png"),
              //         fit: BoxFit.cover),
              //     color: Colors.white,
              //   ),
              // ),
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
                      size: 24,
                    ),
                  ),
                ),
                right: 5,
                top: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
