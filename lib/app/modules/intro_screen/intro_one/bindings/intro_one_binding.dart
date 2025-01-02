import 'package:get/get.dart';

import '../controllers/intro_one_controller.dart';

class IntroOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroOneController>(
      () => IntroOneController(),
    );
  }
}
