// import 'dart:ui';
//
// import 'package:country_list_pick/country_list_pick.dart';
// import 'package:dirham_uae/app/modules/global/provider_tab/models/get_zone_id_models.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../config/theme/light_theme_colors.dart';
// import '../../../../../utils/urls.dart';
// import '../../../../components/custom_loading_dialog_widget.dart';
// import '../../../../components/custom_snackbar.dart';
// import '../../../../data/user_service/user_service.dart';
// import '../../../../routes/app_pages.dart';
// import '../../../../services/base_client.dart';
// import '../../customer_tab/model/category-model.dart';
//
// class ProviderTabController extends GetxController {
//   // For zone selection - similar to category pattern
//   RxString zoneIds = "".obs; // Store zone name
//   int? selectedZoneId; // Store zone ID
//   RxBool isZoneIdLoading = false.obs;
//
//   UserService userService = UserService();
//
//   // Keep your existing controllers
//   final Rx<TextEditingController> nameController = Rx(TextEditingController());
//   final Rx<TextEditingController> emailController = Rx(TextEditingController());
//   final Rx<TextEditingController> phoneController = Rx(TextEditingController());
//   final Rx<TextEditingController> passController = Rx(TextEditingController());
//   final Rx<TextEditingController> confirmPassController =
//       Rx(TextEditingController());
//   Rx<TextEditingController> country = TextEditingController().obs;
//
//   // For country selection
//   CountryCode? selectedCountry;
//
//   RxObjectMixin<GetZoneId> getZoneIDModel = GetZoneId().obs;
//
//   @override
//   void onInit() {
//     getCategoory();
//     super.onInit();
//   }
//
//   // Updated getZoneID method with better error handling
//   // Future<void> getZoneID() async {
//   //   isZoneIdLoading.value = true;
//   //
//   //   try {
//   //     await BaseClient.safeApiCall(
//   //       Constants.getZoneId,
//   //       RequestType.get,
//   //       onSuccess: (response) {
//   //         if (response.statusCode == 200) {
//   //           getZoneIDModel.value = GetZoneId.fromJson(response.data);
//   //           print("Zone data loaded successfully");
//   //         }
//   //         isZoneIdLoading.value = false;
//   //         update();
//   //       },
//   //       onError: (error) {
//   //         isZoneIdLoading.value = false;
//   //         CustomSnackBar.showCustomErrorToast(
//   //           message: error.response?.data['message']?.toString() ??
//   //               'Failed to load zones',
//   //         );
//   //         update();
//   //       },
//   //     );
//   //   } catch (e) {
//   //     isZoneIdLoading.value = false;
//   //     CustomSnackBar.showCustomErrorToast(
//   //       message: 'An unexpected error occurred while loading zones',
//   //     );
//   //     update();
//   //   }
//   // }
//
//   // Updated signup method with proper zone handling
//
//   RxBool isCategoryLoading = false.obs;
//   RxObjectMixin<CCatgoryModel> categoryModel = CCatgoryModel().obs;
//   RxString categoryyIds = "".obs;
//
//   Future getCategoory() async {
//     isCategoryLoading.value = true;
//
//     await BaseClient.safeApiCall(
//       Constants.getZoneId,
//       RequestType.get,
//       onSuccess: (response) {
//         if (response.statusCode == 200) {
//           print("get Zone status code 200");
//           categoryModel.value = CCatgoryModel.fromJson(response.data);
//
//           print(categoryModel.value.data);
//         }
//         isCategoryLoading.value = false;
//         update();
//       },
//       onError: (error) {
//         print(error.toString());
//         CustomSnackBar.showCustomErrorToast(
//           message: error.response!.data['message'].toString(),
//         );
//       },
//     );
//   }
//
//   Future<void> signUpProvider(BuildContext context) async {
//     if (selectedZoneId == null) {
//       CustomSnackBar.showCustomToast(
//         message: "Please select a zone",
//         color: LightThemeColors.redColor,
//       );
//       return;
//     }
//
//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (c) => BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//           child: const CustomLoadingWidget(
//             message: "Processing",
//           ),
//         ),
//       );
//
//       await BaseClient.safeApiCall(
//         data: {
//           'name': nameController.value.text.trim(),
//           'email': emailController.value.text.trim(),
//           'phone': phoneController.value.text.trim(),
//           'country': selectedCountry?.name ?? '',
//           'category_id': selectedZoneId, // Using stored zone ID
//           'password': passController.value.text.trim(),
//         },
//         Constants.providerSignUpUrl,
//         RequestType.post,
//         onSuccess: (response) async {
//           if (response.statusCode == 201) {
//             await userService.saveBooleanProvider(
//                 key: 'is-provider-user', value: true);
//
//             Navigator.pop(context); // Dismiss loading
//
//             CustomSnackBar.showCustomToast(
//               message: response.data['message'],
//               color: LightThemeColors.progressIndicatorColor,
//             );
//
//             Get.toNamed(Routes.LOGIN);
//           }
//         },
//         onError: (error) {
//           Navigator.pop(context); // Dismiss loading
//           _onError(error);
//         },
//       );
//     } catch (e) {
//       if (context.mounted) Navigator.pop(context);
//       CustomSnackBar.showCustomErrorToast(
//         message: "An unexpected error occurred",
//       );
//     }
//   }
//
//   _onError(error) {
//     if (error.statusCode == 422) {
//       String errorMessage = "";
//
//       if (error.response!.data['errors']['email'] != null) {
//         CustomSnackBar.showCustomToast(
//             message: errorMessage +=
//                 error.response!.data['errors']['email'][0] + "\n");
//       }
//
//       if (error.response!.data['errors']['phone'] != null) {
//         CustomSnackBar.showCustomToast(
//             message: errorMessage +=
//                 error.response!.data['errors']['email'][1] + "\n");
//       }
//
//       CustomSnackBar.showCustomErrorToast(message: errorMessage);
//     }
//
//     update();
//   }
// }

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
import '../../customer_tab/model/category-model.dart';

