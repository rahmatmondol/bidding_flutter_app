import 'dart:convert';

import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../customer/customer_home/controllers/customer_home_controller.dart';
import '../model/auction_booking_model.dart';

class CustomerAuctionController extends GetxController {
  CustomerHomeController get homeController =>
      Get.find<CustomerHomeController>();

  final searchResults = <AuctionModel>[].obs;
  final TextEditingController searchController = TextEditingController();

  // Observable lists
  final allBookings = <AuctionModel>[].obs;
  final myAuctions = <AuctionModel>[].obs;
  final completedBookings = <AuctionModel>[].obs;
  final acceptedBookings = <AuctionModel>[].obs;

  // Loading states
  final isAllLoading = false.obs;
  final isCompletedLoading = false.obs;
  final isAcceptedLoading = false.obs;
  final isMyAuctionsLoading = false.obs;

  // Error state
  final error = ''.obs;

  // Base URL and services
  final String baseUrl = 'https://dirham365.com/api';
  final UserService _userService = UserService();

  @override
  void onInit() {
    super.onInit();
    refreshAll();

    // Listen to search controller changes
    final homeController = Get.find<CustomerHomeController>();
    ever(homeController.searchController.obs, (_) {
      filterAuctions(homeController.searchController.text);
    });
  }

  // Helper method to get headers with token
  Future<Map<String, String>> _getHeaders() async {
    final isCustomer = await _userService.isUser();

    final token = isCustomer == true
        ? await _userService.getToken()
        : await _userService.getTokenProvider();
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
  }

  // Helper method to handle API responses
  dynamic _handleResponse(http.Response response) {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return decodedData;
      } else {
        throw decodedData['message'] ?? 'Operation failed';
      }
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _userService.removeSharedPreferenceData();
      // Get.offAllNamed('/login');
      throw 'Session expired. Please login again.';
    } else {
      throw 'Server error: ${response.statusCode}';
    }
  }

  // Fetch all bookings
  Future<void> fetchAllBookings() async {
    try {
      isAllLoading.value = true;
      error.value = '';

      final headers = await _getHeaders();
      print('Fetching all bookings with headers: $headers');

      final response = await http.get(
        Uri.parse('$baseUrl/get-auctions'),
        headers: headers,
      );

      final data = _handleResponse(response);
      if (data != null && data['data'] is List) {
        final bookings = (data['data'] as List)
            .map((item) => AuctionModel.fromJson(item))
            .toList();
        allBookings.assignAll(bookings);
      }
    } catch (e) {
      error.value = e.toString();
      print('Error in fetchAllBookings: $e');
    } finally {
      isAllLoading.value = false;
    }
  }

  Future<void> fetchMyAuctions() async {
    try {
      isMyAuctionsLoading.value = true;
      error.value = '';

      final headers = await _getHeaders();
      print('Fetching my auctions with headers: $headers');

      final response = await http.get(
        Uri.parse('$baseUrl/auth/get-my-auctions'),
        headers: headers,
      );

      final data = _handleResponse(response);
      if (data != null && data['data'] is List) {
        final auctions = (data['data'] as List)
            .map((item) => AuctionModel.fromJson(item))
            .toList();
        myAuctions.assignAll(auctions);
      }
    } catch (e) {
      error.value = e.toString();
      print('Error in fetchMyAuctions: $e');
    } finally {
      isMyAuctionsLoading.value = false;
    }
  }

