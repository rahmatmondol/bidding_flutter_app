import 'dart:async';

import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_home/model/get_customer_service_model.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
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
}
