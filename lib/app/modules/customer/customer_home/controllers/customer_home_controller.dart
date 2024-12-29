import 'package:get/get.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_home/model/get_customer_service_model.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/constants.dart';

class CustomerHomeController extends GetxController {
  RxObjectMixin<GetCustomerServiceModel> getCustomerModel =GetCustomerServiceModel().obs;
  var isLoading = false.obs;

  getCustomeService() async {
    isLoading.value = true;
    await BaseClient.safeApiCall(
      Constants.getServiceCustomer,
      RequestType.get,
      headers: {
        'Authorization':
            'Bearer ${MySharedPref.getToken("token".obs).toString()}',
      },

      onSuccess: (response) {
        if (response.statusCode == 200) {
          getCustomerModel.value = GetCustomerServiceModel.fromJson(response.data);
          print(getCustomerModel.value.data!.data);
        }
        isLoading.value = false;
        update();
      },
      onError: (error) {
        update();
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    getCustomeService();
  }
}
