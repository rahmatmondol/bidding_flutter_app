import 'package:dirham_uae/app/modules/services/models/get_services_models.dart';
import 'package:get/get.dart';

import '../../../../utils/urls.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../services/base_client.dart';

class ServicesController extends GetxController {
  RxBool isGetServiceloading = false.obs;
  RxObjectMixin<GetServiceDataModel> getServiceDataModel =
      GetServiceDataModel().obs;

// **************** Get Customer Info **************
  Future getServiceData() async {
    isGetServiceloading.value = true;

    await BaseClient.safeApiCall(
      headers: {
        'Authorization':
            'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
      },
      Constants.getServiceUrl,
      RequestType.get,
      onSuccess: (response) {
        if (response.statusCode == 200) {
          print("get customer info status code 200");
          getServiceDataModel.value =
              GetServiceDataModel.fromJson(response.data);

          print(getServiceDataModel.value.data!.service![0].address.toString());
        }
        isGetServiceloading.value = false;
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

  final count = 0.obs;

  @override
  void onInit() {
    getServiceData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
