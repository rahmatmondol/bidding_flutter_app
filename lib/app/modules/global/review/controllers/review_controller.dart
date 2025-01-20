import 'dart:convert';

import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReviewController extends GetxController {
  final UserService _userService = UserService();
  final rating = 0.obs;
  final comment = ''.obs;
  final isLoading = false.obs;
  late int bookingId;

  @override
  void onInit() {
    super.onInit();
    // Get booking_id from navigation arguments
    bookingId = Get.arguments as int;
  }

  // Method to update rating
  void updateRating(int value) {
    rating.value = value;
  }

  // Method to update comment
  void updateComment(String value) {
    comment.value = value;
  }

  // Submit review
  Future<void> submitReview() async {
    if (rating.value == 0) {
      print('Review submission failed: No rating selected');
      Get.snackbar(
        'Error',
        'Please select a rating',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading.value = true;
      final token = await _userService.getToken();

      print('Submitting review with data:');
      print('Booking ID: $bookingId');
      print('Rating: ${rating.value}');
      print('Comment: ${comment.value}');
      print('Token: $token');

      final requestBody = {
        'booking_id': bookingId,
        'rating': rating.value,
        'comment': comment.value,
      };
      print('Request body: $requestBody');

      final response = await http.post(
        Uri.parse(Constants.createReview),
        headers: {
          'Authorization': token ?? '',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Response data decoded: $responseData');

        if (responseData['success'] == true) {
          print('Review submitted successfully');
          Get.snackbar(
            'Success',
            'Review submitted successfully',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );

          Get.toNamed(Routes.CUSTOMER_NAV_BAR);
          update();
        } else {
          print('Review submission failed: ${responseData['message']}');
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to submit review');
          update();
        }
      } else {
        print('Review submission failed with status: ${response.statusCode}');
        Get.snackbar(
          'Error',
          'Failed to submit a rating',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('Exception during review submission: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      print('Review submission process completed. Loading state reset.');
      isLoading.value = false;
      update();
    }
  }
}
