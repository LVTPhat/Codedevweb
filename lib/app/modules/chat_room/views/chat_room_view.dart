import 'package:codedevweb/app/common/custom_stream_builder.dart';
import 'package:codedevweb/app/data/helper/custom_scroll_behavior.dart';
import 'package:codedevweb/app/data/models/mess_data.dart';
import 'package:codedevweb/app/modules/chat_room/views/components/chatroom_constants.dart';
import 'package:codedevweb/app/modules/chat_room/views/components/messenger_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final controller = Get.put(ChatRoomController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room View'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ChatroomConstants.messViewBGCL,
        selectedItemColor: ChatroomConstants.messViewSelection,
        unselectedItemColor: ChatroomConstants.messViewUnselection,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: 'Groups',
          ),
        ],
      ),
      backgroundColor: ChatroomConstants.messViewBGCL,
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
                height: 500,
                child: ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: CustomStreamBuilder<MessData, MessengerCard>(
                      buildElement: (data) => MessengerCard(messData: data),
                      streamParams: CustomStreamParams(
                          colectionPath:
                              "chat_room/thien_phat_chatbox/mess_list",
                          converter: MessData.fromJson,
                          formatData: controller.formatMess),
                    ))),
            Obx(
              () => TextFormField(
                controller: TextEditingController(text: controller.mess),
                onSaved: controller.onSaveMess,
                validator: controller.validateMess,
                decoration: InputDecoration(
                  hintText: "Fantastic!",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  fillColor: ChatroomConstants.messCardCLIP,
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () => controller.sendMess(_formKey),
                    child: Icon(Icons.send),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
