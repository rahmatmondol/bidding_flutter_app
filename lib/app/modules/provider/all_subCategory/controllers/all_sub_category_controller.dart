import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:get/get.dart';

import '../../../../components/custom_snackbar.dart';
import '../../../customer/customer_add_service/model/sub_category_model.dart';

class AllSubCategoryController extends GetxController {
  final int categoryId = Get.arguments;
  RxBool isSubCategoryLoading = false.obs;
  Rx<SubCategoryModel> subCategoryModel = SubCategoryModel().obs;
  RxString selectedSubCategoryId = "".obs;
  int? subCategoryId;

  @override
  void onInit() {
    print('🚀 AllSubCategoryController initialized');
    print('📌 Category ID received: $categoryId');
    super.onInit();
    getSubCategories(categoryId);
  }

  Future getSubCategories(int categoryId) async {
    print('🔍 Getting subcategories for category ID: $categoryId');
    isSubCategoryLoading.value = true;
    selectedSubCategoryId.value = "";

    await BaseClient.safeApiCall(
      Constants.getSubCategoryByID(categoryId),
      RequestType.get,
      onSuccess: (response) {
        print('✅ Subcategory API Response received');
        print('📊 Response status code: ${response.statusCode}');

        if (response.statusCode == 200) {
          print('🎯 Status code 200 received');
          print('📝 Raw subcategory response data: ${response.data}');

          subCategoryModel.value = SubCategoryModel.fromJson(response.data);
          print('📦 Subcategory Model parsed successfully');
          print(
              '📊 Total subcategories: ${subCategoryModel.value.data?.length ?? 0}');

          // Print all subcategory IDs and names
          subCategoryModel.value.data?.forEach((subcat) {
            print('🏷️ Subcategory - ID: ${subcat.id}, Name: ${subcat.name}');
          });
        }
        isSubCategoryLoading.value = false;
        update();
      },
      onError: (error) {
        print('❌ Error getting subcategories: ${error.toString()}');
        print('❌ Error response: ${error.response?.data}');
        CustomSnackBar.showCustomErrorToast(
          message: error.response?.data['message']?.toString() ??
              'An error occurred',
        );
        isSubCategoryLoading.value = false;
      },
    );
  }
}
