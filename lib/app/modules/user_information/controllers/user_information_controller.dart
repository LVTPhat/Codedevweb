import 'dart:typed_data';
import 'package:codedevweb/app/common/comlibs.dart';
import 'package:codedevweb/app/common/firebase_firebase.dart';
import 'package:codedevweb/app/common/firebase_path_constant.dart';
import 'package:codedevweb/app/data/models/user_information_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:codedevweb/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../views/user_information_view.dart';
import 'dart:developer';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class UserInformationController extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser;
  //TODO: Implement UserInformationController

  Uint8List userAvatar = new Uint8List(0);

  Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  Rx<bool> _isChooseImage = false.obs;
  bool get isChooseImage => _isChooseImage.value;
  set isChooseImage(bool value) => _isChooseImage.value = value;

  UserInformationData userInfor = new UserInformationData();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getUserInfor();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onTapPickImage() async {
    userAvatar = await Comlibs.pickImage();
    isChooseImage = true;
  }

  void onFormChange(String key, value) {
    var data = userInfor.toJson();
    data[key] = value;
    userInfor = UserInformationData.fromJson(data);
  }

  String getInforPath() => FirebasePathConstant.getPath("USER_INFOR", "");

  Future<void> onSaveInfor(GlobalKey<FormState> _formKey) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    userInfor.avatarUrl =
        await FirebaseComlib.uploadImage("userinfor", userAvatar);
    FirebaseComlib.insertData(getInforPath(), currentUser!.uid, userInfor);
  }

  Future<void> getUserInfor() async {
    isLoading = true;
    var data = await FirebaseComlib.getData(getInforPath(), currentUser!.uid);
    userInfor = UserInformationData.fromJson(data);
    userInfor.printData();
    isLoading = false;
  }
}
