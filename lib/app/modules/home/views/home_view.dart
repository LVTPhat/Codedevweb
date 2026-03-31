import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Home View'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Text('Count'),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: controller.moveToChatRoom,
              child: Icon(Icons.chat),
            ),
          ),
          Positioned(
            bottom: 90,
            right: 20,
            child: FloatingActionButton(
              onPressed: controller.moveToUserRoom,
              child: Icon(Icons.account_box),
            ),
          ),
        ],
      ),
    );
  }
}
