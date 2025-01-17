// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';

import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/modules/customer/customer_add_service/model/customer_add_service_model.dart';
import 'package:dirham_uae/app/modules/customer/customer_payment/location_service/location_service.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../data/user_service/user_service.dart';
import '../../../global/customer_tab/model/category-model.dart';
import '../../customer_nav_bar/views/customer_nav_bar_view.dart';
import '../model/sub_category_model.dart';

class CustomerAddServiceController extends GetxController {
  RxString enteredText = "".obs;
  int? categooryId;
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> skill = TextEditingController().obs;
  Rx<TextEditingController> price = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;

  // Rx<QuillEditorController> description = QuillEditorController().obs;

  var lat;
  var lng;

  RxList<String> currency = [
    "AED",
    "USD",
  ].obs;

  var selectedCurrency = ''.obs;

  void updateCurrency(String newValue) {
    selectedCurrency.value = newValue;
  }

  final priceTypeList = [
    "Fixed",
    "Negotiable",
  ].obs;

  var selectedPriceType = ''.obs;

  void updatePriceType(String newValue) {
    selectedPriceType.value = newValue;
  }

  final levelList = [
    "Entry",
    "Intermediate",
    "Expert",
  ].obs;

  var selectedLevelList = ''.obs;

  BuildContext? context;

  final myBox = Hive.box('mapBox');

  var isLoading = false.obs;

  RxList<XFile?> selectedthumbnail = RxList<XFile?>([]);

  RxObjectMixin<CustomerAddServiceModel> customeAddService =
      CustomerAddServiceModel().obs;

  final ImagePicker picker = ImagePicker();

  RxList<String?> ListTags = RxList<String?>();

  // var ListTags = List<String>.empty(growable: true).obs;

  var suggestList = [];

  Position? currentPosition;
  LocationService locationService = LocationService();

  // ***************************** customer Craete Service *********************** //

  @override
  void onInit() {
    super.onInit();
    // fetchTags();
    getCategoory();
  }

  void updateLevel(String newValue) {
    selectedLevelList.value = newValue;
  }

