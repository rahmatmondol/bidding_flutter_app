import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_work_people_details/model/get_customer_betting_details_model.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:get/get.dart';

class CustomerWorkPeopleDetailsController extends GetxController {
  Rx<GetBettingListDetailsModel> getBettingListDetailsModel =
      GetBettingListDetailsModel().obs;

  var isLoading = false.obs;

  getCustomerBetListDetails(int id, int betingId) async {
    isLoading.value = true;
    await BaseClient.safeApiCall(
      "${Constants.custommerBettingListDetails}/$id",
      RequestType.get,
      headers: {
        'Authorization':
            'Bearer ${MySharedPref.getToken("token".obs).toString()}',
      },
      queryParameters: {"betting_list": "$betingId"},
      onSuccess: (response) {
        if (response.statusCode == 200) {
          getBettingListDetailsModel.value =
              GetBettingListDetailsModel.fromJson(response.data);
          print(getBettingListDetailsModel.value.data);
        }
        isLoading.value = false;
        update();
      },
    );
  }
}
