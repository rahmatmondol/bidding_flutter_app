import 'package:get/get.dart';

import '../controllers/provider_tab_controller.dart';

class ProviderTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderTabController>(
      () => ProviderTabController(),
    );
  }
}