  Future customerCreateService(int categoryId, String subCategoryId,
      String currency, String priceType, String level) async {
    lat = myBox.get("lat");
    lng = myBox.get("lng");
    var currentAddress = myBox.get("address3");

    isLoading.value = true;
    if (selectedthumbnail.value.isEmpty ||
        selectedthumbnail.any((element) => element == null)) {
      CustomSnackBar.showCustomErrorToast(
          message: "Please Select feature image");
      isLoading.value = false;
      return;
    }

    try {
      // Get token using UserService
      final userService = UserService();
      final token = await userService.getToken();

      if (token == null) {
        CustomSnackBar.showCustomErrorToast(message: "Authentication required");
        isLoading.value = false;
        return;
      }

      var uri = Uri.parse(Constants.customerCreateService);
      var request = http.MultipartRequest('POST', uri);

      // Add headers with token from UserService
      request.headers.addAll({
        'Authorization': token, // Token already includes "Bearer "
        'Accept': 'application/json',
      });

      // Add text fields
      request.fields.addAll({
        "title": name.value.text.trim(),
        // "slug": name.value.text.trim().toLowerCase().replaceAll(" ", "-"),
        "description": description.value.text.trim(),
        "price": price.value.text.trim(),
        "location_name": currentAddress ?? "lohagara",
        "latitude": lat ?? "23.1824543",
        "longitude": lng ?? "89.6509966",
        "priceType": priceType.capitalize ?? "Fixed",
        // Capitalize first letter
        "currency": currency.toUpperCase(),
        // Convert to uppercase
        "status": "Active",
        "level": level,
        "postType": "Service",
        // "deadline":
        //     DateTime.now().add(Duration(days: 7)).toString().substring(0, 10),
        "skills": jsonEncode(selectedTags.toList()),
        // "commission": "0",
        // "is_featured": "0",
        "category_id": categooryId?.toString() ?? "0",
        "subCategory_id": subCategoryId,
      });

      // Add images
      for (int i = 0; i < selectedthumbnail.length; i++) {
        if (selectedthumbnail[i] != null) {
          var file = await http.MultipartFile.fromPath(
            'images[]',
            selectedthumbnail[i]!.path,
            contentType: MediaType('image', 'jpeg'),
          );
          request.files.add(file);
        }
      }

      print('Request URL: ${request.url}');
      print('Request Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        customeAddService.value =
            CustomerAddServiceModel.fromJson(jsonResponse);

        CustomSnackBar.showCustomToast(
            message: jsonResponse['message'] ?? 'Service created successfully',
            color: LightThemeColors.progressIndicatorColor);

        Get.to(() => CustomerNavBarView(1));
      } else if (response.statusCode == 302) {
        // Handle redirect
        String? redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          var redirectUri = Uri.parse(redirectUrl);
          // Create new request for redirect
          var redirectRequest = http.MultipartRequest('POST', redirectUri)
            ..headers.addAll(request.headers)
            ..fields.addAll(request.fields);

          // Add files again
          for (var file in request.files) {
            redirectRequest.files.add(await http.MultipartFile.fromPath(
                file.field, file.filename!,
                contentType: file.contentType));
          }

          var redirectStreamResponse = await redirectRequest.send();
          response = await http.Response.fromStream(redirectStreamResponse);

          if (response.statusCode == 200 || response.statusCode == 201) {
            var jsonResponse = jsonDecode(response.body);
            customeAddService.value =
                CustomerAddServiceModel.fromJson(jsonResponse);

            CustomSnackBar.showCustomToast(
                message:
                    jsonResponse['message'] ?? 'Service created successfully',
                color: LightThemeColors.progressIndicatorColor);

            Get.to(() => CustomerNavBarView(1));
          }
        }
      } else {
        throw Exception('Failed to create service: ${response.statusCode}');
      }

      isLoading.value = false;
    } catch (e) {
      print('Error creating service: $e');
      CustomSnackBar.showCustomErrorToast(
          message: 'Error creating service: ${e.toString()}');
      isLoading.value = false;
    }
  }

  RxList<String> apiTags = <String>[].obs;

  // For storing selected tags (both API and custom)
  RxList<String> selectedTags = <String>[].obs;

  // For the text field input
  Rx<TextEditingController> tagController = TextEditingController().obs;

  // Method to add a new tag (either custom or from API)
  void addTag(String tag) {
    if (tag.isNotEmpty &&
        selectedTags.length < 5 &&
        !selectedTags.contains(tag)) {
      selectedTags.add(tag);
      tagController.value.clear();
      update();
    }
  }

  // Method to remove a tag
  void removeTag(String tag) {
    selectedTags.remove(tag);
    update();
  }

  // Method to fetch tags from API
  // Future<void> fetchTags() async {
  //   try {
  //     // Replace with your actual API call
  //     await BaseClient.safeApiCall(
  //       Constants.getCategogy,
  //       RequestType.get,
  //       headers: {
  //         'Authorization':
  //             'Bearer ${MySharedPref.getToken("token".obs).toString()}',
  //       },
  //       onSuccess: (response) {
  //         if (response.statusCode == 200) {
  //           apiTags.value = List<String>.from(response.data['data']);
  //         }
  //       },
  //       onError: (error) {
  //         print('Error fetching tags: $error');
  //       },
  //     );
  //   } catch (e) {
  //     print('Exception fetching tags: $e');
  //   }
  // }

  RxBool isCategoryLoading = false.obs;
  RxObjectMixin<CCatgoryModel> categoryModel = CCatgoryModel().obs;
  RxString categoryyIds = "".obs;
  final selectedCategory = ''.obs;

  Future getCategoory() async {
    isCategoryLoading.value = true;

    await BaseClient.safeApiCall(
      Constants.getZoneId,
      RequestType.get,
      onSuccess: (response) {
        if (response.statusCode == 200) {
          print("get Zone status code 200");
          categoryModel.value = CCatgoryModel.fromJson(response.data);

          print(categoryModel.value.data);
        }
        isCategoryLoading.value = false;
        update();
      },
      onError: (error) {
        print(error.toString());
        CustomSnackBar.showCustomErrorToast(
          message: error.response!.data['message'].toString(),
        );
      },
    );
  }

// In your CustomerAddServiceController class, update these variables:
  RxBool isSubCategoryLoading = false.obs;
  Rx<SubCategoryModel> subCategoryModel = SubCategoryModel().obs;
  RxString selectedSubCategoryId = "".obs;
  int? subCategoryId;

// Update the getSubCategories method:
  Future getSubCategories(int categoryId) async {
    isSubCategoryLoading.value = true;
    selectedSubCategoryId.value = "";

    await BaseClient.safeApiCall(
      Constants.getSubCategoryByID(categoryId),
      RequestType.get,
      onSuccess: (response) {
        if (response.statusCode == 200) {
          print("get SubCategory status code 200");
          subCategoryModel.value = SubCategoryModel.fromJson(response.data);
          print(subCategoryModel.value.data);
        }
        isSubCategoryLoading.value = false;
        update();
      },
      onError: (error) {
        print(error.toString());
        CustomSnackBar.showCustomErrorToast(
          message: error.response!.data['message'].toString(),
        );
        isSubCategoryLoading.value = false;
      },
    );
  }

  @override
  void dispose() {
    name.value.clear();
    super.dispose();
  }
}
