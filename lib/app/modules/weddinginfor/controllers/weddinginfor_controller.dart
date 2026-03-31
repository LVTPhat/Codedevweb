import 'dart:typed_data';

import 'package:codedevweb/app/common/comlibs.dart';
import 'package:codedevweb/app/common/firebase_firebase.dart';
import 'package:codedevweb/app/common/firebase_path_constant.dart';
import 'package:codedevweb/app/data/models/wedding_information_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeddinginforController extends GetxController {
  final listImageNames = ['image1', 'image1', 'image1', 'image1', 'image1'];
  DateTime specificDate = DateTime(2025, 5, 10, 14, 30);
  final listDayOfWeek = ["Hai", "Ba", "Tư", "Năm", "Sáu", "Bảy", "CN"];

  final String weddingInforId = "thieny";
  final String imageKey = "image";

  final isEdit = true;

  Rx<double> _dateScale = 0.5.obs;
  double get dateScale => _dateScale.value;
  set dateScale(double value) => _dateScale.value = value;

  Rx<double> _inviteScale = 0.5.obs;
  double get inviteScale => _inviteScale.value;
  set inviteScale(double value) => _inviteScale.value = value;

  Rx<double> _nameScale = 0.5.obs;
  double get nameScale => _nameScale.value;
  set nameScale(double value) => _nameScale.value = value;

  Rx<double> _locationScale = 0.5.obs;
  double get locationScale => _locationScale.value;
  set locationScale(double value) => _locationScale.value = value;

  Rx<bool> _isChooseImage = false.obs;
  bool get isChooseImage => _isChooseImage.value;
  set isChooseImage(bool value) => _isChooseImage.value = value;

  Rx<bool> _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  Rx<bool> _isChooseListSlider = false.obs;
  bool get isChooseListSlider => _isChooseListSlider.value;
  set isChooseListSlider(bool value) => _isChooseListSlider.value = value;

  WeddingInformationData weddingInfor = new WeddingInformationData();

  List<Uint8List> listImage = [
    new Uint8List(0),
    new Uint8List(0),
    new Uint8List(0),
    new Uint8List(0),
    new Uint8List(0),
    new Uint8List(0),
  ];

  List<Uint8List> listDowloadImage = [
    new Uint8List(0),
    new Uint8List(0),
    new Uint8List(0),
    new Uint8List(0),
    new Uint8List(0),
    new Uint8List(0),
  ];

  List<Uint8List?> listSliderImage = [];

  List<Uint8List?> listSliderImageDownload = [];

  List<RxBool> listChooseImage = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
  ];

  Future<void> onTapPickImage(int index) async {
    if (!isEdit) return;

    try {
      listImage[index] = await Comlibs.pickImage();
      listChooseImage[index].value = true;
    } catch (e) {
      print(e);
    }
  }

  Future<void> onTapPickImageMulti() async {
    if (!isEdit) return;

    try {
      listSliderImage = await Comlibs.pickMultiImage();
      isChooseListSlider = true;
      // print(listImage[index]);
    } catch (e) {
      print(e);
    }
  }

  String getInforPath() => FirebasePathConstant.getPath("WEDDING_INFOR", "");

  Future<void> getWeddingInfor() async {
    isLoading = true;
    final data = await FirebaseComlib.getData(getInforPath(), weddingInforId);

    weddingInfor = WeddingInformationData.fromJson(data);
    weddingInfor.printData();

    for (int i = 0; i < listDowloadImage.length; i++) {
      final key = imageKey + (i + 1).toString();
      if (data[key] != null) {
        listDowloadImage[i] = await FirebaseComlib.dowloadImage(data[key]);
      }
    }

    final imageSliderList = weddingInfor.listSliderImage ?? [];
    for (int i = 0; i < imageSliderList.length; i++) {
      listSliderImageDownload
          .add(await FirebaseComlib.dowloadImage(imageSliderList[i]));
    }

    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    isLoading = false;
  }

  Future<void> onSaveWeddingInfor() async {
    final data = weddingInfor.toJson();
    var isHaveData = isChooseListSlider;

    for (int i = 0; i < listChooseImage.length; i++) {
      if (listChooseImage[i].value) {
        final tempIdx = i + 1;
        try {
          // delete old image
          await FirebaseComlib.deleteImage(data["image" + tempIdx.toString()]);
        } catch (e) {}

        // update new image
        data[imageKey + tempIdx.toString()] =
            await FirebaseComlib.uploadImage("weddinginfor", listImage[i]);
        isHaveData = true;
      }
    }

    if (weddingInfor.listSliderImage != null) {
      weddingInfor.listSliderImage!.forEach((url) async {
        await FirebaseComlib.deleteImage(url);
      });
    }

    if (isChooseListSlider) {
      List<String> listUrl = [];

      for (int i = 0; i < listSliderImage.length; i++) {
        final image = listSliderImage[i];
        if (image != null) {
          final url = await FirebaseComlib.uploadImage("weddinginfor", image);
          listUrl.add(url);
        }
      }

      data["listSliderImage"] = listUrl;
    }

    if (isHaveData) {
      await FirebaseComlib.insertData(getInforPath(), weddingInforId,
          WeddingInformationData.fromJson(data));
      Get.snackbar("Success", "Update sucessfull > <");
    } else {
      Get.snackbar("Error!", "No data to update T T");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getWeddingInfor();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
