import 'dart:convert';

import 'package:dirham_uae/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/user_service/user_service.dart';
import '../../../customer/customer_home/controllers/customer_home_controller.dart';
import '../../../provider/home/controllers/home_controller.dart';
import '../model/location_model.dart';

class CustomerPickLocationController extends GetxController {
  // Observable variables
  final Rx<LocationModel?> address1 = Rx<LocationModel?>(null);
  final Rx<LocationModel?> address2 = Rx<LocationModel?>(null);
  final Rx<LocationModel?> address3 = Rx<LocationModel?>(null);
  final RxInt selectedAddressIndex = 1.obs;
  final RxBool isLoading = false.obs;
  final RxList<LocationModel> searchResults = <LocationModel>[].obs;
  final RxBool isSearching = false.obs;
  GoogleMapController? mapController;

  final String googleMapsApiKey = Constants.google_api_key;

  // @override
  // void onInit() {
  //   super.onInit();
  //   loadSavedLocations();
  // }
  @override
  void onInit() {
    super.onInit();
    loadSavedLocations();
    // Move initial map to saved location if it exists
    final savedLocation = getCurrentActiveAddress();
    if (savedLocation != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        moveMapToLocation(
            LatLng(savedLocation.latitude, savedLocation.longitude));
      });
    }
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
    print('Map controller set successfully');
  }

  void moveMapToLocation(LatLng location) {
    if (mapController != null) {
      print('Moving map to: ${location.latitude}, ${location.longitude}');
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: location,
            zoom: 15.0,
          ),
        ),
      );
    } else {
      print('Map controller is null');
    }
  }

  Future<void> searchLocation(String query) async {
    print('Searching for query: $query');

    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isSearching.value = true;
      final encodedQuery = Uri.encodeComponent(query);
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json'
          '?input=$encodedQuery'
          '&key=$googleMapsApiKey'
          // '&components=country:ae'
          ); // Restrict to UAE

      print('Making API request to: $url');

      final response = await http.get(url);
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        searchResults.clear();
        print('Number of predictions: ${data['predictions'].length}');

        for (var prediction in data['predictions']) {
          print('Processing prediction: ${prediction['description']}');

          try {
            // Get detailed place information
            final placeUrl = Uri.parse(
                'https://maps.googleapis.com/maps/api/place/details/json'
                '?place_id=${prediction['place_id']}'
                '&key=$googleMapsApiKey');

            final placeResponse = await http.get(placeUrl);
            final placeData = json.decode(placeResponse.body);

            if (placeData['status'] == 'OK') {
              final location = placeData['result']['geometry']['location'];
              final lat = location['lat'];
              final lng = location['lng'];

              print('Found location - Lat: $lat, Lng: $lng');

              searchResults.add(LocationModel(
                latitude: lat,
                longitude: lng,
                fullAddress: prediction['description'],
                streetAddress:
                    prediction['structured_formatting']['main_text'] ?? '',
                locality:
                    prediction['structured_formatting']['secondary_text'] ?? '',
                country: 'UAE',
              ));
            }
          } catch (e) {
            print('Error processing place details: $e');
          }
        }
        print('Final search results count: ${searchResults.length}');
      } else {
        print('API returned status: ${data['status']}');
      }
    } catch (e) {
      print('Error in searchLocation: $e');
    } finally {
      isSearching.value = false;
    }
  }

  Future<bool> getCurrentLocation() async {
    try {
      isLoading.value = true;
      print('Getting current location...');

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled');
        Get.snackbar('Error', 'Location services are disabled');
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permission denied');
          Get.snackbar('Error', 'Location permission denied');
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied');
        Get.snackbar('Error', 'Location permissions are permanently denied');
        return false;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print(
          'Current position - Lat: ${position.latitude}, Lng: ${position.longitude}');

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        print('Placemark details:');
        print('Street: ${place.street}');
        print('Locality: ${place.locality}');
        print('Country: ${place.country}');

        // In getCurrentLocation method, replace the LocationModel creation with:
        LocationModel location = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          fullAddress:
              "${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}"
                  .replaceAll(RegExp(r', ,'), ',')
                  .replaceAll(RegExp(r'^,|,$'), ''),
          streetAddress: place.street ?? "",
          locality: "${place.subLocality ?? ''} ${place.locality ?? ''}".trim(),
          country: place.country ?? "UAE",
        );

        // LocationModel location = LocationModel(
        //   latitude: position.latitude,
        //   longitude: position.longitude,
        //   fullAddress: "${place.street}, ${place.locality}, ${place.country}",
        //   streetAddress: place.street ?? "",
        //   locality: place.locality ?? "",
        //   country: place.country ?? "",
        // );

        await updateLocation(selectedAddressIndex.value, location);
        print('Location updated successfully');
        Get.snackbar('Success', 'Location updated successfully');
        return true;
      }
      return false;
    } catch (e) {
      print('Error in getCurrentLocation: $e');
      Get.snackbar('Error', 'Failed to get current location');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Future<bool> pickLocationFromMap(LatLng position) async {
  //   try {
  //     isLoading.value = true;
  //     print(
  //         'Picking location from map - Lat: ${position.latitude}, Lng: ${position.longitude}');
  //
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );
  //
  //     if (placemarks.isNotEmpty) {
  //       Placemark place = placemarks.first;
  //       print('Placemark details from map:');
  //       print('Street: ${place.street}');
  //       print('Locality: ${place.locality}');
  //       print('Country: ${place.country}');
  //
  //       LocationModel location = LocationModel(
  //         latitude: position.latitude,
  //         longitude: position.longitude,
  //         fullAddress: "${place.street}, ${place.locality}, ${place.country}",
  //         streetAddress: place.street ?? "",
  //         locality: place.locality ?? "",
  //         country: place.country ?? "",
  //       );
  //
  //       await updateLocation(selectedAddressIndex.value, location);
  //       update();
  //       print('Location from map updated successfully');
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     print("Error picking location from map: $e");
  //     return false;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future<bool> pickLocationFromMap(LatLng position) async {
    try {
      isLoading.value = true;
      print(
          'Picking location from map - Lat: ${position.latitude}, Lng: ${position.longitude}');

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        // Create a more readable address
        List<String> addressParts = [
          if (place.street?.isNotEmpty == true) place.street!,
          if (place.subLocality?.isNotEmpty == true) place.subLocality!,
          if (place.locality?.isNotEmpty == true) place.locality!,
          if (place.administrativeArea?.isNotEmpty == true)
            place.administrativeArea!,
        ];

        String readableAddress = addressParts.join(", ");

        LocationModel location = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          fullAddress: readableAddress,
          streetAddress: place.street ?? "",
          locality: "${place.subLocality ?? ''} ${place.locality ?? ''}".trim(),
          country: place.country ?? "UAE",
        );

        await updateLocation(selectedAddressIndex.value, location);
        update();
        return true;
      }
      return false;
    } catch (e) {
      print("Error picking location from map: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateLocation(int addressIndex, LocationModel location) async {
    // final locationService = Get.find<CustomerHomeController>();
    try {
      print('Updating location for address $addressIndex');
      print('Location details:');
      print('Latitude: ${location.latitude}');
      print('Longitude: ${location.longitude}');
      print('Full Address: ${location.fullAddress}');
      print('Street Address: ${location.streetAddress}');
      print('Locality: ${location.locality}');
      print('Country: ${location.country}');

      // await locationService.updateLocation(location);

      // Use UserService to check user type
      final userService = UserService();
      final isProviderUser = await userService.isProvider();

      // Update location based on user type
      if (isProviderUser) {
        try {
          final homeController = Get.find<HomeController>();
          await homeController.updateLocation(location);
        } catch (e) {
          print('Error finding HomeController: $e');
          Get.put(HomeController()); // Put if not found
          final homeController = Get.find<HomeController>();
          await homeController.updateLocation(location);
        }
      } else {
        try {
          final customerHomeController = Get.find<CustomerHomeController>();
          await customerHomeController.updateLocation(location);
        } catch (e) {
          print('Error finding CustomerHomeController: $e');
          Get.put(CustomerHomeController()); // Put if not found
          final customerHomeController = Get.find<CustomerHomeController>();
          await customerHomeController.updateLocation(location);
        }
      }

      switch (addressIndex) {
        case 1:
          address1.value = location;
          break;
        case 2:
          address2.value = location;
          break;
        case 3:
          address3.value = location;
          break;
        default:
          return false;
      }

      await saveLocationToPrefs();
      update();
      print('Location updated and saved to preferences');
      return true;
    } catch (e) {
      print("Error updating location: $e");
      return false;
    }
  }

  Future<void> saveLocationToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (address1.value != null) {
        final address1Json = json.encode(address1.value!.toJson());
        await prefs.setString('address1', address1Json);
        print('Address 1 saved: $address1Json');
      }
      if (address2.value != null) {
        final address2Json = json.encode(address2.value!.toJson());
        await prefs.setString('address2', address2Json);
        print('Address 2 saved: $address2Json');
      }
      if (address3.value != null) {
        final address3Json = json.encode(address3.value!.toJson());
        await prefs.setString('address3', address3Json);
        print('Address 3 saved: $address3Json');
      }
    } catch (e) {
      print("Error saving locations to prefs: $e");
    }
  }

  Future<void> loadSavedLocations() async {
    try {
      print('Loading saved locations...');
      final prefs = await SharedPreferences.getInstance();

      String? address1Str = prefs.getString('address1');
      String? address2Str = prefs.getString('address2');
      String? address3Str = prefs.getString('address3');

      if (address1Str != null) {
        Map<String, dynamic> json = jsonDecode(address1Str);
        address1.value = LocationModel.fromJson(json);
        print('Loaded Address 1: $address1Str');
      }

      if (address2Str != null) {
        Map<String, dynamic> json = jsonDecode(address2Str);
        address2.value = LocationModel.fromJson(json);
        print('Loaded Address 2: $address2Str');
      }

      if (address3Str != null) {
        Map<String, dynamic> json = jsonDecode(address3Str);
        address3.value = LocationModel.fromJson(json);
        print('Loaded Address 3: $address3Str');
      }
    } catch (e) {
      print("Error loading saved locations: $e");
    }
  }

  LocationModel? getCurrentActiveAddress() {
    final address = switch (selectedAddressIndex.value) {
      1 => address1.value,
      2 => address2.value,
      3 => address3.value,
      _ => null,
    };

    if (address != null) {
      print('Current active address:');
      print('Index: ${selectedAddressIndex.value}');
      print('Latitude: ${address.latitude}');
      print('Longitude: ${address.longitude}');
      print('Full Address: ${address.fullAddress}');
    }

    return address;
  }
}
