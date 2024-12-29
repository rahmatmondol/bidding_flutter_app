import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/modules/provider/home/models/provider_service_model.dart';
import 'package:dirham_uae/app/modules/provider/home/models/get_categories_model.dart';

import '../../../../../utils/constants.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../services/base_client.dart';

class HomeController extends GetxController {
  final selectedCategory = ''.obs;

  final count = 0.obs;

  RxBool isGetCategoriesloading = false.obs;
  RxObjectMixin<GetCategoriesModel> getCategoriesDataModel =
      GetCategoriesModel().obs;
// **************** Get Categories Info APi**************
  Future getCategoriesData() async {
    isGetCategoriesloading.value = true;

    await BaseClient.safeApiCall(
      Constants.getCategoriesUrl,
      RequestType.get,

      onSuccess: (response) {
        if (response.statusCode == 200) {
          print("get customer info status code 200");
          getCategoriesDataModel.value =
              GetCategoriesModel.fromJson(response.data);

          print(
              getCategoriesDataModel.value.data!.category![0].name.toString());
        }
        isGetCategoriesloading.value = false;
        update();
      },
      onError: (error) {
        print(error.toString());
        CustomSnackBar.showCustomErrorToast(
          message: error.response!.data['message'].toString(),
        );
        update();
      },
    );
  }

  RxObjectMixin<Providerservicemodel> getProviderServiceModel =Providerservicemodel().obs;

  Future getServiceProvider() async {
    await BaseClient.safeApiCall(
      Constants.getServiceUrl,
      RequestType.get,
      headers: {
        'Authorization':
        'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
      },
      onSuccess: (response) {
        if (response.statusCode == 200) {
          print("get customer info status code 200");
          getProviderServiceModel.value =
              Providerservicemodel.fromJson(response.data);
        }
        update();
      },
      onError: (error) {
        print(error.toString());
        CustomSnackBar.showCustomErrorToast(
          message: error.response!.data['message'].toString(),
        );
        update();
      },
    );
  }

  @override
  void onInit() {
    getCategoriesData();
    getServiceProvider();
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
