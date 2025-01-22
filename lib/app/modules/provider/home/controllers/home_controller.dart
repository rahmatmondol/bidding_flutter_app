import 'dart:async';
import 'dart:convert';

import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/modules/provider/home/models/get_categories_model.dart';
import 'package:dirham_uae/app/modules/provider/home/models/provider_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/urls.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../services/base_client.dart';
import '../../../global/customer_pick_location/model/location_model.dart';

class HomeController extends GetxController {
  final selectedCategory = ''.obs;
  final count = 0.obs;
  final isSearching = false.obs;
  final showNoResults = false.obs;

  // Loading states
  RxBool isGetCategoriesloading = false.obs;

  // Data models
  RxObjectMixin<GetCategoriesModel> getCategoriesDataModel =
      GetCategoriesModel().obs;
  RxObjectMixin<Providerservicemodel> getProviderServiceModel =
      Providerservicemodel().obs;

  // Search and filter related variables
  final searchController = TextEditingController();
  final searchResults = <Service>[].obs;
  final showFilterOptions = false.obs;
  Timer? _debounceTimer;

  // Selected filters
  final selectedStatuses = <String>{}.obs;
  final selectedCurrencies = <String>{}.obs;
  final selectedLevels = <String>{}.obs;
  final selectedPriceTypes = <String>{}.obs;

  // Available filter options
  final availableStatuses = ['Active', 'Pending', 'Completed'].obs;
  final availableCurrencies = ['AED', 'USD', 'EUR'].obs;
  final availableLevels = ['Basic', 'Standard', 'Premium'].obs;
  final availablePriceTypes = ['Fixed', 'Hourly', 'Project'].obs;

