import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedevweb/app/data/data.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseComlib {
  static final _firebase = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;

  static Future<void> insertData<T extends Data>(
      String colectionPath, String docId, T data) async {
    CollectionReference collectionReference =
        _firebase.collection(colectionPath);
    await collectionReference.doc(docId).set({
      ...data.toJson(),
      "updatedDateTime": FieldValue.serverTimestamp(),
      "createdDateTime": FieldValue.serverTimestamp()
    });
  }

  static Future<Map<String, dynamic>> getData(
      String colectionPath, String docId) async {
    var docSnap = await _firebase.collection(colectionPath).doc(docId).get();
    return docSnap.data() ?? new Map<String, dynamic>();
  }

  static Future<String> uploadImage(String path, Uint8List data) async {
    String nameImage = DateTime.now().millisecondsSinceEpoch.toString();

    var reference = _storage.ref().child("$path/$nameImage");

    await reference.putData(
      data,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    return reference.getDownloadURL();
  }

  static Future<void> deleteImage(String url) async {
    var reference = _storage.refFromURL(url);
    await reference.delete();
  }

  static Future<Uint8List> dowloadImage(String url) async {
    var reference = _storage.refFromURL(url);
    Uint8List imageBytes =
        await reference.getData(100000000) ?? new Uint8List(0);
    return imageBytes;
  }
}
