// ignore_for_file: unnecessary_null_comparison
import 'dart:io';

import 'package:dio/dio.dart' as diox;
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_account_details/controllers/customer_account_details_controller.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/urls.dart';

class CustomerUpdateDetailsController extends GetxController {
  final customerDetailsController =
      Get.find<CustomerAccountDetailsController>();

  late final Rx<TextEditingController> nameController;
  late final Rx<TextEditingController> emailController;
  late final Rx<TextEditingController> phoneController;
  late final Rx<TextEditingController> bioController;

  RxBool isCustomerUpdateLoading = false.obs;
  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
  }

  void _initializeControllers() {
    final customerInfo = customerDetailsController.customerInfo.value;

    nameController = Rx(TextEditingController(text: customerInfo?.name ?? ''));
    emailController =
        Rx(TextEditingController(text: customerInfo?.email ?? ''));
    phoneController =
        Rx(TextEditingController(text: customerInfo?.mobile ?? ''));
    bioController =
        Rx(TextEditingController(text: customerInfo?.profile?.bio ?? ''));
  }

  Future<void> pickImage(ImageSource src, BuildContext context) async {
    try {
      Navigator.pop(context);
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
        source: src,
        imageQuality: 80, // Compress image to reduce size
      );
      if (image != null) {
        final File file = File(image.path);
        final int fileSize = await file.length();
        print('Selected image size: ${fileSize / 1024} KB');
        selectedImage.value = image;
      }
    } catch (e) {
      print('Error picking image: $e');
      CustomSnackBar.showCustomErrorToast(
        message: 'Failed to pick image. Please try again.',
      );
    }
  }

  File? get imageFile =>
      selectedImage.value != null ? File(selectedImage.value!.path) : null;

  // Future<void> customerUpdateProfile(BuildContext context) async {
  //   try {
  //     isCustomerUpdateLoading.value = true;
  //
  //     // Validate input fields
  //     if (nameController.value.text.trim().isEmpty ||
  //         emailController.value.text.trim().isEmpty ||
  //         phoneController.value.text.trim().isEmpty) {
  //       throw Exception('Please fill all required fields');
  //     }
  //
  //     final formData = diox.FormData();
  //
  //     // Add text fields to form data
  //     formData.fields.addAll([
  //       MapEntry('name', nameController.value.text.trim()),
  //       MapEntry('mobile', phoneController.value.text.trim()),
  //       MapEntry('email', emailController.value.text.trim()),
  //       MapEntry('bio', bioController.value.text.trim()),
  //     ]);
  //
  //     // Handle image upload if selected
  //     if (selectedImage.value != null) {
  //       try {
  //         final file = File(selectedImage.value!.path);
  //         if (await file.exists()) {
  //           print('File exists at path: ${file.path}');
  //           print('File size: ${await file.length()} bytes');
  //
  //           // Get file extension
  //           final String extension = file.path.split('.').last.toLowerCase();
  //           final String mimeType = extension == 'png' ? 'png' : 'jpeg';
  //
  //           formData.files.add(MapEntry(
  //             'image', // Using 'image' as field name to match API expectation
  //             await diox.MultipartFile.fromFile(
  //               file.path,
  //               filename: file.path.split('/').last,
  //               contentType: MediaType('image', mimeType),
  //             ),
  //           ));
  //
  //           print('Image added to form data successfully');
  //         } else {
  //           print('Selected file does not exist at path: ${file.path}');
  //         }
  //       } catch (fileError) {
  //         print('Error handling file: $fileError');
  //         throw Exception('Failed to process selected image');
  //       }
  //     }
  //
  //     // Log form data contents
  //     print('Form data fields: ${formData.fields}');
  //     print('Form data files count: ${formData.files.length}');
  //
  //     // Make API call
  //     await BaseClient.safeApiCall(
  //       headers: {
  //         "Authorization":
  //             "Bearer ${MySharedPref.getToken("token".obs).toString()}",
  //         "Accept": "application/json",
  //       },
  //       data: formData,
  //       Constants.customerInfoUpdateUrl,
  //       RequestType.post,
  //       onSuccess: (response) async {
  //         print('API Response: ${response.data}');
  //
  //         if (response.statusCode == 200) {
  //           // Log success details
  //           final imageUrl = response.data['data']['profile']['image'];
  //           print('Profile updated successfully. New image URL: $imageUrl');
  //
  //           // Refresh customer info
  //           await customerDetailsController.getCustomerInfo();
  //
  //           // Show success message
  //           CustomSnackBar.showCustomToast(
  //             message: response.data['message']?.toString() ??
  //                 'Profile updated successfully',
  //           );
  //
  //           // Navigate back
  //           Get.back();
  //         }
  //       },
  //       onError: (error) {
  //         print('Error Type: ${error.runtimeType}');
  //         print('Status Code: ${error.response?.statusCode}');
  //         print('Error Message: ${error.message}');
  //         print('Response Data: ${error.response?.data}');
  //
  //         String errorMessage = error.response?.data?['message']?.toString() ??
  //             'Failed to update profile';
  //
  //         CustomSnackBar.showCustomErrorToast(message: errorMessage);
  //       },
  //     );
  //   } catch (e, stackTrace) {
  //     print('Exception occurred: $e');
  //     print('Stack trace: $stackTrace');
  //
  //     CustomSnackBar.showCustomErrorToast(
  //       message: e.toString().contains('Exception:')
  //           ? e.toString().split('Exception: ')[1]
  //           : 'An error occurred while updating profile',
  //     );
  //   } finally {
  //     isCustomerUpdateLoading.value = false;
  //   }
  // }

  Future<void> customerUpdateProfile(BuildContext context) async {
    try {
      isCustomerUpdateLoading.value = true;

      // Create FormData
      final formData = diox.FormData();

      // Add basic fields
      formData.fields.addAll([
        MapEntry('name', nameController.value.text.trim()),
        MapEntry('mobile', phoneController.value.text.trim()),
        MapEntry('email', emailController.value.text.trim()),
        MapEntry('bio', bioController.value.text.trim()),
      ]);

      // Handle file upload with proper error handling
      if (selectedImage.value != null) {
        try {
          final file = File(selectedImage.value!.path);
          if (await file.exists()) {
            final fileSize = await file.length();
            print('File exists at: ${file.path}');
            print('File size: ${fileSize} bytes');

            // Add file with correct field name 'image' instead of 'file'
            formData.files.add(MapEntry(
              'image', // Changed from 'file' to 'image'
              await diox.MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
                // Let server determine content type
              ),
            ));
          } else {
            throw Exception('Selected file does not exist at ${file.path}');
          }
        } catch (fileError) {
          print('File handling error: $fileError');
          CustomSnackBar.showCustomErrorToast(
            message: 'Error processing image file. Please try again.',
          );
          isCustomerUpdateLoading.value = false;
          return;
        }
      }

      // Set up Dio options for better timeout handling
      final options = diox.Options(
        headers: {
          "Authorization":
              "Bearer ${MySharedPref.getToken("token".obs).toString()}",
          "Accept": "application/json",
        },
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      );

      print('Sending request with fields: ${formData.fields}');
      print('Files included: ${formData.files.length}');

      await BaseClient.safeApiCall(
        headers: options.headers,
        data: formData,
        Constants.customerInfoUpdateUrl,
        RequestType.post,
        onSuccess: (response) async {
          print('Success Response: ${response.data}');

          if (response.statusCode == 200) {
            // Refresh customer info
            await customerDetailsController.getCustomerInfo();

            CustomSnackBar.showCustomToast(
              message: response.data['message']?.toString() ??
                  'Profile updated successfully',
            );
            Get.back();
          }
        },
        onError: (error) {
          print('Error Type: ${error.runtimeType}');
          print('Error Response: ${error.response?.data}');

          String errorMessage;
          if (error.response?.data != null &&
              error.response!.data['message'] != null) {
            errorMessage = error.response!.data['message'].toString();
          } else if (error.message?.contains('Connection closed') ?? false) {
            errorMessage =
                'Connection error. Please check your internet connection.';
          } else {
            errorMessage = 'Failed to update profile. Please try again.';
          }

          CustomSnackBar.showCustomErrorToast(message: errorMessage);
        },
      );
    } catch (e, stackTrace) {
      print('Exception occurred: $e');
      print('Stack trace: $stackTrace');

      CustomSnackBar.showCustomErrorToast(
        message: 'An unexpected error occurred. Please try again.',
      );
    } finally {
      isCustomerUpdateLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    phoneController.value.dispose();
    bioController.value.dispose();
    super.onClose();
  }
}
