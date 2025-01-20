import 'package:dirham_uae/app/modules/customer/customer_service_details/model/customer_service_details.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/user_service/user_service.dart';
import '../../../../routes/app_pages.dart';

class CustomerServiceDetailsController extends GetxController {
  final int serviceId;
  final UserService _userService = UserService();

  CustomerServiceDetailsController(this.serviceId);

  var isLoading = false.obs;
  Rx<CustomerServiceDetailsModel> customerServiceDetailsModel =
      CustomerServiceDetailsModel().obs;

  @override
  void onInit() {
    super.onInit();
    getServiceDetails(serviceId);
  }

  Future<void> getServiceDetails(int id) async {
    isLoading.value = true;

    try {
      final token = await _userService.getToken();

      await BaseClient.safeApiCall(
        Constants.ServiceCustomerDetails(id),
        RequestType.get,
        headers: {
          'Authorization': token,
        },
        onSuccess: (response) {
          if (response.statusCode == 200) {
            try {
              customerServiceDetailsModel.value =
                  CustomerServiceDetailsModel.fromJson(response.data);
              print("Service details loaded successfully");
              print(
                  "Skills data: ${customerServiceDetailsModel.value.data?.skills}");
              print("Raw response data: ${response.data}");
            } catch (e) {
              print("Error parsing service details: $e");
              Get.snackbar(
                'Error',
                'Failed to process service details',
                backgroundColor: Colors.red.withOpacity(0.8),
                colorText: Colors.white,
              );
            }
          }
        },
        onError: (error) {
          print("Error fetching service details: $error");
          if (error.response?.statusCode == 401) {
            handleUnauthorizedError();
          } else {
            Get.snackbar(
              'Error',
              'Failed to load service details. Please try again.',
              backgroundColor: Colors.red.withOpacity(0.8),
              colorText: Colors.white,
            );
          }
        },
      );
    } catch (e) {
      print("Exception in getServiceDetails: $e");
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void handleUnauthorizedError() async {
    await _userService.removeSharedPreferenceData();
    Get.offAllNamed(Routes.LOGIN);
    Get.snackbar(
      'Session Expired',
      'Please login again to continue',
      backgroundColor: Colors.orange.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  String getFormattedPrice() {
    final data = customerServiceDetailsModel.value.data;
    if (data == null) return "N/A";

    return "${data.price?.toStringAsFixed(2) ?? 'N/A'} ${data.currency?.toUpperCase() ?? 'AED'}";
  }

  String getSkillsString() {
    final data = customerServiceDetailsModel.value.data;
    if (data?.skills == null || data!.skills!.isEmpty)
      return "No skills specified";

    return data.skills!.join(", ");
  }
}
