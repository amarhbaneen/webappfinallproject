import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'firebaseFile.dart';

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
}
