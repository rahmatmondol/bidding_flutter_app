import 'package:get/get.dart';
import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_service_details/model/customer_service_details.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/constants.dart';

class CustomerServiceDetailsController extends GetxController {
  

 var isLoading= false.obs;

 Rx<CustomerServiceDetailsModel> customerServiceDetailsModel= CustomerServiceDetailsModel().obs;

  getServiceDetails(int id)async{
    isLoading.value=true;
  await BaseClient.safeApiCall(
    "${Constants.ServiceCustomerDetails}/$id", 
    RequestType.get,
   headers: {
        'Authorization':
            'Bearer ${MySharedPref.getToken("token".obs).toString()}',
      },

    onSuccess:  (response) {
      if (response.statusCode==200) {
        customerServiceDetailsModel.value= CustomerServiceDetailsModel.fromJson(response.data);
      }
      isLoading.value=false;
      update();
    },
    );
  }
}
