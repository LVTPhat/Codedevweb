import 'package:codedevweb/app/data/data.dart';

class WeddingInformationData extends Data {
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? image6;
  List<String>? listSliderImage;

  WeddingInformationData(
      {this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.image6,
      this.listSliderImage})
      : super.fromJson({});
  WeddingInformationData.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    this.image1 = json["image1"];
    this.image2 = json["image2"];
    this.image3 = json["image3"];
    this.image4 = json["image4"];
    this.image5 = json["image5"];
    this.image6 = json["image6"];
    this.listSliderImage = new List<String>.from(json["listSliderImage"]);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["image1"] = this.image1;
    data["image2"] = this.image2;
    data["image3"] = this.image3;
    data["image4"] = this.image4;
    data["image5"] = this.image5;
    data["image6"] = this.image6;
    data["listSliderImage"] = this.listSliderImage;
    return data;
  }
}
