import 'package:get/get.dart';

import '../../../customer/customer_home/controllers/customer_home_controller.dart';
import '../controllers/nav_bar_controller.dart';

class NavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavBarController>(
      () => NavBarController(),
    );
    Get.put(CustomerHomeController());
  }
}
