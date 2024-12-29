import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/constants.dart';


class CustomerChangePasswordController extends GetxController {
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  RxBool ischangePassLoading = false.obs;
  UserService userService = UserService();

  // *****************Customer login Called api Function *********************
  Future changedPassword(context) async {
    ischangePassLoading.value = true;

    try {
      await BaseClient.safeApiCall(
        data: {
          "old-password": oldPassController.text.trim(),
          "password": newPassController.text.trim(),
        },
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getToken("token".obs).toString()}',
        },
        Constants.customerChnagePasswordUrl,
        RequestType.post,

        onSuccess: (response) {
          print("success");
          if (response.statusCode == 202) {
            CustomSnackBar.showCustomToast(
              message: response.data["message"].toString(),
            );

            Navigator.pop(context);
            // Get.back(); // When change pass done then back to previous page
          }
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
