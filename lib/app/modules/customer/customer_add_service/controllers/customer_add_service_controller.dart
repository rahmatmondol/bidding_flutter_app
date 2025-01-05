// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, unnecessary_brace_in_string_interps, unused_local_variable

import 'package:dio/dio.dart' as diox;
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_add_service/model/customer_add_service_model.dart';
import 'package:dirham_uae/app/modules/customer/customer_payment/location_service/location_service.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../../global/customer_tab/model/category-model.dart';
import '../../customer_nav_bar/views/customer_nav_bar_view.dart';

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

  final selectedCategory = ''.obs;

  RxList<String> currency = [
    "aed",
    "usd",
  ].obs;

  var selectedCurrency = ''.obs;

  void updateCurrency(String newValue) {
    selectedCurrency.value = newValue;
  }

  final priceTypeList = [
    "fixed",
    "negotiable",
  ].obs;

  var selectedPriceType = ''.obs;

  void updatePriceType(String newValue) {
    selectedPriceType.value = newValue;
  }

  final levelList = [
    "entry",
    "intermediate",
    "expert",
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
    fetchTags();
    getCategoory();
  }

  void updateLevel(String newValue) {
    selectedLevelList.value = newValue;
  }

  customerCreateService(
      int categoryId, String currency, String priceType, String level) async {
    lat = myBox.get("lat");
    lng = myBox.get("lng");

    var currentAddress;
    currentAddress = myBox.get("address3");

    // String htmlText = await description.value.getText();

    isLoading.value = true;
    if (selectedthumbnail.value.isEmpty ||
        selectedthumbnail.any((element) => element == null)) {
      CustomSnackBar.showCustomErrorToast(
          message: "Please Select feature image");
    } else {
      List<String> thumbnailPaths =
          selectedthumbnail.map((file) => file!.path).toList();
      String tag = ListTags.join(", ");

      try {
        print(' thumbnail path${thumbnailPaths}');

        diox.FormData data = diox.FormData.fromMap({
          "title": name.value.text.trim(),
          "images[]": [
            for (String path in thumbnailPaths)
              await diox.MultipartFile.fromFile(path,
                  filename: path.split('/').last,
                  contentType: new MediaType("image", "jpeg")),
          ],
          "description": description,
          "price": price.value.text.trim(),
          "priceType": '$priceType',
          "currency": '$currency',
          "location": "lohagara", // need change
          "latitude": "165165", // need change
          "longitude": "455162165", // need change
          "postType": "Auction",
          "category_id": '$categooryId',
          "skills": null,
          "skills_ids": selectedTags.join(', '),
          "level": '$level',
          "address": currentAddress, // this is from hive

          "sub_category_id": 2,

          // location_name
          // subCategory_id
          // postType
        });

        await BaseClient.safeApiCall(
          data: data,
          headers: {
            'Authorization':
                'Bearer ${MySharedPref.getToken("token".obs).toString()}',
          },
          Constants.customerCreateService,
          RequestType.post,
          onSuccess: (response) {
            if (response.statusCode == 200) {
              print("Data response ${response.data}");
              customeAddService.value =
                  CustomerAddServiceModel.fromJson(response.data);
              print(customeAddService.value.data!.service);
              CustomSnackBar.showCustomToast(
                  message: response.data['message'],
                  color: LightThemeColors.progressIndicatorColor);
              Get.to(() => CustomerNavBarView(1));
            }
            isLoading.value = false;
            update();
          },
          onError: (error) {
            if (error.statusCode == 404) {
              String errorMessage = "";

              if (error.response!.data['data']['message'] != null) {
                errorMessage +=
                    error.response!.data['data']['message'][0] + "\n";
              }
            }
            update();
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  // For storing API tags
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
  Future<void> fetchTags() async {
    try {
      // Replace with your actual API call
      await BaseClient.safeApiCall(
        Constants.getCategogy,
        RequestType.get,
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getToken("token".obs).toString()}',
        },
        onSuccess: (response) {
          if (response.statusCode == 200) {
            apiTags.value = List<String>.from(response.data['data']);
          }
        },
        onError: (error) {
          print('Error fetching tags: $error');
        },
      );
    } catch (e) {
      print('Exception fetching tags: $e');
    }
  }

  RxBool isCategoryLoading = false.obs;
  RxObjectMixin<CCatgoryModel> categoryModel = CCatgoryModel().obs;
  RxString categoryyIds = "".obs;

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

  @override
  void dispose() {
    name.value.clear();
    super.dispose();
  }
}
