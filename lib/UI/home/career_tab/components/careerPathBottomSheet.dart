import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/career/careerModel.dart';
import 'package:southwind/data/providers/providers.dart';

class CareerpathBottomSheet extends StatefulHookWidget {
  CareerpathBottomSheet({Key? key}) : super(key: key);

  @override
  _CareerpathBottomSheetState createState() => _CareerpathBottomSheetState();
}

class _CareerpathBottomSheetState extends State<CareerpathBottomSheet> {
  String _selectedOptionValue = "";
  int _selectedOptionId = 0;
  String defaultOption = '';
  @override
  Widget build(BuildContext context) {
    final careerProvider = useProvider(carerNotifierProvider);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
              itemCount: careerProvider.careerModel.careerPath!.length,
              itemBuilder: (context, index) {
                print("index : " + index.toString());
                return InkWell(
                  onTap: () {
                    careerProvider.setIndexAndPath(
                        careerProvider.careerModel.careerPath![index], index);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      careerProvider.selectedCareerPathIndex ==
                                              index
                                          ? Theme.of(context).primaryColor
                                          : null,
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(careerProvider
                              .careerModel.careerPath![index].name!))
                    ],
                  ),
                );
              })),
    );
  }
}
