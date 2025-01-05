// import 'package:dirham_uae/app/components/custom_snackbar.dart';
// import 'package:dirham_uae/app/data/user_service/user_service.dart';
// import 'package:dirham_uae/app/services/base_client.dart';
// import 'package:dirham_uae/utils/urls.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../data/local/my_shared_pref.dart';
//
// class ChangePasswordController extends GetxController {
//   final Rx<TextEditingController> oldPassController =
//       Rx(TextEditingController());
//   final Rx<TextEditingController> newPassController =
//       Rx(TextEditingController());
//   final Rx<TextEditingController> confirmPassController =
//       Rx(TextEditingController());
//
//   RxBool ischangePassLoading = false.obs;
//   UserService userService = UserService();
//
//   // ***************** provider change pass api Function *********************
//   Future changedPasswordProvider(context) async {
//     ischangePassLoading.value = true;
//
//     try {
//       await BaseClient.safeApiCall(
//         data: {
//           "current_password": oldPassController.value.text.trim(),
//           "password": newPassController.value.text.trim(),
//           "password_confirmation": confirmPassController.value.text.trim(),
//         },
//         headers: {
//           'Authorization':
//               'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
//         },
//         Constants.customerChnagePasswordUrl,
//         RequestType.post,
//         onSuccess: (response) {
//           print("success");
//           // if (response!.statusCode == 200) {
//           //   CustomSnackBar.showCustomToast(
//           //     message: response.data["message"].toString(),
//           //   );
//
//           //   Navigator.pop(context);
//           //   // Get.back(); // When change pass done then back to previous page
//           // }
//           ischangePassLoading.value = false;
//           update();
//           print("all Done change pass");
//         },
//         onError: (error) {
//           if (error.response!.data["success"] == false) {
//             CustomSnackBar.showCustomErrorToast(
//               message: error.response!.data['message'].toString(),
//             );
//           }
//           update();
//         },
//       );
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   final count = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//   void increment() => count.value++;
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../data/local/my_shared_pref.dart';

class ChangePasswordController extends GetxController {
  final Rx<TextEditingController> oldPassController =
      Rx(TextEditingController());
  final Rx<TextEditingController> newPassController =
      Rx(TextEditingController());
  final Rx<TextEditingController> confirmPassController =
      Rx(TextEditingController());
  RxBool isLoading = false.obs;

  Future<void> changePassword(BuildContext context) async {
    try {
      // Debug: Input validation
      print('\n╔══════ Change Password Request Start ══════╗');

      // Validate inputs
      if (oldPassController.value.text.trim().isEmpty ||
          newPassController.value.text.trim().isEmpty ||
          confirmPassController.value.text.trim().isEmpty) {
        print('║ Error: Empty fields detected');
        CustomSnackBar.showCustomToast(
          message: "All fields are required",
          color: LightThemeColors.redColor,
        );
        return;
      }

      if (newPassController.value.text != confirmPassController.value.text) {
        print('║ Error: Password mismatch');
        print('║ New Password: ${newPassController.value.text}');
        print('║ Confirm Password: ${confirmPassController.value.text}');
        CustomSnackBar.showCustomToast(
          message: "New Password and Confirm Password Don't Match",
          color: LightThemeColors.redColor,
        );
        return;
      }

      isLoading.value = true;

      // Debug: Request preparation
      final url = Uri.parse('https://dirham365.com/api/auth/change-password');
      print('║ URL: $url');

      final token = MySharedPref.getTokenProvider("token-provider".obs);
      print('║ Token: ${token?.substring(0, 20)}... (truncated)');

      final body = {
        'old-password': oldPassController.value.text.trim(),
        'password': newPassController.value.text.trim(),
        'password_confirmation': confirmPassController.value.text.trim(),
      };

      print('║ Request Body:');
      print('║ ${json.encode(body)}');

      // Debug: Headers
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      print('║ Request Headers:');
      headers.forEach((key, value) {
        if (key == 'Authorization') {
          print('║ $key: Bearer ${value.substring(7, 27)}... (truncated)');
        } else {
          print('║ $key: $value');
        }
      });

      // Make API call
      print('║ Making API Call...');
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      // Debug: Response
      print('║ Response Status Code: ${response.statusCode}');
      print('║ Response Headers:');
      response.headers.forEach((key, value) {
        print('║ $key: $value');
      });

      final responseData = json.decode(response.body);
      print('║ Response Body:');
      print('║ ${json.encode(responseData)}');

      // Handle response
      if (response.statusCode == 200) {
        print('║ Status 200 received');
        if (responseData['success'] == true) {
          print('║ Password change successful');
          CustomSnackBar.showCustomToast(
            message: responseData['message'] ?? 'Password changed successfully',
            color: LightThemeColors.primaryColor,
          );
          Navigator.pop(context);
        } else {
          print('║ Password change failed: ${responseData['message']}');
          CustomSnackBar.showCustomErrorToast(
            message: responseData['message'] ?? 'Failed to change password',
            color: LightThemeColors.redColor,
          );
        }
      } else {
        print('║ Error status code: ${response.statusCode}');
        print('║ Error message: ${responseData['message']}');
        CustomSnackBar.showCustomErrorToast(
          message: responseData['message'] ?? 'Failed to change password',
          color: LightThemeColors.redColor,
        );
      }
    } catch (e, stackTrace) {
      print('║ Exception occurred:');
      print('║ Error: $e');
      print('║ Stack trace:');
      print('║ $stackTrace');
      CustomSnackBar.showCustomErrorToast(
        message: 'An error occurred while changing password',
        color: LightThemeColors.redColor,
      );
    } finally {
      isLoading.value = false;
      print('╚══════ Change Password Request End ══════╝\n');
    }
  }

  @override
  void dispose() {
    print('Disposing ChangePasswordController');
    oldPassController.value.dispose();
    newPassController.value.dispose();
    confirmPassController.value.dispose();
    super.dispose();
  }
}
