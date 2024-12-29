import 'package:get/get.dart';
import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:dirham_uae/app/modules/customer/customer_nav_bar/views/customer_nav_bar_view.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  UserService userService = UserService();

  Future<void> authCheck() async {
    var isUser = await userService.getBool();
    var isProviderUser = await userService.getBoolProvider();
    if (isUser == true) {
      Get.offAll(CustomerNavBarView(1));
    } else if (isProviderUser == true) {
      Get.offAllNamed(Routes.NAV_BAR);
    } else {
      Get.offAllNamed(Routes.INTRO_ONE);
    }
  }

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () => authCheck(),
    );
    update();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
