import 'dart:convert';

import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../customer/customer_home/controllers/customer_home_controller.dart';
import '../model/auction_bid_model.dart';
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

  final auctionBids = <AuctionBidModel>[].obs;
  final isBidsLoading = false.obs;

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

  // Future<void> fetchMyAuctions() async {
  //   try {
  //     isMyAuctionsLoading.value = true;
  //     error.value = '';
  //     final url = '$baseUrl/auth/get-my-auctions';
  //     print('Debug URL: $url');
  //
  //     final headers = await _getHeaders();
  //     print('Fetching my auctions with headers: $headers');
  //
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: headers,
  //     );
  //
  //     print('=====================');
  //     print('Fetching my auctions with headers: ${response.body}');
  //     print('========================');
  //
  //     final data = _handleResponse(response);
  //     if (data != null && data['data'] is List) {
  //       final auctions = (data['data'] as List)
  //           .map((item) => AuctionModel.fromJson(item))
  //           .toList();
  //       myAuctions.assignAll(auctions);
  //     }
  //   } catch (e) {
  //     error.value = e.toString();
  //     print('Error in fetchMyAuctions: $e');
  //   } finally {
  //     isMyAuctionsLoading.value = false;
  //   }
  // }

  Future<void> fetchMyAuctions() async {
    try {
      isMyAuctionsLoading.value = true;
      error.value = '';

      final headers = await _getHeaders();
      print('Complete request details:');
      print('URL: $baseUrl/auth/get-my-auctions');
      print('Headers: $headers');

      final response = await http.get(
        Uri.parse('$baseUrl/auth/get-my-auctions'),
        headers: headers,
      );

      print('Raw response: ${response.body}');

      final data = _handleResponse(response);
      print('Parsed data: $data');

      if (data != null && data['data'] is List) {
        final auctions = (data['data'] as List)
            .map((item) => AuctionModel.fromJson(item))
            .toList();
        print('Parsed auctions length: ${auctions.length}');
        myAuctions.assignAll(auctions);
      }
    } catch (e) {
      error.value = e.toString();
      print('Detailed error in fetchMyAuctions: $e');
      print('Stack trace: ${StackTrace.current}');
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
      fetchAuctionBids()
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

// Add this method to fetch auction bids
  Future<void> fetchAuctionBids() async {
    try {
      isBidsLoading.value = true;
      error.value = '';

      final headers = await _getHeaders();
      print('Fetching auction bids with headers: $headers');
      print('Request headers: ${headers.toString()}');

      final response = await http.get(
        Uri.parse('$baseUrl/auth/get-auction-biddings'),
        headers: headers,
      );

      print('=================');
      print('API URL: $baseUrl/auth/get-auction-biddings');
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('=================');

      final data = _handleResponse(response);
      if (data != null && data['data'] is List) {
        final bids = (data['data'] as List)
            .map((item) => AuctionBidModel.fromJson(item))
            .toList();
        auctionBids.assignAll(bids);
      }
    } catch (e) {
      error.value = e.toString();
      print('Error in fetchAuctionBids: $e');
    } finally {
      isBidsLoading.value = false;
    }
  }

// Add methods to handle bid actions
  Future<void> acceptBid(int bidId) async {
    try {
      final headers = await _getHeaders();
      final body = json.encode({'status': 'accepted'});

      final response = await http.post(
        Uri.parse('$baseUrl/auth/update-bid/$bidId'),
        headers: headers,
        body: body,
      );

      final data = _handleResponse(response);
      if (data != null && data['success'] == true) {
        await fetchAuctionBids(); // Refresh bids
        Get.snackbar(
          'Success',
          data['message'] ?? 'Bid accepted successfully',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('Error accepting bid: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> completeBid(int bidId) async {
    try {
      final headers = await _getHeaders();
      final body = json.encode({'status': 'completed'});

      final response = await http.post(
        Uri.parse('$baseUrl/auth/update-bid/$bidId'),
        headers: headers,
        body: body,
      );

      final data = _handleResponse(response);
      if (data != null && data['success'] == true) {
        await fetchAuctionBids(); // Refresh bids
        Get.snackbar(
          'Success',
          data['message'] ?? 'Bid marked as completed',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('Error completing bid: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
