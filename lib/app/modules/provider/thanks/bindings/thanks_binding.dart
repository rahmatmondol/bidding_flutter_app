import 'package:get/get.dart';

import '../controllers/thanks_controller.dart';

class ThanksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThanksController>(
      () => ThanksController(),
    );
  }
}
