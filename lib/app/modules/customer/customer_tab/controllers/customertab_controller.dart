import 'dart:ui';

import 'package:dirham_uae/app/modules/customer/customer_tab/model/category-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_loading_dialog_widget.dart';
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/utils/constants.dart';
import '../../../../services/base_client.dart';

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

  // *************SignUpCustomer APi******************

  Future signUpCustomer(BuildContext context) async {
    showDialog(
      context: context,
      builder: (c) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: const CustomLoadingWidget(
            message: "Cheaking",
          ),
        );
      },
    );

    isLoading.value = true;

    await BaseClient.safeApiCall(
      // headers: {
      //   "Authorization":
      //       "Bearer ${MySharedPref.getToken("token".obs).toString()}",
      // },
      data: {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passController.text.trim(),
        'country': country,
        'mobile': phoneController.text.trim(),
        'category_id': categooryId,
        'account_type': 'customer'
      },
      Constants.customerSignUpUrl,
      RequestType.post,

      onSuccess: (response) {
        // if (response.data['success'] = false) {}
        print("success");
        if (response.statusCode == 201) {
          print(response.data);

          userService.saveBoolean(key: 'is-user', value: true);
          // userService.saveString(
          //     key: 'token', value: response.data['verify_token']);
          CustomSnackBar.showCustomToast(
              message: response.data['message'],
              color: LightThemeColors.progressIndicatorColor);
          Get.toNamed(Routes.CUSTOMER_LOCATION);
        }

        isLoading.value = false;
        update();
      },
      onError: (error) {
        if (error.statusCode == 422) {
          String errorMessage = "";

          if (error.response!.data['errors']['phone'] != null) {
            errorMessage += error.response!.data['errors']['phone'][0] + "\n";
          }

          if (error.response!.data['errors']['email'] != null) {
            errorMessage += error.response!.data['errors']['email'][0] + "\n";
          }

          CustomSnackBar.showCustomErrorToast(message: errorMessage);
          Navigator.pop(context);
        }
        isLoading.value = false;
        update();
      },
    );
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
