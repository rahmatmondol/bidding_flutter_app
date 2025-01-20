import 'package:dirham_uae/app/modules/services/models/get_services_models.dart';
import 'package:get/get.dart';

import '../../../../utils/urls.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../services/base_client.dart';

class ServicesController extends GetxController {
  RxBool isGetServiceloading = false.obs;
  Rx<GetServiceDataModel> getServiceDataModel = GetServiceDataModel().obs;

  final int subCategoryId = Get.arguments ?? 0;
  RxList<ServiceModel> filteredServices = <ServiceModel>[].obs;

  Future getServiceData() async {
    print('🔍 Starting getServiceData()');
    print('📌 SubCategory ID: $subCategoryId');

    isGetServiceloading.value = true;

    try {
      await BaseClient.safeApiCall(
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
        },
        Constants.getAllServiceUrl,
        RequestType.get,
        onSuccess: (response) {
          print('✅ API Response received');
          print('📊 Response status code: ${response.statusCode}');

          if (response.statusCode == 200) {
            print('🎯 Status code 200 received');
            print('📝 Raw response data: ${response.data}');

            getServiceDataModel.value =
                GetServiceDataModel.fromJson(response.data);
            print('📦 Model parsed successfully');
            print(
                '📊 Total services in response: ${getServiceDataModel.value.data?.length ?? 0}');

            // Filter services by subcategory ID
            if (subCategoryId != 0 && getServiceDataModel.value.data != null) {
              print('🔍 Filtering services for subcategory: $subCategoryId');
              filteredServices.value =
                  getServiceDataModel.value.data!.where((service) {
                print(
                    '👉 Checking service ID: ${service.id}, sub_category_id: ${service.sub_category_id}');
                return service.sub_category_id == subCategoryId;
              }).toList();
              print('✅ Filtered services count: ${filteredServices.length}');
            } else {
              print('📋 Loading all services (no filter)');
              filteredServices.value = getServiceDataModel.value.data ?? [];
              print('✅ Total services loaded: ${filteredServices.length}');
            }
          }
          isGetServiceloading.value = false;
          print('✅ Loading completed');
          update();
        },
        onError: (error) {
          print('❌ Error occurred: ${error.toString()}');
          print('❌ Error response: ${error.response?.data}');
          CustomSnackBar.showCustomErrorToast(
            message: error.response?.data['message']?.toString() ??
                'An error occurred',
          );
          isGetServiceloading.value = false;
        },
      );
    } catch (e) {
      print('💥 Exception caught: $e');
      isGetServiceloading.value = false;
    }
  }

  @override
  void onInit() {
    print('🚀 ServicesController initialized');
    print('📌 Initial subCategoryId: $subCategoryId');
    getServiceData();
    super.onInit();
  }
}
