import 'dart:async';

import 'package:dirham_uae/app/data/local/my_shared_pref.dart';
import 'package:dirham_uae/app/modules/customer/customer_home/model/get_customer_service_model.dart';
import 'package:dirham_uae/app/services/base_client.dart';
import 'package:dirham_uae/utils/urls.dart';
import 'package:get/get.dart';

// class CustomerHomeController extends GetxController {
//   RxObjectMixin<GetCustomerServiceModel> getCustomerModel =
//       GetCustomerServiceModel().obs;
//   var isLoading = false.obs;
//
//   final RxInt currentBannerIndex = 0.obs;
//   final bannerImages = [
//     "https://media.istockphoto.com/id/1219401440/photo/banner-of-automobile-mechanic-man-and-team-checking-car-damage-broken-part-condition.jpg?s=612x612&w=0&k=20&c=-vaK4Pr81HOfB0cYT4uXrOnPSQ06mS2Pjq_LN9vDqfc=",
//     "https://thumbs.wbm.im/pw/medium/d7e94fa5111538f1af6d615a089ce857.jpg",
//     "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/auto-repair-services-facebook-shared-post-design-template-44887c528a56f3c8e90a615f3a6ae614_screen.jpg?ts=1662714951",
//     // Add more banner URLs as needed
//   ];
//
//   @override
//   void onInit() {
//     super.onInit();
//     startBannerTimer();
//     getCustomeService();
//   }
//
//   void startBannerTimer() {
//     Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (currentBannerIndex.value < bannerImages.length - 1) {
//         currentBannerIndex.value++;
//       } else {
//         currentBannerIndex.value = 0;
//       }
//     });
//   }
//
//   getCustomeService() async {
//     isLoading.value = true;
//     await BaseClient.safeApiCall(
//       Constants.getServiceCustomer,
//       RequestType.get,
//       headers: {
//         'Authorization':
//             'Bearer ${MySharedPref.getToken("token".obs).toString()}',
//       },
//       onSuccess: (response) {
//         if (response.statusCode == 200) {
//           getCustomerModel.value =
//               GetCustomerServiceModel.fromJson(response.data);
//           print(getCustomerModel.value.data!.data);
//         }
//         isLoading.value = false;
//         update();
//       },
//       onError: (error) {
//         update();
//       },
//     );
//   }
// }

class CustomerHomeController extends GetxController {
  Rx<GetCustomerServiceModel> getCustomerModel = GetCustomerServiceModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCustomeService();
  }

  Future<void> getCustomeService() async {
    isLoading.value = true;
    try {
      final result = await BaseClient.safeApiCall(
        Constants.getServiceCustomer,
        RequestType.get,
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getToken("token".obs).toString()}',
        },
        onSuccess: (response) {
          if (response.statusCode == 200) {
            getCustomerModel.value =
                GetCustomerServiceModel.fromJson(response.data);
            print(
                "Data loaded: ${getCustomerModel.value.data?.length} services found");
          } else {
            print("Error loading data: ${response.statusCode}");
          }
        },
      );
    } catch (e) {
      print("Error in getCustomeService: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
