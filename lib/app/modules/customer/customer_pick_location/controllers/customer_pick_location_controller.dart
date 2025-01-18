import 'package:dirham_uae/app/modules/customer/customer_pick_location/model/location_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerPickLocationController extends GetxController {
  // Observable variables for 3 addresses
  final Rx<LocationModel?> address1 = Rx<LocationModel?>(null);
  final Rx<LocationModel?> address2 = Rx<LocationModel?>(null);
  final Rx<LocationModel?> address3 = Rx<LocationModel?>(null);

  // Current selected address index (1,2,3)
  final RxInt selectedAddressIndex = 1.obs;

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedLocations();
  }

  // Get current location using device GPS
  Future<bool> getCurrentLocation() async {
    try {
      isLoading.value = true;

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get address details using geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        LocationModel location = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          fullAddress: "${place.street}, ${place.locality}, ${place.country}",
          streetAddress: place.street ?? "",
          locality: place.locality ?? "",
          country: place.country ?? "",
        );

        // Save to currently selected address slot
        await updateLocation(selectedAddressIndex.value, location);
        return true;
      }
      return false;
    } catch (e) {
      print("Error getting current location: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Pick location from map
  Future<bool> pickLocationFromMap(LatLng position) async {
    try {
      isLoading.value = true;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        LocationModel location = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          fullAddress: "${place.street}, ${place.locality}, ${place.country}",
          streetAddress: place.street ?? "",
          locality: place.locality ?? "",
          country: place.country ?? "",
        );

        await updateLocation(selectedAddressIndex.value, location);
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

  // Update specific address
  Future<bool> updateLocation(int addressIndex, LocationModel location) async {
    try {
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
      return true;
    } catch (e) {
      print("Error updating location: $e");
      return false;
    }
  }

  // Save locations to SharedPreferences
  Future<void> saveLocationToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (address1.value != null) {
        await prefs.setString('address1', address1.value!.toJson().toString());
      }
      if (address2.value != null) {
        await prefs.setString('address2', address2.value!.toJson().toString());
      }
      if (address3.value != null) {
        await prefs.setString('address3', address3.value!.toJson().toString());
      }
    } catch (e) {
      print("Error saving locations to prefs: $e");
    }
  }

  // Load saved locations from SharedPreferences
  Future<void> loadSavedLocations() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String? address1Str = prefs.getString('address1');
      String? address2Str = prefs.getString('address2');
      String? address3Str = prefs.getString('address3');

      if (address1Str != null) {
        Map<String, dynamic> json =
            Map<String, dynamic>.from(address1Str as Map);
        address1.value = LocationModel.fromJson(json);
      }

      if (address2Str != null) {
        Map<String, dynamic> json =
            Map<String, dynamic>.from(address2Str as Map);
        address2.value = LocationModel.fromJson(json);
      }

      if (address3Str != null) {
        Map<String, dynamic> json =
            Map<String, dynamic>.from(address3Str as Map);
        address3.value = LocationModel.fromJson(json);
      }
    } catch (e) {
      print("Error loading saved locations: $e");
    }
  }

  // Clear all saved locations (for logout)
  Future<void> clearLocations() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove('address1');
      await prefs.remove('address2');
      await prefs.remove('address3');

      address1.value = null;
      address2.value = null;
      address3.value = null;
    } catch (e) {
      print("Error clearing locations: $e");
    }
  }

  // Get current active address
  LocationModel? getCurrentActiveAddress() {
    switch (selectedAddressIndex.value) {
      case 1:
        return address1.value;
      case 2:
        return address2.value;
      case 3:
        return address3.value;
      default:
        return null;
    }
  }
}
