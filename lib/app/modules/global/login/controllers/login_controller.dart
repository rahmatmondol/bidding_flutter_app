// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:dirham_uae/app/components/custom_loading_dialog_widget.dart';
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController customerEmailController = TextEditingController();
  final TextEditingController customerPassController = TextEditingController();

  final Rx<TextEditingController> providerEmailController =
      Rx(TextEditingController());
  final Rx<TextEditingController> providerPassController =
      Rx(TextEditingController());
  var isLoading = false.obs;
  RxBool isProviderLoginLoading = false.obs;
  UserService userService = UserService();
  var token = "".obs;
  var providerToken = "".obs;

  @override
  void onInit() {
    super.onInit();
    // checkExistingAuth();
  }

  // Future<void> checkExistingAuth() async {
  //   var isUser = await userService.getBool();
  //   var isProviderUser = await userService.getBoolProvider();
  //
  //   if (isUser == true) {
  //     Get.offAllNamed(Routes.CUSTOMER_NAV_BAR);
  //   } else if (isProviderUser == true) {
  //     Get.offAllNamed(Routes.NAV_BAR);
  //   }
  //   // If neither true, stay on login screen
  // }

// ***************** Login Customer ********************
  Future CustomerLoginUser(BuildContext context) async {
    try {
      isLoading.value = true;
      print("Starting Customer Login Process");

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: const CustomLoadingWidget(
              message: "Checking",
            ),
          );
        },
      );

      await BaseClient.safeApiCall(
        data: {
          "email": customerEmailController.text.trim(),
          "password": customerPassController.text.trim(),
        },
        Constants.customerLoginUrl,
        RequestType.post,
        onSuccess: (response) async {
          if (response.statusCode == 200) {
            await userService.removeSharedPreferenceData();
            token.value = response.data["token"];

            // Save user data
            await userService.saveBoolean(key: 'is-user', value: true);
            await userService.saveString(
                key: 'token', value: response.data["token"]);

            // Dismiss loading dialog first
            if (context.mounted) {
              Navigator.pop(context);
            }

            // Show success message
            CustomSnackBar.showCustomToast(message: response.data['message']);

            // Navigate after everything is done
            await Get.offAllNamed(
              Routes.CUSTOMER_NAV_BAR,
              predicate: (route) => false, // Clear all previous routes
            );
          }
          isLoading.value = false;
          update();
        },
        onError: (error) {
          // Dismiss loading dialog
          if (context.mounted) {
            Navigator.pop(context);
          }

          if (error.response?.data["success"] == false) {
            CustomSnackBar.showCustomErrorToast(
                message: error.response?.data['errors'].toString() ??
                    "Login failed");
          }
          isLoading.value = false;
          update();
        },
      );
    } catch (e) {
      // Handle any unexpected errors
      if (context.mounted) {
        Navigator.pop(context);
      }
      CustomSnackBar.showCustomErrorToast(
          message: "An unexpected error occurred");
      isLoading.value = false;
      update();
    }
  }

  // ************ Provider Login *****************

  Future providerLoginUser(BuildContext context) async {
    try {
      isProviderLoginLoading.value = true;
      print("Email being sent: ${providerEmailController.value.text.trim()}");
      print("Password being sent: ${providerPassController.value.text.trim()}");

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: const CustomLoadingWidget(
              message: "Checking",
            ),
          );
        },
      );

      await BaseClient.safeApiCall(
        data: {
          "email": providerEmailController.value.text.trim(),
          "password": providerPassController.value.text.trim(),
        },
        Constants.providerLoginUpUrl,
        RequestType.post,
        onSuccess: (response) async {
          if (response.statusCode == 200) {
            await userService.removeSharedPreferenceData();
            providerToken.value = response.data["token"];
            // Save provider data
            await userService.saveBooleanProvider(
                key: 'is-user-provider', value: true);
            await userService.saveStringProvider(
                key: 'token-provider', value: response.data["token"]);
            await Future.delayed(Duration(milliseconds: 100));

            // Dismiss loading dialog first
            if (context.mounted) {
              Navigator.pop(context);
            }

            // Show success message
            CustomSnackBar.showCustomToast(message: response.data['message']);

            // Navigate after everything is done
            await Get.offAllNamed(
              Routes.NAV_BAR,
              predicate: (route) => false, // Clear all previous routes
            );
          }
          isProviderLoginLoading.value = false;
          update();
        },
        onError: (error) {
          // Dismiss loading dialog
          if (context.mounted) {
            Navigator.pop(context);
          }

          if (error.response?.data["success"] == false) {
            CustomSnackBar.showCustomErrorToast(
                message: error.response?.data['errors'].toString() ??
                    "Login failed");
          }
          isProviderLoginLoading.value = false;
          update();
        },
      );
    } catch (e) {
      // Handle any unexpected errors
      if (context.mounted) {
        Navigator.pop(context);
      }
      CustomSnackBar.showCustomErrorToast(
          message: "An unexpected error occurred");
      isProviderLoginLoading.value = false;
      update();
    }
  }

  List<Widget> tabs = [
    Text("Customer"),
    Text("Provider"),
  ];
  final count = 0.obs;
}
