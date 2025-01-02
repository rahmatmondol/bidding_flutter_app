import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/local/my_shared_pref.dart';

class ChangePasswordController extends GetxController {
  final Rx<TextEditingController> oldPassController =
      Rx(TextEditingController());
  final Rx<TextEditingController> newPassController =
      Rx(TextEditingController());
  final Rx<TextEditingController> confirmPassController =
      Rx(TextEditingController());

  RxBool ischangePassLoading = false.obs;
  UserService userService = UserService();

  // *****************provider change pass api Function *********************
  Future changedPasswordProvider(context) async {
    ischangePassLoading.value = true;

    try {
      await BaseClient.safeApiCall(
        data: {
          "old-password": oldPassController.value.text.trim(),
          "password": newPassController.value.text.trim(),
        },
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
        },
        Constants.providerChnagePasswordUrl,
        RequestType.post,
        onSuccess: (response) {
          print("success");
          // if (response!.statusCode == 200) {
          //   CustomSnackBar.showCustomToast(
          //     message: response.data["message"].toString(),
          //   );

          //   Navigator.pop(context);
          //   // Get.back(); // When change pass done then back to previous page
          // }
          ischangePassLoading.value = false;
          update();
          print("all Done change pass");
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
