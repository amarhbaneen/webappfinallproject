import 'dart:typed_data';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webappfinallproject/utils/firebaseApi/fireBaseApi.dart'
    as firebaseapi;

Widget pyacheck() {
  return Card(
    elevation: 5,
    child: InkWell(
      onTap: () async {
        var picked = await FilePicker.platform.pickFiles();
        PdfDocument document =
            PdfDocument(inputBytes: picked?.files.single.bytes);
        PdfTextExtractor extractor = PdfTextExtractor(document);
        String text = extractor.extractText();
        List userDetails = getDate(text);
        print(userDetails);
        if (picked != null) {
          try {
            Uint8List? uploadfile = picked.files.single.bytes;
            String filename = picked.files.single.name;
            firebaseapi.FireBaseApi.uploadPayCheck(
                uploadfile, filename, userDetails[0], userDetails[1]);
          } catch (e) {
            print(e);
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
        width: 600,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'upload paycheck',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Icon(
                Ionicons.cloud_upload_outline,
                color: Colors.indigo[400],
                size: 30,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

List getDate(String text) {
  int idx = text.indexOf(",");
  int slash = text.indexOf('\n');
  String id = text.substring(0, slash).trim();
  List parts = [id.substring(0, idx).trim(), id.substring(idx + 1).trim()];
  idx = text.indexOf(":");
  id = parts[0].substring(idx + 1, parts[0].length).trim();
  String date = parts[1].substring(idx + 2, parts[1].length).trim();
  return [id, date];
}
