import 'package:get/get.dart';

import '../../../../../../utils/urls.dart';
import '../../../../../components/custom_snackbar.dart';
import '../../../../../data/user_service/user_service.dart';
import '../../../../../services/base_client.dart';
import '../models/account_info_models.dart';

class CustomerAccountDetailsController extends GetxController {
  final count = 0.obs;
  RxBool isCustomerInfoloading = false.obs;
  Rx<CustomerInfoModel?> customerInfo = Rx<CustomerInfoModel?>(null);
  final UserService _userService = UserService();

  @override
  void onInit() {
    super.onInit();
    print('CustomerAccountDetailsController initialized');
    getCustomerInfo();
  }

  Future<void> getCustomerInfo() async {
    isCustomerInfoloading.value = true;
    update();

    try {
      String? token;
      if (await _userService.isUser()) {
        token = await _userService.getToken();
      } else if (await _userService.isProvider()) {
        token = await _userService.getTokenProvider();
      }

      if (token == null) {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'Error', message: 'Please again login');
      }

      await BaseClient.safeApiCall(
        headers: {
          'Authorization': token,
        },
        Constants.getCustomerInfo,
        RequestType.get,
        onSuccess: (response) {
          print("====================");
          print("Response data of profile.: ${response}");
          print("Success Response Status Code: ${response.statusCode}");
          print("Success Response Data: ${response.data}");
          print("====================");

          if (response.statusCode == 200) {
            customerInfo.value = CustomerInfoModel.fromJson(response.data);
            print("Parsed Customer Info: ${customerInfo.value?.toJson()}");

            update();
          }
        },
        onError: (error) {
          print(error.toString());
          print("Error Type: ${error.runtimeType}");
          print("Error Message: ${error.message}");
          print("Error Response: ${error.response?.data}");
          print("Error Status Code: ${error.response?.statusCode}");
          CustomSnackBar.showCustomErrorToast(
            message: error.response?.data['message']?.toString() ??
                'An error occurred',
          );
        },
      );
    } finally {
      isCustomerInfoloading.value = false;
      update();
    }
  }
}
