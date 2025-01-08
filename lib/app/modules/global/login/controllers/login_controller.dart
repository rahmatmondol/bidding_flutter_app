// ignore_for_file: non_constant_identifier_names

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
  var isProviderLoginLoading = false.obs;
  UserService userService = UserService();
  var token = "".obs;
  var providerToken = "".obs;

  @override
  void onInit() {
    super.onInit();
    checkExistingAuth();
  }

  Future<void> checkExistingAuth() async {
    var isUser = await userService.getBool();
    var isProviderUser = await userService.getBoolProvider();

    if (isUser == true) {
      Get.offAllNamed(Routes.CUSTOMER_NAV_BAR);
    } else if (isProviderUser == true) {
      Get.offAllNamed(Routes.NAV_BAR);
    } else {
      return;
    }
    // If neither true, stay on login screen
  }

// ***************** Login Customer ********************

  Future<void> CustomerLoginUser(BuildContext context) async {
    try {
      isLoading.value = true;
      print("Starting Customer Login Process");

      final result = await BaseClient.safeApiCall(
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

            await userService.saveBoolean(key: 'is-user', value: true);
            await userService.saveString(
                key: 'token', value: response.data["token"]);

            CustomSnackBar.showCustomToast(message: response.data['message']);

            await Get.offAllNamed(
              Routes.CUSTOMER_NAV_BAR,
              predicate: (route) => false,
            );
          } else {
            Get.snackbar('Unauthorized', 'Check Email or Password');
          }
        },
        onError: (error) {
          print("Error occurred during login: ${error.toString()}");
          if (error.response?.statusCode == 401) {
            Get.snackbar('Unauthorized', 'Check Email or Password');
          } else if (error.response?.data?["success"] == false) {
            CustomSnackBar.showCustomErrorToast(
                message: error.response?.data['errors']?.toString() ??
                    "Login failed");
          } else {
            CustomSnackBar.showCustomErrorToast(
                message: "Login failed. Please try again.");
          }
        },
      );
    } catch (e) {
      print("Unexpected error during login: $e");
      CustomSnackBar.showCustomErrorToast(
          message: "An unexpected error occurred");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // ************ Provider Login *****************

  Future<void> providerLoginUser(BuildContext context) async {
    try {
      isProviderLoginLoading.value = true;
      print("Starting Provider Login Process");

      final result = await BaseClient.safeApiCall(
        data: {
          "email": providerEmailController.value.text.trim(),
          "password": providerPassController.value.text,
        },
        Constants.providerLoginUpUrl,
        RequestType.post,
        onSuccess: (response) async {
          if (response.statusCode == 200) {
            await userService.removeSharedPreferenceData();
            providerToken.value = response.data["token"];

            await userService.saveBooleanProvider(
                key: 'is-user-provider', value: true);
            await userService.saveStringProvider(
                key: 'token-provider', value: response.data["token"]);

            CustomSnackBar.showCustomToast(message: response.data['message']);

            await Get.offAllNamed(
              Routes.NAV_BAR,
              predicate: (route) => false,
            );
          } else {
            Get.snackbar('Unauthorized', 'Check Email or Password');
          }
        },
        onError: (error) {
          print("Error occurred during provider login: ${error.toString()}");
          if (error.response?.statusCode == 401) {
            Get.snackbar('Unauthorized', 'Check Email or Password');
          } else if (error.response?.data?["success"] == false) {
            CustomSnackBar.showCustomErrorToast(
                message: error.response?.data['errors']?.toString() ??
                    "Login failed");
          } else {
            CustomSnackBar.showCustomErrorToast(
                message: "Login failed. Please try again.");
          }
        },
      );
    } catch (e) {
      print("Unexpected error during provider login: $e");
      CustomSnackBar.showCustomErrorToast(
          message: "An unexpected error occurred");
    } finally {
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
