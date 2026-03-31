import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Data {
  Timestamp? updatedDateTime;
  Timestamp? createdDateTime;
  String? docId;
  Data.fromJson(Map<String, dynamic> json) {
    this.updatedDateTime = json["updatedDateTime"];
    this.createdDateTime = json["createdDateTime"];
    this.docId = json["docId"];
  }
  Map<String, dynamic> toJson();

  void printData() {
    var data = this.toJson();
    var className = this.runtimeType;
    print("printxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx: $className");
    data.keys.forEach((key) {
      var value = data[key];
      print("$key : $value");
    });
  }
}
