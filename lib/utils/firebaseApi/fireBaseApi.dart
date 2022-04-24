import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:webappfinallproject/models/payCheckModel.dart';
import 'firebaseFile.dart';
import 'package:uuid/uuid.dart';

class FireBaseApi{
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
      final ref = result.items[index];
      final name = ref.name;
      final file = FirebaseFile(ref: ref, name: name, url: url);

      return MapEntry(index, file);
    })
        .values
        .toList();
  }
  static Future downloafFile(Reference ref) async{
    final url = await ref.getDownloadURL();
    final dir  =  await getExternalStorageDirectory();
    final file = File('${dir?.path}/${ref.name}');
    final respose =  await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: 0
      ),

    );
     final raf = file.openSync(mode: FileMode.write);
     raf.writeByteSync(respose.data);
     await raf.close();
  }
 static Future<void> downloadFileWeb(Reference ref) async {
    var url = await ref.getDownloadURL();
    html.window.open(url, '${ref.name}');


  }

  static Future uploadPayCheck(var uploadfile, String filename,String owenerid, String date) async {
    try{
    FirebaseStorage fs = FirebaseStorage.instance;
    var st = fs.ref().child('/pdfs/$filename');
    var uploadTask = st.putData(uploadfile!);
    String url = await (await uploadTask).ref.getDownloadURL();
    postPayCheck(url,owenerid,date);

  } catch (e) {
      print('error occured');
      return null;
    }

  }
  static Future postPayCheck(String url,String owenerid, String date) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var uuid = Uuid();
    payCheckModel userModel = payCheckModel(
        payCheckUrl: url,
        uid: uuid.v4() ,
        owneruid: owenerid,
        payCheckDate: date
    );

        await firebaseFirestore
        .collection("paychecks")
        .doc(userModel.uid)
        .set(userModel.toMap());


    // writing all the values


  }



}
