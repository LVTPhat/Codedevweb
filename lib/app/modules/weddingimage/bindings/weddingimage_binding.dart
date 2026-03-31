import 'package:get/get.dart';

import '../controllers/weddingimage_controller.dart';

class WeddingimageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeddingimageController>(
      () => WeddingimageController(),
    );
  }
}
