import 'package:get/get.dart';

import '../../../../../utils/urls.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../services/base_client.dart';
import '../models/customer_info_models.dart';

class CustomerAccountDetailsController extends GetxController {
  final count = 0.obs;
  RxBool isCustomerInfoloading = false.obs;
  Rx<CustomerInfoModel?> customerInfo = Rx<CustomerInfoModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getCustomerInfo();
  }

  Future<void> getCustomerInfo() async {
    isCustomerInfoloading.value = true;
    update();

    try {
      await BaseClient.safeApiCall(
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getToken("token".obs).toString()}',
        },
        Constants.getCustomerInfo,
        RequestType.get,
        onSuccess: (response) {
          if (response.statusCode == 200) {
            customerInfo.value = CustomerInfoModel.fromJson(response.data);
            update();
          }
        },
        onError: (error) {
          print(error.toString());
          print("Full error response: ${error.response}");
          print("Error data: ${error.response?.data}");
          CustomSnackBar.showCustomErrorToast(
            message: error.response?.data['message']?.toString() ??
                'An error occurred',
          );
        },
      );
    } finally {
      isCustomerInfoloading.value = false;
    }
  }
}
