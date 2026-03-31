import 'package:codedevweb/app/data/models/mess_data.dart';
import 'package:codedevweb/app/modules/chat_room/views/components/chatroom_constants.dart';
import 'package:flutter/material.dart';

class MessengerCard extends StatelessWidget {
  MessengerCard({
    Key? key,
    required this.messData,
  }) : super(key: key);

  final MessData messData;

  @override
  Widget build(BuildContext context) {
    if (this.messData.isYourMess ?? false) return buildMyMess();
    return buildYourMess();
  }

  Widget buildYourMess() {
    var MessData(
      :content,
    ) = messData;
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(right: 20),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 238, 2, 2),
              // image: DecorationImage(
              //     fit: BoxFit.cover,
              //     image: AssetImage('assets/images/avatar.jpg')),
              //Hàm chưa chạy được
            )),
        Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Phat"), Text(" 13:00")],
              ),
            ),
            Container(
              padding: ChatroomConstants.messCardPd,
              margin: ChatroomConstants.messCardMg,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                content ?? "",
                style: ChatroomConstants.messCardTS,
              ),
            ),
          ],
        )
      ],
    ));
  }

  Widget buildMyMess() {
    var MessData(:content) = messData;
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: ChatroomConstants.messCardPd,
        margin: ChatroomConstants.messCardMg,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 116, 236, 142),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          content ?? "",
          style: ChatroomConstants.messCardTS,
        ),
      ),
    );
  }
}
