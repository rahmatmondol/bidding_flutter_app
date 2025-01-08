import 'package:get/get.dart';

import '../../../../components/custom_snackbar.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../data/local/token_manager.dart';
import '../../../../data/user_service/user_service.dart';
import '../../../../routes/app_pages.dart';
import '../../customer_account_details/controllers/customer_account_details_controller.dart';

class CustomerProfileController extends GetxController {
  RxBool isLogoutLoading = false.obs;
  UserService userService = UserService();

  Future<void> refreshProfileData() async {
    try {
      // Find and use CustomerAccountDetailsController to refresh data
      final accountController = Get.find<CustomerAccountDetailsController>();
      await accountController.getCustomerInfo();
      update(); // Update UI
    } catch (e) {
      print('Error refreshing profile data: $e');
      Get.snackbar('Failed', 'Profile Update Failed');
    }
  }

  Future<void> customerLogout() async {
    try {
      isLogoutLoading.value = true;

      // Clear all SharedPreferences data
      await userService.removeSharedPreferenceData();
      // Clear token data from MySharedPref
      await MySharedPref.clear();

      // Reset token timestamps in TokenRefreshService
      await TokenRefreshService().resetTokenTimestamp(isProvider: false);
      await TokenRefreshService().resetTokenTimestamp(isProvider: true);
      // Show success message
      CustomSnackBar.showCustomToast(
        message: "Logged out successfully",
      );

      // Navigate to login screen
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print('Logout error: ${e.toString()}');
      CustomSnackBar.showCustomErrorToast(
        message: "An error occurred during logout",
      );
    } finally {
      isLogoutLoading.value = false;
      update();
    }
  }
}
