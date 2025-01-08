// ignore_for_file: unnecessary_null_comparison
import 'dart:io';

import 'package:dio/dio.dart' as diox;
import 'package:dio/dio.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/provider/account_details/controllers/account_details_controller.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../components/custom_snackbar.dart';

class AccountUpdateDetailsController extends GetxController {
  final Rx<TextEditingController> providerNameController = Rx(
    TextEditingController(
      text: Get.find<AccountDetailsController>()
          .getProviderInfoModel
          .value
          .data!
          .provider!
          .name
          .toString(),
    ),
  );

  final Rx<TextEditingController> providerEmailController =
      Rx(TextEditingController(
    text: Get.find<AccountDetailsController>()
        .getProviderInfoModel
        .value
        .data!
        .provider!
        .email
        .toString(),
  ));
  final Rx<TextEditingController> providerPhoneController =
      Rx(TextEditingController(
    text: Get.find<AccountDetailsController>()
        .getProviderInfoModel
        .value
        .data!
        .provider!
        .phone
        .toString(),
  ));
  final Rx<TextEditingController> providerBioController =
      Rx(TextEditingController(
    text: Get.find<AccountDetailsController>()
                .getProviderInfoModel
                .value
                .data!
                .provider!
                .bio ==
            null
        ? ""
        : Get.find<AccountDetailsController>()
            .getProviderInfoModel
            .value
            .data!
            .provider!
            .bio
            .toString(),
  ));
  RxBool isProviderUpdateLoading = false.obs;

  //************************** Image Pick ******************************* */

  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  File? get imageFile =>
      selectedImage.value != null ? File(selectedImage.value!.path) : null;

// ************update profile method**************

  Future<void> providerUpdateProfile() async {
    print("fname " + providerNameController.value.text);
    print("email " + providerEmailController.value.text);
    print("number " + providerPhoneController.value.text);
    print("bio " + providerBioController.value.text);

    isProviderUpdateLoading.value = true;
    print("loading:::::::::::::::::::::::: $isProviderUpdateLoading");
    print(
      "Authorization bbbbbbbb"
      "Bearer ${MySharedPref.getToken("token".obs).toString()}",
    );

    String fileName = selectedImage.value!.path.split('/').last;

    if (fileName != null) {
      try {
        diox.FormData data = diox.FormData.fromMap({
          "image": await diox.MultipartFile.fromFile(selectedImage.value!.path,
              filename: fileName,
              contentType: new MediaType(
                "image",
                "jpeg",
              )),
          'name': providerNameController.value.text.trim(),
          'email': providerEmailController.value.text.trim(),
          'phone': providerPhoneController.value.text.trim(),
          'bio': providerBioController.value.text.trim(),
        });

        await BaseClient.safeApiCall(
          headers: {
            "Authorization":
                "Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}",
          },
          data: data,
          Constants.providerInfoUpdateUrl,
          RequestType.post,
          onSuccess: (response) {
            print(" update api call success");

            if (response.statusCode == 200) {
              print(response.data.toString());

              CustomSnackBar.showCustomToast(
                  message: response.data['message'].toString());
              Get.toNamed(Routes.PROFILE);
            }
            print(response.data['message'].toString());

            print(" update ");

            isProviderUpdateLoading.value = false;
            update();
          },
          onError: (error) {
            if (error.response!.data['success'] == false) {
              print("Errrrrrrrrrrrrrrrrrr $error");

              CustomSnackBar.showCustomErrorToast(
                  message: error.response!.data['message'].toString());
            }
          },
        );
      } catch (e) {
        if (e is DioException) {
          final response = e.response;
          if (response != null) {
            final responseData = response.data;
            if (responseData != null) {
              final errorMessage = responseData['message'];
              // Display the error message to the user
              print('Server Error: $errorMessage');
            }
          }
        }
      }
    } else {
      print("Image Not found");
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
