import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/web_sale_controller.dart';

class WebSaleView extends GetView<WebSaleController> {
  const WebSaleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSaleView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WebSaleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
