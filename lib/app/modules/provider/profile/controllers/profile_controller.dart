import 'package:get/get.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/utils/constants.dart';

import '../../../../components/custom_snackbar.dart';
import '../../../../data/user_service/user_service.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/base_client.dart';

class ProfileController extends GetxController {
  final count = 0.obs;
  RxBool isLogoutLoading = false.obs;
  UserService userService = UserService();

  // *****************Customer logOut Called api Function *********************
  Future<void> providerLogout() async {
    isLogoutLoading.value = true;

    try {
      await BaseClient.safeApiCall(
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
        },
        Constants.providerLogOutUpUrl,
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
