import 'dart:convert';

import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/light_theme_colors.dart';

class CustomerChangePasswordController extends GetxController {
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  RxBool ischangePassLoading = false.obs;
  UserService userService = UserService();

  // Future changedPassword(context) async {
  //   try {
  //     print('\n╔══════ Change Password Debug ══════╗');
  //
  //     ischangePassLoading.value = true; // Set loading state
  //
  //     final requestData = {
  //       "current_password": oldPassController.text.trim(),
  //       "password": newPassController.text.trim(),
  //       "password_confirmation": confirmPassController.text.trim(),
  //     };
  //
  //     print('║ Request Data: ${json.encode(requestData)}');
  //
  //     await BaseClient.safeApiCall(
  //       data: requestData,
  //       headers: {
  //         'Authorization':
  //             'Bearer ${MySharedPref.getToken("token".obs).toString()}',
  //       },
  //       Constants.customerChnagePasswordUrl,
  //       RequestType.post,
  //       onSuccess: (response) {
  //         print('║ Response Success: ${response.statusCode}');
  //
  //         if (response.statusCode == 200 && response.data["success"] == true) {
  //           // Show success message
  //           CustomSnackBar.showCustomToast(
  //             message: "Password Changed Successfully",
  //             color: LightThemeColors.primaryColor,
  //           );
  //
  //           // Navigate to profile page
  //           Get.offNamed(
  //               Routes.PROFILE); // Replace with your profile route name
  //         } else {
  //           CustomSnackBar.showCustomErrorToast(
  //             message: response.data["message"] ?? "Failed to change password",
  //             color: LightThemeColors.redColor,
  //           );
  //         }
  //
  //         ischangePassLoading.value = false;
  //         update();
  //       },
  //       onError: (error) {
  //         print('║ Response Error: ${error.response?.data}');
  //
  //         CustomSnackBar.showCustomErrorToast(
  //           message:
  //               error.response?.data['message'] ?? "Failed to change password",
  //           color: LightThemeColors.redColor,
  //         );
  //
  //         ischangePassLoading.value = false;
  //         update();
  //       },
  //     );
  //
  //     print('╚═══════════════════════════════════╝\n');
  //   } catch (e) {
  //     print('║ Exception: $e');
  //
  //     CustomSnackBar.showCustomErrorToast(
  //       message: "An error occurred while changing password",
  //       color: LightThemeColors.redColor,
  //     );
  //
  //     ischangePassLoading.value = false;
  //   }
  // }
  Future changedPassword(context) async {
    try {
      print('\n╔══════ Change Password Debug ══════╗');

      ischangePassLoading.value = true;
      String? token = '';
      if (await userService.isUser()) {
        token = await userService.getToken();
      } else if (await userService.isProvider()) {
        token = await userService.getTokenProvider();
      }

      final requestData = {
        "current_password": oldPassController.text.trim(),
        "password": newPassController.text.trim(),
        "password_confirmation": confirmPassController.text.trim(),
      };

      print('║ Request Data: ${json.encode(requestData)}');

      await BaseClient.safeApiCall(
        data: requestData,
        headers: {
          'Authorization': 'Bearer $token',
        },
        Constants.customerChnagePasswordUrl,
        RequestType.post,
        onSuccess: (response) {
          print('║ Response Success: ${response.statusCode}');

          if (response.statusCode == 200 && response.data["success"] == true) {
            // Show success message
            CustomSnackBar.showCustomToast(
              message: "Password Changed Successfully",
              color: LightThemeColors.primaryColor,
            );

            // Navigate to profile page
            Get.offNamed(Routes.PROFILE);
          } else {
            CustomSnackBar.showCustomErrorToast(
              message: response.data["message"] ?? "Failed to change password",
              color: LightThemeColors.redColor,
            );
          }

          ischangePassLoading.value = false;
          update();
        },
        onError: (error) {
          print('║ Response Error: ${error.response?.data}');

          CustomSnackBar.showCustomErrorToast(
            message:
                error.response?.data['message'] ?? "Failed to change password",
            color: LightThemeColors.redColor,
          );

          ischangePassLoading.value = false;
          update();
        },
      );

      print('╚═══════════════════════════════════╝\n');
    } catch (e) {
      print('║ Exception: $e');

      CustomSnackBar.showCustomErrorToast(
        message: "An error occurred while changing password",
        color: LightThemeColors.redColor,
      );

      ischangePassLoading.value = false;
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
