import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/urls.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../services/base_client.dart';

class ApplyController extends GetxController {
  RxString amount = "".obs;
  RxString message = "".obs;
  late int serviceId;
  late String title;
  late String description;
  late String currency;
  late double price = 0.0;
  late String priceType;
  late List<String> skills;
  late DateTime createdAt;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      currency = args['currency'] ?? '';
      // Convert price to double safely
      price = (args['price'] ?? 0.0).toDouble();
      priceType = args['priceType'] ?? '';
      serviceId = args['serviceId'] ?? 0;
      title = args['title'] ?? '';
      description = args['description'] ?? '';
      // Handle createdAt based on its type
      if (args['createdAt'] is DateTime) {
        createdAt = args['createdAt'];
      } else if (args['createdAt'] is String) {
        createdAt = DateTime.parse(args['createdAt']);
      } else {
        createdAt = DateTime.now();
      }
      // createdAt = args['createdAt'] != null
      //     ? DateTime.parse(args['createdAt'])
      //     : DateTime.now();
      skills = List<String>.from(args['skills'] ?? []);
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   final args = Get.arguments;
  //   if (args != null) {
  //     currency = args['currency'];
  //     price = args['price'];
  //     priceType = args['priceType'];
  //     serviceId = args['serviceId'];
  //     title = args['title'];
  //     description = args['description'];
  //     createdAt = args['createdAt'];
  //     skills = List<String>.from(args['skills']);
  //   }
  // }

  Future<void> submitBid() async {
    try {
      final data = {
        'service_id': serviceId.toString(),
        'amount': amount.value.toString(),
        'message': message.value.toString(),
      };

      print('Sending bid data: $data');

      await BaseClient.safeApiCall(
        Constants.createBidding,
        RequestType.post,
        data: data,
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
        },
        onSuccess: (response) {
          print('Bid submitted successfully: ${response.data}');

          Get.snackbar(
            '${response.data['message']}',
            '${response.data['status']}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.toNamed(Routes.NAV_BAR);
        },
        onError: (error) {
          print(
              'Bid submission failed: ${error.message}'); // Print error message

          Get.snackbar(
            'Error',
            'Failed to submit bid: ${error.message}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        },
      );
    } catch (e) {
      print('Unexpected error: $e'); // Print unexpected errors

      Get.snackbar(
        'Error',
        'Unexpected error: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
