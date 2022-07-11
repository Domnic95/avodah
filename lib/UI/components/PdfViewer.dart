import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PdfViwer extends StatelessWidget {
  PDFDocument document;
  double height;
  PdfViwer({required this.document,required this.height,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height,
      child: PDFViewer(
        document: document,
        showNavigation: false,
        showPicker: false,
        navigationBuilder:
            (context, page, totalPages, jumpToPage, animateToPage) {
          return ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[],
          );
        },
      ),
    );
  }
}
