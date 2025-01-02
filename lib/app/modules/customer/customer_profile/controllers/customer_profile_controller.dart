import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:get/get.dart';

class CustomerProfileController extends GetxController {
  RxBool isLogoutLoading = false.obs;
  UserService userService = UserService();

  // *****************Customer login Called api Function *********************
  Future<void> customerLogout() async {
    isLogoutLoading.value = true;

    try {
      await BaseClient.safeApiCall(
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getToken("token".obs).toString()}',
        },
        Constants.customerlogOutUrl,
        RequestType.post,
        onSuccess: (response) {
          print("success");
          if (response.statusCode == 200) {
            print(response.data);
            userService.saveBoolean(key: 'is-user', value: false);
            CustomSnackBar.showCustomToast(
              message: response.data["message"].toString(),
            );
            Get.offAllNamed(Routes.LOGIN);
          }
          isLogoutLoading.value = false;
          update();
        },
        onError: (error) {
          if (error.response!.data["success"] == false) {
            CustomSnackBar.showCustomErrorToast(
              message: error.response!.data['message'].toString(),
            );
          }
          update();
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  final count = 0.obs;

  @override
  void onInit() {
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
