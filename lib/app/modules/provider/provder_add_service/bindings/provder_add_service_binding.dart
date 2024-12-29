import 'package:get/get.dart';

import '../controllers/provder_add_service_controller.dart';

class ProvderAddServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProvderAddServiceController>(
      () => ProvderAddServiceController(),
    );
  }
}
