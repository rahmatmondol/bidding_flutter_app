import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_account_details/models/customer_info_models.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:get/get.dart';

class CustomerAccountDetailsController extends GetxController {
  final count = 0.obs;
  RxBool isCustomerInfoloading = false.obs;
  RxObjectMixin<GetCustomerInfoModel> getCutomerInfoModel =
      GetCustomerInfoModel().obs;

// **************** Get Customer Info **************
  Future getCustomerInfo() async {
    isCustomerInfoloading.value = true;

    await BaseClient.safeApiCall(
      headers: {
        'Authorization':
            'Bearer ${MySharedPref.getToken("token".obs).toString()}',
      },
      Constants.getCustomerInfo,
      RequestType.get,
      onSuccess: (response) {
        // if (response.staztusCode == 200) {
        //   print("get customer info status code 200");
        //   getCutomerInfoModel.value =
        //       GetCustomerInfoModel.fromJson(response.data);

        //   print(getCutomerInfoModel.value.data);
        //   // CustomSnackBar.showCustomToast(
        //   //     message: response.data['message'].toString());
        // }
        isCustomerInfoloading.value = false;
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

// **************** Get Customer Info **************
  RxBool isCustomerInfoUpdateloading = false.obs;

  Future customerInfoUpdate() async {
    isCustomerInfoUpdateloading.value = true;

    await BaseClient.safeApiCall(
      data: {},
      headers: {
        'Authorization':
            'Bearer ${MySharedPref.getToken("token".obs).toString()}',
      },
      Constants.customerInfoUpdateUrl,
      RequestType.post,
      onSuccess: (response) {
        // if (response.statusCode == 200) {
        //   print(
        //       "get customer info update status code ${response.data["message"]}");
        //   getCutomerInfoModel.value =
        //       GetCustomerInfoModel.fromJson(response.data);

        //   print(getCutomerInfoModel.value.data);
        //   // CustomSnackBar.showCustomToast(
        //   //     message: response.data['message'].toString());
        // }
        isCustomerInfoUpdateloading.value = false;
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
  void onInit() {
    getCustomerInfo();
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
