import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/learning/individual_learning.dart';
import 'package:southwind/UI/components/NetworkImageLoader.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

showlearningInformationDialog(BuildContext context) {
  showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return LearningInfoDiaLog();
      });
}

class LearningInfoDiaLog extends StatefulHookWidget {
  LearningInfoDiaLog({Key? key}) : super(key: key);

  @override
  _LearningInfoDiaLogState createState() => _LearningInfoDiaLogState();
}

class _LearningInfoDiaLogState extends State<LearningInfoDiaLog> {
  // late YoutubePlayerController _controller;

  // bool isVideo = false;
  // @override
  // void dispose() {
  //   if (isVideo) {
  //     _controller.dispose();
  //   }

  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final _learningProvider = useProvider(learningProvider);
    return GestureDetector(
      onTap: () {},
      child: Material(
        child: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Column(
                  children: [
                    Expanded(
                        child: Center(
                            child: NetworkImagesLoader(
                      url: _learningProvider.selectedLearning!.resourceSecureUrl
                          .toString(),
                    ))),
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
