import 'package:codedevweb/app/data/data.dart';

class MessData extends Data {
  String? content;
  String? sendDateTime;
  String? sendUserID;
  String? receivedUserID;
  bool? isYourMess;

  MessData(
      {this.content, this.sendDateTime, this.sendUserID, this.receivedUserID})
      : super.fromJson({});
  MessData.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    this.content = json["content"];
    this.sendDateTime = json["sendDateTime"];
    this.sendUserID = json["sendUserID"];
    this.receivedUserID = json["receivedUserID"];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["content"] = this.content;
    if (this.sendDateTime != null) data["sendDateTime"] = this.sendDateTime;
    if (this.sendUserID != null) data["sendUserID"] = this.sendUserID;
    if (this.receivedUserID != null)
      data["receivedUserID"] = this.receivedUserID;
    return data;
  }
}
