import 'package:codedevweb/app/common/firebase_firebase.dart';
import 'package:codedevweb/app/common/firebase_path_constant.dart';
import 'package:codedevweb/app/data/models/mess_data.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRoomController extends GetxController {
  //TODO: Implement ChatRoomController

  final currentUser = FirebaseAuth.instance.currentUser;
  final chatroomKey = "thien_phat_chatbox";

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

  Rx<String> _mess = "".obs;
  String get mess => _mess.value;
  set mess(value) => _mess.value = value;

  void sendMess(_formKey) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    var messData = MessData(content: mess);
    var colectionPath =
        FirebasePathConstant.getPath("MESS_LIST_PATH", chatroomKey);
    FirebaseComlib.insertData<MessData>(colectionPath, getMessId(), messData);

    mess = "";
  }

  String getMessId() {
    var email = currentUser!.email;
    return (email ?? "") + getCurDateTime();
  }

  String getCurDateTime() {
    var timestamp = Timestamp.now();
    var date = new DateTime.fromMicrosecondsSinceEpoch(
        timestamp.microsecondsSinceEpoch);
    var strDate = date.toString();
    strDate = strDate
        .replaceAll("-", "")
        .replaceAll(" ", "")
        .replaceAll(":", "")
        .replaceAll(".", "");
    return strDate;
  }

  void onSaveMess(value) {
    mess = value;
  }

  List<MessData> formatMess(List<MessData> listMess) {
    var email = currentUser!.email;
    listMess.forEach((e) => e.isYourMess = e.docId!.contains(email ?? ""));
    return listMess;
  }

  String? validateMess(value) {
    if (value == "" || value == null) {
      return "";
    }
    return null;
  }
}
