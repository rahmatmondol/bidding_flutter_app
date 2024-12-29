// ignore_for_file: non_constant_identifier_names

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_loading_dialog_widget.dart';
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:dirham_uae/app/modules/customer/customer_nav_bar/views/customer_nav_bar_view.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/constants.dart';

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
  // *************Customer Login Api*******************
  Future CustomerLoginUser(BuildContext context) async {
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
      data: {
        "email": customerEmailController.text.trim(),
        "password": customerPassController.text.trim(),
      },
      Constants.customerLoginUrl,
      RequestType.post,

      onSuccess: (response) {
        // if (response.data['success'] = false) {}
        print("success");
        if (response.statusCode == 200) {
          print(response.data);

          token.value = response.data["token"];
          print("tokenn----- $token");
          userService.saveBoolean(key: 'is-user', value: true);
          userService.saveString(key: 'token', value: response.data["token"]);
          CustomSnackBar.showCustomToast(message: response.data['message']);
          Get.off(CustomerNavBarView(1));
        }
        isLoading.value = false;
        update();
      },
      onError: (error) {
        Navigator.pop(context);
        if (error.response!.data["success"] == false) {
          CustomSnackBar.showCustomErrorToast(
              message: error.response!.data['errors'].toString());
        }
        update();
      },
    );
  }

  // *************Customer Login Api*******************
  Future providerLoginUser(BuildContext context) async {
    isProviderLoginLoading.value = true;
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

    await BaseClient.safeApiCall(
      data: {
        "login_field": providerEmailController.value.text.trim(),
        "password": providerPassController.value.text.trim(),
      },
      Constants.providerLoginUpUrl,
      RequestType.post,

      onSuccess: (response) {
        // if (response.data['success'] = false) {}
        print("success");
        if (response.statusCode == 200) {
          print(response.data);

          providerToken.value = response.data["token"];
          print("tokenn----- $providerToken");
          userService.saveBooleanProvider(key: 'is-user-provider', value: true);
          userService.saveStringProvider(
              key: 'token-provider', value: response.data["token"]);
          CustomSnackBar.showCustomToast(message: response.data['message']);
          Get.toNamed(Routes.NAV_BAR);
        }
        isProviderLoginLoading.value = false;
        update();
      },
      onError: (error) {
        Navigator.pop(context);
        if (error.response!.data["success"] == false) {
          CustomSnackBar.showCustomErrorToast(
              message: error.response!.data['errors'].toString());
        }
        update();
      },
    );
  }

  List<Widget> tabs = [
    Text("Customer"),
    Text("Provider"),
  ];
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
