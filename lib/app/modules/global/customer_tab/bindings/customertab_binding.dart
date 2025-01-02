import 'package:get/get.dart';

import '../controllers/customertab_controller.dart';

class CustomertabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomertabController>(
      () => CustomertabController(),
    );
  }
}
