import 'package:codedevweb/app/common/firebase_firebase.dart';
import 'package:codedevweb/app/common/firebase_path_constant.dart';
import 'package:codedevweb/app/data/models/wedding_information_data.dart';
import 'package:codedevweb/app/modules/chat_room/views/chat_room_view.dart';
import 'package:codedevweb/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:codedevweb/app/modules/home/views/home_view.dart';
import 'package:codedevweb/app/modules/user_information/views/user_information_view.dart';
import 'package:codedevweb/app/modules/weddinginfor/views/weddinginfor_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

FirebaseAuth auth = FirebaseAuth.instance;

class AdminLoginController extends GetxController {
  //TODO: Implement AdminLoginController
  final count = 0.obs;

  Rx<String> _userEmail = "".obs;
  String get userEmail => _userEmail.value;
  set userEmail(value) => _userEmail.value = value;

  Rx<String> _userPassword = "".obs;
  String get userPassword => _userPassword.value;
  set userPassword(value) => _userPassword.value = value;

  Rx<bool> _showPass = false.obs;
  bool get showPass => _showPass.value;
  set showPass(value) => _showPass.value = value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> adminLogin(GlobalKey<FormState> _formKey) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);
      var currentUser = FirebaseAuth.instance.currentUser;
      var isHaveInfor = await getUserInfor(currentUser!.uid);
      // if (!isHaveInfor) {
      //   Get.to(UserInformationView());
      // } else {
      //   Get.to(HomeView());
      // }
      Get.to(WeddinginforView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error!", '$e');
    }
  }

  Future<bool> getUserInfor(String uid) async {
    var userInfor = await FirebaseComlib.getData(
        FirebasePathConstant.getPath("USER_INFOR", ""), uid);
    if (userInfor.keys.isEmpty) return false;
    return true;
  }

  void onSaveEmail(value) {
    userEmail = value;
  }

  void onSavePassWord(value) {
    userPassword = value;
  }

  void onTapShowPass() {
    showPass = !showPass;
  }

  void moveToForgorPass() {
    Get.to(ForgotPasswordView());
  }

  String? validateEmail(value) {
    if (value == "" || value == null) {
      return "Please enter email!";
    }
    if (!GetUtils.isEmail(value)) {
      return "Please enter correctly email!";
    }
    return null;
  }

  void moveToChatRoom() {
    Get.to(ChatRoomView());
  }
}
