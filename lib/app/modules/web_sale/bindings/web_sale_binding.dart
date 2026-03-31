import 'package:get/get.dart';

import '../controllers/web_sale_controller.dart';

class WebSaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebSaleController>(
      () => WebSaleController(),
    );
  }
}
