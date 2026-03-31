import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomStreamParams<T> {
  String colectionPath;
  T Function(Map<String, dynamic> map) converter;
  List<T> Function(List<T> list)? formatData;
  CustomStreamParams(
      {required this.colectionPath, required this.converter, this.formatData});
}

// ignore: must_be_immutable
class CustomStreamBuilder<T, M extends StatelessWidget>
    extends StatelessWidget {
  CustomStreamParams<T> streamParams;
  M Function(T data) buildElement;
  CustomStreamBuilder({required this.streamParams, required this.buildElement});

  Stream<List<T>> stream() async* {
    var CustomStreamParams(:colectionPath, :converter, :formatData) =
        streamParams;
    List<T> listData = [];

    var colectionRef = FirebaseFirestore.instance
        .collection(colectionPath)
        .orderBy("updatedDateTime");

    var dataStream = colectionRef.snapshots();

    await for (var dataSnap in dataStream) {
      listData.clear();
      for (var dataDoc in dataSnap.docs) {
        var dataMap = dataDoc.data();
        dataMap["docId"] = dataDoc.id;
        var data = converter(dataMap);
        listData.add(data);
      }
      if (formatData != null) {
        listData = formatData(listData);
      }
      yield listData;
    }
  }

  StreamBuilder getStreamBuilder() {
    var streamBuilder = StreamBuilder<List<T>>(
        stream: stream(),
        builder: (BuildContext context, AsyncSnapshot<List<T>> dataSnap) {
          if (dataSnap.hasError) return new Text('Error: ${dataSnap.error}');
          switch (dataSnap.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (dataSnap.data!.isEmpty) {
                return Text("Empty ....");
              }
              return ListView(
                  children: dataSnap.data!.map((T data) {
                return buildElement(data);
              }).toList());
          }
        });
    return streamBuilder;
  }

  @override
  Widget build(BuildContext context) {
    return getStreamBuilder();
  }
}