//   // Fetch completed bookings
//   Future<void> fetchCompletedBookings() async {
//     try {
//       isCompletedLoading.value = true;
//       error.value = '';
//
//       final headers = await _getHeaders();
//       print('Fetching completed bookings with headers: $headers');
//
//       final response = await http.get(
//         Uri.parse('$baseUrl/get-auctions?status=completed'),
//         headers: headers,
//       );
//
//       final data = _handleResponse(response);
//       if (data != null && data['data'] is List) {
//         final bookings = (data['data'] as List)
//             .map((item) => AuctionModel.fromJson(item))
//             .toList();
//         completedBookings.assignAll(bookings);
//       }
//     } catch (e) {
//       error.value = e.toString();
//       print('Error in fetchCompletedBookings: $e');
//     } finally {
//       isCompletedLoading.value = false;
//     }
//   }
//
//   // Fetch accepted bookings
//   Future<void> fetchAcceptedBookings() async {
//     try {
//       isAcceptedLoading.value = true;
//       error.value = '';
//
//       final headers = await _getHeaders();
//       print('Fetching accepted bookings with headers: $headers');
//
//       final response = await http.get(
//         Uri.parse('$baseUrl/get-auctions?status=accepted'),
//         headers: headers,
//       );
//
//       final data = _handleResponse(response);
//       if (data != null && data['data'] is List) {
//         final bookings = (data['data'] as List)
//             .map((item) => AuctionModel.fromJson(item))
//             .toList();
//         acceptedBookings.assignAll(bookings);
//       }
//     } catch (e) {
//       error.value = e.toString();
//       print('Error in fetchAcceptedBookings: $e');
//     } finally {
//       isAcceptedLoading.value = false;
//     }
//   }
//
// // mark booking completed
//   Future<void> completeBooking(int id) async {
//     try {
//       final headers = await _getHeaders();
//       print('Completing booking with headers: $headers');
//       // Create request body with status
//       final body = json.encode({'status': 'completed'});
//
//       final response = await http.post(
//           // Uri.parse('$baseUrl/auth/update-auction/$id'),
//           Uri.parse('$baseUrl/auth/update-booking/$id'),
//           headers: headers,
//           body: body);
//
//       final data = _handleResponse(response);
//       if (data != null && data['success'] == true) {
//         // Remove from accepted bookings
//         acceptedBookings.removeWhere((booking) => booking.id == id);
//         // Refresh all bookings
//         await refreshAll();
//
//         Get.snackbar(
//           'Success',
//           data['message'] ?? 'Booking completed successfully',
//           snackPosition: SnackPosition.TOP,
//         );
//       }
//     } catch (e) {
//       error.value = e.toString();
//       print('Error in completeBooking: $e');
//       Get.snackbar(
//         'Error',
//         error.value,
//         snackPosition: SnackPosition.TOP,
//       );
//     }
//   }
//
//   // Cancel booking
//   Future<void> cancelBooking(int id) async {
//     try {
//       final headers = await _getHeaders();
//       print('Cancelling booking with headers: $headers');
//       // Create request body with status
//       final body = json.encode({'status': 'cancelled'});
//
//       final response = await http.post(
//           // Uri.parse('$baseUrl/auth/update-auction/$id'),
//           Uri.parse('$baseUrl/auth/update-booking/$id'),
//           headers: headers,
//           body: body);
//
//       final data = _handleResponse(response);
//       if (data != null && data['success'] == true) {
//         // Remove from accepted bookings
//         acceptedBookings.removeWhere((booking) => booking.id == id);
//         // Refresh all bookings
//         await refreshAll();
//
//         Get.snackbar(
//           'Success',
//           data['message'] ?? 'Booking cancelled successfully',
//           snackPosition: SnackPosition.TOP,
//         );
//       }
//     } catch (e) {
//       error.value = e.toString();
//       print('Error in cancelBooking: $e');
//       Get.snackbar(
//         'Error',
//         error.value,
//         snackPosition: SnackPosition.TOP,
//       );
//     }
//   }
//
//   // Handle review navigation
//   void handleReview(int bookingId) {
//     Get.toNamed('/review', arguments: bookingId);
//   }

  // Refresh all data
  Future<void> refreshAll() async {
    error.value = '';
    await Future.wait([
      fetchAllBookings(),
      // fetchCompletedBookings(),
      // fetchAcceptedBookings(),
      fetchMyAuctions(),
    ]);
  }

  void filterAuctions(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    var filteredAuctions = allBookings.where((auction) {
      final searchLower = query.toLowerCase();
      return (auction.title?.toLowerCase().contains(searchLower) ?? false) ||
          (auction.description?.toLowerCase().contains(searchLower) ?? false) ||
          (auction.location?.toLowerCase().contains(searchLower) ?? false) ||
          (auction.priceType?.toLowerCase().contains(searchLower) ?? false) ||
          (auction.level?.toLowerCase().contains(searchLower) ?? false) ||
          (auction.status?.toLowerCase().contains(searchLower) ?? false);
    }).toList();

    searchResults.value = filteredAuctions;
  }
}
