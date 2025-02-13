import 'dart:convert';

import 'package:dirham_uae/app/components/custom_snackbar.dart';
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
import '../../../customer/customer_nav_bar/views/customer_nav_bar_view.dart';
import '../../../global/customer_tab/model/category-model.dart';
import '../model/add_auction_model.dart';
import '../model/auction_sub_category_model.dart';

class CustomerAddAuctionController extends GetxController {
  RxString enteredText = "".obs;
  RxBool isCustomer = false.obs;
  final userService = UserService();
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  int? categooryId;
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> skill = TextEditingController().obs;
  Rx<TextEditingController> price = TextEditingController().obs;

  // Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;

  // Rx<QuillEditorController> description = QuillEditorController().obs;
  var address = Rx<TextEditingController>(TextEditingController());
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

  final durationList = List.generate(31, (index) => (index + 1).toString()).obs;
  var selectedDuration = ''.obs;

  BuildContext? context;

  final myBox = Hive.box('mapBox');

  var isLoading = false.obs;

  RxList<XFile?> selectedthumbnail = RxList<XFile?>([]);

  RxObjectMixin<CustomerAddAuctionModel> customeAddAuction =
      CustomerAddAuctionModel().obs;

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
    checkUserType();
    getCategoory();
  }

  Future<void> checkUserType() async {
    isCustomer.value = await userService.isUser() ?? false;
  }

  void updateLevel(String newValue) {
    selectedLevelList.value = newValue;
  }

  Future customerCreateAuction(int categoryId, String subCategoryId,
      String currency, String priceType, String level) async {
    isLoading.value = true;

    if (categooryId == null) {
      CustomSnackBar.showCustomErrorToast(message: "Please select a category");
      isLoading.value = false;
      return;
    }

    try {
      final isCustomer = await userService.isUser();

      final token = isCustomer == true
          ? await userService.getToken()
          : await userService.getTokenProvider();

      if (token == null) {
        CustomSnackBar.showCustomErrorToast(message: "Authentication required");
        isLoading.value = false;
        return;
      }

      var uri = Uri.parse(Constants.customerCreateAuction);
      var request = http.MultipartRequest('POST', uri);

      // Add headers with token from UserService
      request.headers.addAll({
        'Authorization': token, // Token already includes "Bearer "
        'Accept': 'application/json',
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

      // Add text fields
      request.fields.addAll({
        "title": name.value.text.trim(),
        "description": description.value.text.trim(),
        "price": price.value.text.trim(),
        // "location_name": address.value.text,
        // "latitude": lat ?? 0.toString(),
        // "longitude": lng ?? 0.toString(),
        "priceType": priceType.capitalize ?? "Fixed",
        // Capitalize first letter
        "currency": currency.toUpperCase(),
        // Convert to uppercase
        "status": "Active",
        "level": level,
        "postType": "Auction",
        "deadline": formatSelectedDate(),
        // "skills": jsonEncode(selectedTags.toList()),
        // "commission": "0",
        // "is_featured": "0",
        "category_id": categooryId?.toString() ?? "0",
        "subCategory_id": subCategoryId.toString(),
      });

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
        customeAddAuction.value =
            CustomerAddAuctionModel.fromJson(jsonResponse);

        resetAllFields();

        CustomSnackBar.showCustomToast(
            message: jsonResponse['message'] ?? 'Auction created successfully',
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
            customeAddAuction.value =
                CustomerAddAuctionModel.fromJson(jsonResponse);

            CustomSnackBar.showCustomToast(
                message:
                    jsonResponse['message'] ?? 'Auction created successfully',
                color: LightThemeColors.progressIndicatorColor);

            Get.to(() => CustomerNavBarView(1));
          }
        }
      } else {
        throw Exception('Failed to create auction: ${response.statusCode}');
      }

      isLoading.value = false;
    } catch (e) {
      print('Error creating auction: $e');
      CustomSnackBar.showCustomErrorToast(
          message: 'Error creating auction: ${e.toString()}');
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

// In your CustomerAddAuctionController class, update these variables:
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

  // Method to show date picker
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      // Start from tomorrow
      firstDate: DateTime.now().add(Duration(days: 1)),
      // Can't select today or past
      lastDate: DateTime.now().add(Duration(days: 365)),
      // Up to 1 year ahead
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: LightThemeColors.primaryColor,
              onPrimary: LightThemeColors.whiteColor,
              surface: LightThemeColors.secounderyColor,
              onSurface: LightThemeColors.whiteColor,
            ),
            dialogBackgroundColor: LightThemeColors.secounderyColor,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  // Method to format date for API
  String formatSelectedDate() {
    if (selectedDate.value != null) {
      return "${selectedDate.value!.year}-${selectedDate.value!.month.toString().padLeft(2, '0')}-${selectedDate.value!.day.toString().padLeft(2, '0')} 00:00:00";
    }
    return DateTime.now()
        .add(Duration(days: 1))
        .toString()
        .substring(0, 19); // Default to tomorrow
  }

  void resetAllFields() {
    // Reset text fields
    name.value.clear();
    description.value.clear();
    price.value.clear();
    address.value.clear();
    tagController.value.clear();

    // Reset images
    selectedthumbnail.clear();

    // Reset dropdowns
    categoryyIds.value = "";
    selectedSubCategoryId.value = "";
    selectedCurrency.value = "";
    selectedPriceType.value = "";
    selectedLevelList.value = "";
    selectedDuration.value = "";

    // Reset category and subcategory IDs
    categooryId = null;
    subCategoryId = null;

    // Reset location data
    lat = null;
    lng = null;

    // Reset tags
    selectedTags.clear();
  }

  @override
  void dispose() {
    name.value.clear();
    super.dispose();
  }
}
