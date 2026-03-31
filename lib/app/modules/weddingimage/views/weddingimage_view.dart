import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/weddingimage_controller.dart';

class WeddingimageView extends GetView<WeddingimageController> {
  const WeddingimageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeddingimageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WeddingimageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
