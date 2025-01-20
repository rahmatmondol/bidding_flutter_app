import 'dart:ui';

import 'package:dirham_uae/app/components/custom_loading_dialog_widget.dart';
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../services/base_client.dart';
import '../model/category-model.dart';

class CustomertabController extends GetxController {
  RxList<String> county = [
    "Bangladesh",
    "Egypt",
  ].obs;

  final RxString selectedZoon = RxString("Egypt");

  void updateSelectedValue(String newValue) {
    selectedZoon.value = newValue;
  }

  var isLoading = false.obs;
  UserService userService = UserService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController country = TextEditingController();
  int? categooryId;

  Future signUpCustomer(BuildContext context) async {
    try {
      isLoading.value = true;

      // Show loading dialog
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
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'password': passController.text.trim(),
          'country': country.text.trim(),
          'mobile': phoneController.text.trim(),
          'category_id': categooryId,
          'account_type': 'customer'
        },
        Constants.customerSignUpUrl,
        RequestType.post,
        onSuccess: (response) async {
          print('This is response: $response');
          if (response.statusCode == 200 && response.data['success'] == true) {
            try {
              // Save necessary data
              await userService.saveBoolean(key: 'is-user', value: true);

              // Optional: Save user ID or other data you might need
              await userService.saveString(
                  key: 'user-id',
                  value: response.data['data']['id'].toString());

              // Dismiss loading dialog
              Navigator.pop(context);

              // Show success message
              CustomSnackBar.showCustomToast(
                  message: response.data['message'],
                  color: LightThemeColors.progressIndicatorColor);

              // Navigate to next screen
              Get.offAllNamed(Routes.CUSTOMER_LOCATION);
            } catch (e) {
              Navigator.pop(context);
              CustomSnackBar.showCustomErrorToast(
                  message: "Error saving user data");
            }
          } else {
            Navigator.pop(context);
            CustomSnackBar.showCustomErrorToast(
                message: "Signup failed: ${response.data['message']}");
          }
        },
        onError: (error) {
          // Always dismiss loading dialog first
          Navigator.pop(context);

          if (error.statusCode == 422) {
            String errorMessage = "";

            if (error.response?.data['errors']['phone'] != null) {
              errorMessage += error.response!.data['errors']['phone'][0] + "\n";
            }

            if (error.response?.data['errors']['email'] != null) {
              errorMessage += error.response!.data['errors']['email'][0] + "\n";
            }

            CustomSnackBar.showCustomErrorToast(message: errorMessage);
          } else {
            // Handle other error cases
            CustomSnackBar.showCustomErrorToast(
                message:
                    error.response?.data['message'] ?? "An error occurred");
          }

          isLoading.value = false;
          update();
        },
      );
    } catch (e) {
      // Handle any unexpected errors
      if (context.mounted) {
        Navigator.pop(context); // Dismiss loading dialog
      }
      CustomSnackBar.showCustomErrorToast(
          message: "An unexpected error occurred");
      isLoading.value = false;
      update();
    }
  }

  RxBool isCategoryLoading = false.obs;
  RxObjectMixin<CCatgoryModel> categoryModel = CCatgoryModel().obs;
  RxString categoryyIds = "".obs;

  Future getCategoory() async {
    isCategoryLoading.value = true;

    await BaseClient.safeApiCall(
      Constants.getZoneId,
      RequestType.get,
      onSuccess: (response) {
        if (response.statusCode == 200) {
          print("get Zone status code 200");
          categoryModel.value = CCatgoryModel.fromJson(response.data);

          print(categoryModel.value.data);
        }
        isCategoryLoading.value = false;
        update();
      },
      onError: (error) {
        print(error.toString());
        CustomSnackBar.showCustomErrorToast(
          message: error.response!.data['message'].toString(),
        );
      },
    );
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getCategoory();
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
