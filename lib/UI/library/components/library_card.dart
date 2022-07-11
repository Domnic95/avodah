// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:southwind/Models/library_model.dart';
import 'package:southwind/UI/library/video_tab.dart';
import 'package:southwind/UI/theme/apptheme.dart';

class LibraryCard extends StatelessWidget {
  LibraryModel libraryModel;
  LibraryCard({required this.libraryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => LibraryResource(
                    libraryModel: libraryModel,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor, width: .5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
              )
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(
              //   width: 10,
              // ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    libraryModel.resourceTitle!,
                    //style: TextStyle(height: 1.5),
                  ),
                ),
              ),
              // SizedBox(
              //   width: 40,
              // ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: primarySwatch[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
