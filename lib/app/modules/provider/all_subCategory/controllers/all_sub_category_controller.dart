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
    super.onInit();
    getSubCategories(categoryId);
  }

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
}