class ProviderTabController extends GetxController {
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

  // Future signUpCustomer(BuildContext context) async {
  //   showDialog(
  //     context: context,
  //     builder: (c) {
  //       return BackdropFilter(
  //         filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
  //         child: const CustomLoadingWidget(
  //           message: "Checking",
  //         ),
  //       );
  //     },
  //   );
  //
  //   isLoading.value = true;
  //
  //   await BaseClient.safeApiCall(
  //     // headers: {
  //     //   "Authorization":
  //     //       "Bearer ${MySharedPref.getToken("token".obs).toString()}",
  //     // },
  //     data: {
  //       'name': nameController.text.trim(),
  //       'email': emailController.text.trim(),
  //       'password': passController.text.trim(),
  //       'country': country.text.trim(),
  //       'mobile': phoneController.text.trim(),
  //       'category_id': categooryId,
  //       'account_type': 'customer'
  //     },
  //     Constants.customerSignUpUrl,
  //     RequestType.post,
  //
  //     onSuccess: (response) {
  //       // if (response.data['success'] = false) {}
  //       print("success");
  //       if (response.statusCode == 201) {
  //         print(response.data);
  //
  //         userService.saveBoolean(key: 'is-user', value: true);
  //         // userService.saveString(
  //         //     key: 'token', value: response.data['verify_token']);
  //         CustomSnackBar.showCustomToast(
  //             message: response.data['message'],
  //             color: LightThemeColors.progressIndicatorColor);
  //         Get.toNamed(Routes.CUSTOMER_LOCATION);
  //       }
  //
  //       isLoading.value = false;
  //       update();
  //     },
  //     onError: (error) {
  //       if (error.statusCode == 422) {
  //         String errorMessage = "";
  //
  //         if (error.response!.data['errors']['phone'] != null) {
  //           errorMessage += error.response!.data['errors']['phone'][0] + "\n";
  //         }
  //
  //         if (error.response!.data['errors']['email'] != null) {
  //           errorMessage += error.response!.data['errors']['email'][0] + "\n";
  //         }
  //
  //         CustomSnackBar.showCustomErrorToast(message: errorMessage);
  //         Navigator.pop(context);
  //       }
  //       isLoading.value = false;
  //       update();
  //     },
  //   );
  // }
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
          'category_id': categooryId, //zone id
          'account_type': 'provider'
        },
        Constants.customerSignUpUrl,
        RequestType.post,
        onSuccess: (response) async {
          if (response.statusCode == 200) {
            print(response.data);

            await userService.saveBoolean(key: 'is-user', value: true);

            // First dismiss the loading dialog
            Navigator.pop(context);

            // Show success message
            CustomSnackBar.showCustomToast(
                message: response.data['message'],
                color: LightThemeColors.progressIndicatorColor);

            // Then navigate
            Get.offAllNamed(Routes.CUSTOMER_LOCATION);
          } else {
            // Handle non-201 success cases
            Navigator.pop(context); // Dismiss loading dialog
            CustomSnackBar.showCustomErrorToast(
                message: "Unexpected response: ${response.statusCode}");
          }

          isLoading.value = false;
          update();
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
