// ignore_for_file: unnecessary_null_comparison
import 'dart:io';

import 'package:dio/dio.dart' as diox;
import 'package:dio/dio.dart';
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_account_details/controllers/customer_account_details_controller.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/urls.dart';

class CustomerUpdateDetailsController extends GetxController {
  final Rx<TextEditingController> nameController = Rx(
    TextEditingController(
      text: Get.find<CustomerAccountDetailsController>()
          .getCutomerInfoModel
          .value
          .data!
          .info!
          .name
          .toString(),
    ),
  );

  final Rx<TextEditingController> emailController = Rx(
    TextEditingController(
      text: Get.find<CustomerAccountDetailsController>()
          .getCutomerInfoModel
          .value
          .data!
          .info!
          .email
          .toString(),
    ),
  );
  final Rx<TextEditingController> phoneController = Rx(
    TextEditingController(
      text: Get.find<CustomerAccountDetailsController>()
          .getCutomerInfoModel
          .value
          .data!
          .info!
          .phone
          .toString(),
    ),
  );

  RxBool isCustomerUpdateLoading = false.obs;

  //************************** Image Pick ******************************* */

  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  Future<void> pickImage(ImageSource src, BuildContext context) async {
    Navigator.pop(context);
    final ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: src);
    selectedImage.value = image;
  }

  File? get imageFile =>
      selectedImage.value != null ? File(selectedImage.value!.path) : null;

// ************update profile method**************

  Future<void> customerUpdateProfile(context) async {
    print("fname " + nameController.value.text);
    print("email " + emailController.value.text);
    print("number " + phoneController.value.text);

    isCustomerUpdateLoading.value = true;
    print("loading:::::::::::::::::::::::: $isCustomerUpdateLoading");
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
          'name': nameController.value.text.trim(),
          'phone': phoneController.value.text.trim(),
          'email': emailController.value.text.trim(),
        });

        await BaseClient.safeApiCall(
          headers: {
            "Authorization":
                "Bearer ${MySharedPref.getToken("token".obs).toString()}",
          },
          data: data,
          Constants.customerInfoUpdateUrl,
          RequestType.post,
          onSuccess: (response) {
            print(" update api call success");

            if (response.statusCode == 200) {
              print(response.data.toString());

              CustomSnackBar.showCustomToast(
                  message: response.data['message'].toString());
              Navigator.pop(context);
            }
            print(response.data['message'].toString());

            print(" update ");

            isCustomerUpdateLoading.value = false;
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
