import 'dart:ui';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/modules/provider/provider_tab/models/get_zone_id_models.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../components/custom_loading_dialog_widget.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../data/user_service/user_service.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/base_client.dart';

class ProviderTabController extends GetxController {
  RxString zoneIds = "".obs;

  CountryCode? selectedCountry;
  final RxString selectedZoon = RxString("Egypt");

  void updateSelectedValue(String newValue) {
    selectedZoon.value = newValue;
  }

  RxBool isLoading = false.obs;
  RxBool isZoneIdLoading = false.obs;
  UserService userService = UserService();

  final Rx<TextEditingController> nameController = Rx(TextEditingController());
  final Rx<TextEditingController> emailController = Rx(TextEditingController());
  final Rx<TextEditingController> phoneController = Rx(TextEditingController());
  final Rx<TextEditingController> passController = Rx(TextEditingController());
  final Rx<TextEditingController> confirmPassController =
      Rx(TextEditingController());

  RxObjectMixin<GetZoneId> getZoneIDModel = GetZoneId().obs;
  // *************SignUp Provider APi******************
  Future<void> signUpProvider(BuildContext context, int selectZoneId) async {
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
        'name': nameController.value.text.trim(),
        'email': emailController.value.text.trim(),
        'phone': phoneController.value.text.trim(),
        'country': selectedCountry!.name.toString(),
        'zone_id': selectZoneId,
        'password': passController.value.text.trim(),
      },
      Constants.providerSignUpUrl,
      RequestType.post,

      onSuccess: (response) {
        // if (response.data['success'] = false) {}
        print("success");
        if (response.statusCode == 201) {
          print(response.data);

          userService.saveBooleanProvider(key: 'is-provider-user', value: true);

          CustomSnackBar.showCustomToast(
              message: response.data['message'],
              color: LightThemeColors.progressIndicatorColor);
          Get.toNamed(Routes.LOGIN);
        }
        isLoading.value = false;
        update();
      },
      onError: (error) {
        if (error.statusCode == 422) {
          String errorMessage = "";

          if (error.response!.data['errors']['email'] != null) {
            CustomSnackBar.showCustomToast(
                message: errorMessage +=
                    error.response!.data['errors']['email'][0] + "\n");
          }

          if (error.response!.data['errors']['phone'] != null) {
            CustomSnackBar.showCustomToast(
                message: errorMessage +=
                    error.response!.data['errors']['email'][1] + "\n");
          }

          CustomSnackBar.showCustomErrorToast(message: errorMessage);
        }

        update();
      },
    );
  }

  // **************** Get zoneID Info **************
  Future getZoneID() async {
    isZoneIdLoading.value = true;

    await BaseClient.safeApiCall(
      Constants.getZoneId,
      RequestType.get,

      onSuccess: (response) {
        if (response.statusCode == 200) {
          print("get Zone status code 200");
          getZoneIDModel.value = GetZoneId.fromJson(response.data);

          print(getZoneIDModel.value.data);
        }
        isZoneIdLoading.value = false;
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
    getZoneID();
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
