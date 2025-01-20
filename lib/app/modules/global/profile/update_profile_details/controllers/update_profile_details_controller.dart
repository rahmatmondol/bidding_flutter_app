// ignore_for_file: unnecessary_null_comparison
import 'dart:io';

import 'package:dio/dio.dart' as diox;
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../utils/urls.dart';
import '../../../../../data/user_service/user_service.dart';
import '../../account_details/controllers/account_details_controller.dart';

class CustomerUpdateDetailsController extends GetxController {
  final customerDetailsController =
      Get.find<CustomerAccountDetailsController>();
  final UserService _userService = UserService();

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

  Future<void> customerUpdateProfile(BuildContext context) async {
    try {
      isCustomerUpdateLoading.value = true;

      String? token;
      if (await _userService.isUser()) {
        token = await _userService.getToken();
      } else if (await _userService.isProvider()) {
        token = await _userService.getTokenProvider();
      }

      if (token == null) {
        CustomSnackBar.showCustomErrorToast(message: 'Authentication error');
        return;
      }

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

            // Add proper MIME type detection
            String mimeType = 'image/jpeg'; // default
            if (file.path.toLowerCase().endsWith('.png')) {
              mimeType = 'image/png';
            } else if (file.path.toLowerCase().endsWith('.jpg') ||
                file.path.toLowerCase().endsWith('.jpeg')) {
              mimeType = 'image/jpeg';
            }

            // Add file with correct field name 'image' instead of 'file'
            formData.files.add(
              MapEntry(
                'image', // Changed from 'file' to 'image'
                await diox.MultipartFile.fromFile(
                  file.path,
                  filename: file.path.split('/').last,
                  // Let server determine content type
                  // contentType: mimeType == 'image/png'
                  //     ? diox.MediaType.parse('image/png')
                  //     : diox.MediaType.parse('image/jpeg'),
                ),
              ),
            );
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
          "Authorization": token,
          "Accept": "application/json",
          "Content-Type": "multipart/form-data",
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
      update();
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
