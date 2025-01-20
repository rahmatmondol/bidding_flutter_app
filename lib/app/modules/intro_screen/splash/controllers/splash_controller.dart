import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:get/get.dart';

// class SplashController extends GetxController {
//   final count = 0.obs;
//   UserService userService = UserService();
//
//   @override
//   void onInit() {
//     Future.delayed(
//       const Duration(seconds: 3),
//       () => authCheck(),
//     );
//     super.onInit();
//     update();
//   }
//
//   Future<void> authCheck() async {
//     if (Get.currentRoute == Routes.NAV_BAR ||
//         Get.currentRoute == Routes.CUSTOMER_NAV_BAR) {
//       return;
//     }
//     var isUser = await userService.getBool();
//     var isProviderUser = await userService.getBoolProvider();
//     print("Auth Check - isUser: $isUser, isProviderUser: $isProviderUser");
//
//     if (isUser == true) {
//       Get.offAllNamed(Routes.CUSTOMER_NAV_BAR);
//     } else if (isProviderUser == true) {
//       Get.offAllNamed(Routes.NAV_BAR);
//     } else {
//       Get.offAllNamed(Routes.INTRO_ONE);
//     }
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//   void increment() => count.value++;
// }

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(
      const Duration(seconds: 2),
      () => Get.offAllNamed(Routes.INTRO_ONE),
    );
  }
}
