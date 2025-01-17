import 'dart:convert';

import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_work_people_details/model/get_customer_betting_details_model.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CustomerWorkPeopleDetailsController extends GetxController {
  // Observable for the model
  final bettingDetails = GetBettingListDetailsModel().obs;
  final isLoading = false.obs;

  Future<void> getBidDetails(int id, int bettingId) async {
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse("${Constants.custommerBettingListDetails(bettingId)}"),
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getToken("token".obs).toString()}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        bettingDetails.value = GetBettingListDetailsModel.fromJson(decodedData);
      } else {
        CustomSnackBar.showCustomErrorToast(
            message: "Failed to load bid details");
      }
    } catch (e) {
      CustomSnackBar.showCustomErrorToast(
          message: "An unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> acceptBid(int bettingId) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.acceptBooking),
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getToken("token".obs).toString()}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'bid_id': bettingId.toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        CustomSnackBar.showCustomToast(message: responseData["message"]);
        Get.back(); // Return to previous screen
      } else {
        CustomSnackBar.showCustomErrorToast(message: "Failed to accept bid");
      }
    } catch (e) {
      CustomSnackBar.showCustomErrorToast(
          message: "An unexpected error occurred");
    }
  }

  // Calculate average rating from reviews
  double calculateAverageRating(List<dynamic>? reviews) {
    if (reviews == null || reviews.isEmpty) return 0.0;

    double totalRating = 0.0;
    for (var review in reviews) {
      totalRating += (review['rating'] ?? 0).toDouble();
    }
    return totalRating / reviews.length;
  }

  // Calculate count for each star rating
  Map<int, int> calculateRatingCounts(List<dynamic>? reviews) {
    Map<int, int> counts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

    if (reviews == null) return counts;

    for (var review in reviews) {
      int rating = review['rating'] ?? 0;
      if (counts.containsKey(rating)) {
        counts[rating] = (counts[rating] ?? 0) + 1;
      }
    }

    return counts;
  }

  // Calculate percentage for each star rating
  double calculateRatingPercentage(List<dynamic>? reviews, int starCount) {
    if (reviews == null || reviews.isEmpty) return 0.0;

    Map<int, int> counts = calculateRatingCounts(reviews);
    return (counts[starCount] ?? 0) / reviews.length;
  }
}
