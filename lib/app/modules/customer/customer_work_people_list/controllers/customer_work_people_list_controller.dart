import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_work_people_list/model/get_betting_list_model.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/constants.dart';

class CustomerWorkPeopleListController extends GetxController {

  Rx<GetBettingListModel> getBettingListModel = GetBettingListModel().obs;
  var isLoading = false.obs;

  getBettingList(int serviceId) async {
    isLoading.value = true;
    await BaseClient.safeApiCall(
      Constants.custommerBettingList,
      RequestType.get,
      queryParameters: {"service_id": serviceId},
      headers: {
        'Authorization':
            'Bearer ${MySharedPref.getToken("token".obs).toString()}',
      },

      onSuccess: (response) {
        if (response.statusCode == 201) {
          getBettingListModel.value =
              GetBettingListModel.fromJson(response.data);
          print(getBettingListModel.value.data!.betting);
        }
        isLoading.value = false;
        update();
      },
    );
  }

  bettingBooking(int id) async {
    await BaseClient.safeApiCall(
      "${Constants.acceptBooking}/$id",
      RequestType.post,
      headers: {
        'Authorization':
            'Bearer ${MySharedPref.getToken("token".obs).toString()}',
      },
      onSuccess: (response) {
        if (response.statusCode == 200) {
          CustomSnackBar.showCustomToast(message: response.data["message"]);
        }
      },
      onError: (error) {
        if (error.response!.statusCode == 404) {
          CustomSnackBar.showCustomErrorToast(
              message: error.response!.data["message"]);
        } else if (error.response!.statusCode == 400) {
          CustomSnackBar.showCustomErrorToast(
              message: error.response!.data["message"]);
        }
      },
    );
  }
}
