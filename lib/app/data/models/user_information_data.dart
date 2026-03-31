import 'package:codedevweb/app/data/data.dart';

class UserInformationData extends Data {
  String? name;
  String? dateOfBirth;
  String? email;
  String? phone;
  String? avatarUrl;

  UserInformationData({this.name, this.dateOfBirth, this.email, this.phone})
      : super.fromJson({});
  UserInformationData.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    this.name = json["name"];
    this.dateOfBirth = json["dateOfBirth"];
    this.phone = json["phone"];
    this.email = json["email"];
    this.avatarUrl = json["avatarUrl"];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["dateOfBirth"] = this.dateOfBirth;
    data["phone"] = this.phone;
    data["email"] = this.email;
    data["avatarUrl"] = this.avatarUrl;
    return data;
  }
}
