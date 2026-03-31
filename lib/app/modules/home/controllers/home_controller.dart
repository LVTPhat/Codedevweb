import 'package:codedevweb/app/modules/user_information/views/user_information_view.dart';
import 'package:get/get.dart';
import 'package:codedevweb/app/modules/chat_room/views/chat_room_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

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

  void moveToUserRoom() {
    Get.to(UserInformationView());
  }

  void moveToChatRoom() {
    Get.to(ChatRoomView());
  }
}
