import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/modules/provider/account_details/models/get_provider_info_model.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:get/get.dart';

import '../../../../data/local/my_shared_pref.dart';

class AccountDetailsController extends GetxController {
  RxBool isProviderInfoloading = false.obs;
  RxObjectMixin<GetProviderInfoModel> getProviderInfoModel =
      GetProviderInfoModel().obs;

// **************** Get Provider Info **************
  Future getProviderInfo() async {
    isProviderInfoloading.value = true;

    await BaseClient.safeApiCall(
      headers: {
        'Authorization':
            'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
      },
      Constants.getProviderInfo,
      RequestType.get,
      onSuccess: (response) {
        if (response.statusCode == 200) {
          print("get customer info status code 200");
          getProviderInfoModel.value =
              GetProviderInfoModel.fromJson(response.data);

          print(
              "hellooooo ::: ${getProviderInfoModel.value.data!.provider!.name.toString()}");
          // CustomSnackBar.showCustomToast(
          //     message: response.data['message'].toString());
        }
        isProviderInfoloading.value = false;
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
    getProviderInfo();
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