  final Rx<LocationModel?> currentLocation = Rx<LocationModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getCategoriesData();
    getServiceProvider();
    setupSearchListener();
    loadSavedLocation();
  }

  Future<void> refreshData() async {
    try {
      await Future.wait([
        getCategoriesData(),
        getServiceProvider(),
      ]);
    } catch (e) {
      CustomSnackBar.showCustomErrorToast(
        message: 'Error refreshing data',
      );
    }
  }

  Future<void> updateLocation(LocationModel location) async {
    try {
      // Update the reactive state
      currentLocation.value = location;

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final locationJson = json.encode(location.toJson());
      await prefs.setString('address1', locationJson);

      print('Location updated successfully in service');
      print('New location: ${location.locality}, ${location.country}');
    } catch (e) {
      print('Error updating location in service: $e');
    }
  }

  Future<void> loadSavedLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? address1Str = prefs.getString('address1');

      if (address1Str != null) {
        Map<String, dynamic> json = jsonDecode(address1Str);
        currentLocation.value = LocationModel.fromJson(json);
        print(
            'Loaded saved location: ${currentLocation.value?.locality}, ${currentLocation.value?.country}');
      }
    } catch (e) {
      print("Error loading saved location: $e");
    }
  }

  void setupSearchListener() {
    searchController.addListener(() {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        filterServices(searchController.text);
      });
    });
  }

  Future<void> getCategoriesData() async {
    isGetCategoriesloading.value = true;

    try {
      await BaseClient.safeApiCall(
        Constants.getCategoriesUrl,
        RequestType.get,
        onSuccess: (response) {
          if (response.statusCode == 200) {
            getCategoriesDataModel.value =
                GetCategoriesModel.fromJson(response.data);
          }
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorToast(
            message: error.response?.data['message']?.toString() ??
                'Error fetching categories',
          );
        },
      );
    } finally {
      isGetCategoriesloading.value = false;
      update();
    }
  }

  Future<void> getServiceProvider() async {
    try {
      await BaseClient.safeApiCall(
        Constants.getAllServiceUrl,
        RequestType.get,
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
        },
        onSuccess: (response) {
          if (response.statusCode == 200) {
            final data = Providerservicemodel.fromJson(response.data);
            getProviderServiceModel.value = data;
            // Initialize search results with all services
            searchResults.value = data.data ?? [];
          }
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorToast(
            message: error.response?.data['message']?.toString() ??
                'Error fetching services',
          );
        },
      );
    } finally {
      update();
    }
  }

  void toggleFilterOptions() {
    showFilterOptions.value = !showFilterOptions.value;
  }

  void toggleFilter(String value, RxSet<String> filterSet) {
    if (filterSet.contains(value)) {
      filterSet.remove(value);
    } else {
      filterSet.add(value);
    }
    filterServices(searchController.text);
  }

  void clearFilters() {
    selectedStatuses.clear();
    selectedCurrencies.clear();
    selectedLevels.clear();
    selectedPriceTypes.clear();
    filterServices(searchController.text);
  }

  int calculateMatchScore(Service service) {
    int score = 0;
    String searchText = searchController.text.toLowerCase();

    // Exact matches get highest score
    if (service.title?.toLowerCase() == searchText) {
      score += 10;
    }
    // Partial matches in title
    else if (service.title?.toLowerCase().contains(searchText) ?? false) {
      score += 5;
    }

    // Matches in other fields
    if (service.description?.toLowerCase().contains(searchText) ?? false)
      score += 3;
    if (service.location?.toLowerCase().contains(searchText) ?? false)
      score += 2;

    // Filter matches
    if (selectedStatuses.contains(service.status)) score += 2;
    if (selectedCurrencies.contains(service.currency)) score += 2;
    if (selectedLevels.contains(service.level)) score += 2;
    if (selectedPriceTypes.contains(service.priceType)) score += 2;

    return score;
  }

  void filterServices(String query) {
    isSearching.value = true;
    showNoResults.value = false;

    try {
      if (query.isEmpty &&
          selectedStatuses.isEmpty &&
          selectedCurrencies.isEmpty &&
          selectedLevels.isEmpty &&
          selectedPriceTypes.isEmpty) {
        searchResults.value = getProviderServiceModel.value.data ?? [];
        return;
      }

      var filteredServices =
          getProviderServiceModel.value.data?.where((service) {
                // Search text matching
                bool matchesQuery = true;
                if (query.isNotEmpty) {
                  matchesQuery = ((service.title
                              ?.toLowerCase()
                              .contains(query.toLowerCase()) ??
                          false) ||
                      (service.description
                              ?.toLowerCase()
                              .contains(query.toLowerCase()) ??
                          false) ||
                      (service.location
                              ?.toLowerCase()
                              .contains(query.toLowerCase()) ??
                          false));
                }

                // Filter matching
                bool matchesFilters = true;

                if (selectedStatuses.isNotEmpty) {
                  matchesFilters = matchesFilters &&
                      (service.status != null &&
                          selectedStatuses.contains(service.status));
                }

                if (selectedCurrencies.isNotEmpty) {
                  matchesFilters = matchesFilters &&
                      (service.currency != null &&
                          selectedCurrencies.contains(service.currency));
                }

                if (selectedLevels.isNotEmpty) {
                  matchesFilters = matchesFilters &&
                      (service.level != null &&
                          selectedLevels.contains(service.level));
                }

                if (selectedPriceTypes.isNotEmpty) {
                  matchesFilters = matchesFilters &&
                      (service.priceType != null &&
                          selectedPriceTypes.contains(service.priceType));
                }

                return matchesQuery && matchesFilters;
              }).toList() ??
              [];

      // Sort by relevance score
      filteredServices.sort(
          (a, b) => calculateMatchScore(b).compareTo(calculateMatchScore(a)));

      searchResults.value = filteredServices;
      showNoResults.value = filteredServices.isEmpty;
    } catch (e) {
      print('Error filtering services: $e');
      CustomSnackBar.showCustomErrorToast(message: 'Error filtering services');
    } finally {
      isSearching.value = false;
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    super.onClose();
  }
}
