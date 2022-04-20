

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webappfinallproject/utils/firebaseApi/fireBaseApi.dart' as firebaseapi;


var carMake;

Widget pyacheck() {

  return Card(
      elevation: 5,
      child:
          InkWell(
            onTap:() async {
              var picked = await FilePicker.platform.pickFiles();
              if (picked != null) {
                try {
                  Uint8List? uploadfile = picked.files.single.bytes;
                  // File pdfile = File(picked.files.first.name);
                  // PDFDoc  _pdfDoc = await PDFDoc.fromFile(pdfile);
                  // String text = await _pdfDoc.text;


                  String filename = picked.files.single.name;
                  firebaseapi.FireBaseApi.uploadPayCheck(uploadfile,filename);

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
                      style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
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



//
//
//
// Widget BuildDropDown()
// {
//   return Column(
//     children: [
//       Expanded(child: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('users').snapshots(),
//           builder: (BuildContext context,
//               AsyncSnapshot<QuerySnapshot> snapshot)
//           {
//
//           if (!snapshot.hasData) return Container();
//           // Set this value for default,
//           // setDefault will change if an item was selected
//           // First item from the List will be displayed
//
//           return DropdownButton(
//           isExpanded: false,
//           value: carMake,
//           items: snapshot.data?.docs.map((value) {
//           return DropdownMenuItem(
//           value: value.get('email'),
//           child: Text('${value.get('email')}'),
//           );
//           }).toList(), onChanged: (Object? value) {  },
//       );
//       }))
//     ],
//   );
// }
