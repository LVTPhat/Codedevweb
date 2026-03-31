import 'package:get/get.dart';

import '../controllers/weddinginfor_controller.dart';

class WeddinginforBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeddinginforController>(
      () => WeddinginforController(),
    );
  }
}
