import 'dart:async';

import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_home/model/get_customer_service_model.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerHomeController extends GetxController {
  Rx<GetCustomerServiceModel> getCustomerModel = GetCustomerServiceModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCustomeService();
  }

  Future<void> getCustomeService() async {
    isLoading.value = true;
    try {
      final result = await BaseClient.safeApiCall(
        Constants.getServiceCustomer,
        RequestType.get,
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getToken("token".obs).toString()}',
        },
        onSuccess: (response) {
          if (response.statusCode == 200) {
            getCustomerModel.value =
                GetCustomerServiceModel.fromJson(response.data);
            print(
                "Data loaded: ${getCustomerModel.value.data?.length} services found");
          } else {
            print("Error loading data: ${response.statusCode}");
          }
        },
      );
    } catch (e) {
      print("Error in getCustomeService: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // Search and filter related variables
  final searchController = TextEditingController();
  final searchResults = <ServiceData>[].obs;
  final showFilterOptions = false.obs;

  // Selected filters
  final selectedStatuses = <String>{}.obs;
  final selectedCurrencies = <String>{}.obs;
  final selectedLevels = <String>{}.obs;
  final selectedPriceTypes = <String>{}.obs;

  // Available filter options (populate these from your data)
  final availableStatuses = ['Active', 'Pending', 'Completed'].obs;
  final availableCurrencies = ['AED', 'USD', 'EUR'].obs;
  final availableLevels = ['Basic', 'Standard', 'Premium'].obs;
  final availablePriceTypes = ['Fixed', 'Hourly', 'Project'].obs;

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

  int calculateMatchScore(ServiceData service) {
    int score = 0;

    if (selectedStatuses.isNotEmpty && service.status != null) {
      if (selectedStatuses.contains(service.status)) score++;
    }

    if (selectedCurrencies.isNotEmpty && service.currency != null) {
      if (selectedCurrencies.contains(service.currency)) score++;
    }

    if (selectedLevels.isNotEmpty && service.level != null) {
      if (selectedLevels.contains(service.level)) score++;
    }

    if (selectedPriceTypes.isNotEmpty && service.priceType != null) {
      if (selectedPriceTypes.contains(service.priceType)) score++;
    }

    return score;
  }

  void filterServices(String query) {
    if (query.isEmpty &&
        selectedStatuses.isEmpty &&
        selectedCurrencies.isEmpty &&
        selectedLevels.isEmpty &&
        selectedPriceTypes.isEmpty) {
      searchResults.clear();
      return;
    }

    var filteredServices = getCustomerModel.value.data?.where((service) {
          bool matchesQuery = true;
          if (query.isNotEmpty) {
            matchesQuery =
                (service.title?.toLowerCase().contains(query.toLowerCase()) ??
                        false) ||
                    (service.description
                            ?.toLowerCase()
                            .contains(query.toLowerCase()) ??
                        false);
          }

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

    // Sort by match score
    filteredServices.sort(
        (a, b) => calculateMatchScore(b).compareTo(calculateMatchScore(a)));

    searchResults.value = filteredServices;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
