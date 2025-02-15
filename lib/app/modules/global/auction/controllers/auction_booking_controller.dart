import 'dart:async';
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
  late final AuctionBidModel auction;

  // Observable lists
  final allBookings = <AuctionModel>[].obs;
  final myAuctions = <AuctionBidModel>[].obs;
  final completedBookings = <AuctionModel>[].obs;
  final acceptedBookings = <AuctionModel>[].obs;
  final auctionBids = <AuctionBidModel>[].obs;
  final isBidsLoading = false.obs;
  final bidDetails = Rxn<AuctionBidModel>();
  final isBidDetailsLoading = false.obs;
  RxBool isAuctionEnded = false.obs;
  RxString remainingTime = ''.obs;

  // Loading states
  final isAllLoading = false.obs;
  final isCompletedLoading = false.obs;
  final isAcceptedLoading = false.obs;
  final isMyAuctionsLoading = false.obs;
  final currenIndex = 0.obs;
  Timer? countdownTimer;

  // Error state
  final error = ''.obs;

  // Base URL and services
  final String baseUrl = 'https://dirham365.com/api';
  final UserService _userService = UserService();

  @override
  void onInit() {
    super.onInit();
    refreshAll();
    startTimer();

    // Listen to search controller changes
    final homeController = Get.find<CustomerHomeController>();
    ever(homeController.searchController.obs, (_) {
      filterAuctions(homeController.searchController.text);
    });
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    super.onClose();
  }

  void startTimer() {
    try {
      final deadline = DateTime.parse(auction.service.deadline ?? '00.00');

      countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        final now = DateTime.now();
        final difference = deadline.difference(now);

        if (difference.isNegative) {
          timer.cancel();
          isAuctionEnded.value = true;
          remainingTime.value = 'Auction Ended';
        } else {
          final days = difference.inDays;
          final hours = difference.inHours % 24;
          final minutes = difference.inMinutes % 60;
          final seconds = difference.inSeconds % 60;

          remainingTime.value = '${days}d ${hours}h ${minutes}m ${seconds}s';
        }
      });
    } catch (e) {
      print('Error in startTimer: $e');
      remainingTime.value = 'Auction Ended';
    }
  }

  // Method to update current image index
  void updateImageIndex(int index) {
    currenIndex.value = index;
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
        Uri.parse('$baseUrl/auth/get-auction-biddings'),
        headers: headers,
      );

      final data = _handleResponse(response);
      if (data != null && data['data'] is List) {
        final auctions = (data['data'] as List)
            .map((item) => AuctionBidModel.fromJson(item))
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

  Future<void> fetchAuctionBids() async {
    try {
      isBidsLoading.value = true;
      error.value = '';

      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/auth/get-auction-biddings'),
        headers: headers,
      );

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

  Future<void> getBidDetails(int bidId) async {
    try {
      isBidDetailsLoading.value = true;
      error.value = '';

      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/auth/get-bidding-info?bid_id=$bidId'),
        headers: headers,
      );

      final data = _handleResponse(response);
      if (data != null && data['data'] != null) {
        bidDetails.value = AuctionBidModel.fromJson(data['data']);
      }
    } catch (e) {
      error.value = e.toString();
      print('Error in getBidDetails: $e');
    } finally {
      isBidDetailsLoading.value = false;
    }
  }

  Future<void> completeBid(int auctionId) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/auth/auction-update-bidding'),
        headers: headers,
        body: jsonEncode({
          'auction_id': auctionId.toString(),
          'status': 'completed',
        }),
      );

      final data = _handleResponse(response);
      if (data != null && data['success'] == true) {
        Get.snackbar(
          'Success',
          data['message'] ?? 'Auction completed successfully',
          snackPosition: SnackPosition.TOP,
        );
        // Refresh all the lists to update the UI
        await refreshAll();
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        error.value,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> acceptBid(int bidId) async {
    try {
      final headers = await _getHeaders();
      final response =
          await http.post(Uri.parse('$baseUrl/auth/auction-update-bidding'),
              headers: headers,
              body: jsonEncode({
                'bid_id': bidId.toString(),
                'status': 'accepted',
              }));

      final data = _handleResponse(response);
      if (data != null && data['success'] == true) {
        Get.snackbar(
          'Success',
          data['message'] ?? 'Bid accepted successfully',
          snackPosition: SnackPosition.TOP,
        );
        await fetchAuctionBids(); // Refresh the list
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        error.value,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> rejectBid(int bidId) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/auth/auction-update-bidding'),
        headers: headers,
        body: jsonEncode({
          'bid_id': bidId.toString(),
          'status': 'rejected',
        }),
      );

      final data = _handleResponse(response);
      if (data != null && data['success'] == true) {
        Get.snackbar(
          'Success',
          data['message'] ?? 'Bid rejected successfully',
          snackPosition: SnackPosition.TOP,
        );
        await fetchAuctionBids(); // Refresh the list
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        error.value,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

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
}
