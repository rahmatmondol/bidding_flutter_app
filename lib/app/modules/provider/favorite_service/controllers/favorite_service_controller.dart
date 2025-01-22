import 'package:get/get.dart';

import '../../../../../utils/urls.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../data/user_service/user_service.dart';
import '../../../../services/base_client.dart';
import '../model/fevorite_model.dart';

class FavoriteServiceController extends GetxController {
  final RxMap<String, bool> wishlistedItems = <String, bool>{}.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWishlistedItems();
  }

  Future<void> fetchWishlistedItems() async {
    try {
      isLoading.value = true;

      await BaseClient.safeApiCall(
        Constants.getWishList,
        RequestType.get,
        onSuccess: (response) {
          if (response.statusCode == 200 && response.data != null) {
            final List<dynamic> items = response.data['data'] ?? [];
            wishlistedItems.clear();
            for (var item in items) {
              wishlistedItems[item['service_id'].toString()] = true;
            }
          }
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorToast(
            message: error.response?.data['message']?.toString() ??
                'Error fetching wishlist',
          );
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  final UserService userService = UserService();

  Future<void> toggleWishlist(String serviceId, int providerId) async {
    try {
      isLoading.value = true;
      final token = await userService.getTokenProvider();
      print('Using token: $token'); // Debug print

      if (token == null) {
        print('No token found');
        CustomSnackBar.showCustomErrorToast(
          message: 'Please login to continue',
        );
        return;
      }

      // Toggle state immediately for better UX
      wishlistedItems.value = {
        ...wishlistedItems,
        serviceId: !(wishlistedItems[serviceId] ?? false)
      };
      update(); // Force UI update

      print('Current wishlist state: ${wishlistedItems[serviceId]}');

      await BaseClient.safeApiCall(
        Constants.createWishList,
        RequestType.post,
        headers: {
          'Authorization': token, // Your UserService already adds 'Bearer'
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        data: {
          'service_id': serviceId,
          'provider_id': providerId,
        },
        onSuccess: (response) {
          print('API Response: ${response.data}');
          if (response.statusCode == 200) {
            final wishlistResponse = FavoriteModel.fromJson(response.data);
            CustomSnackBar.showCustomToast(
              message: wishlistResponse.message ?? 'Updated wishlist',
            );
          }
        },
        onError: (error) {
          print('Error in wishlist toggle: ${error.response?.data}');
          // Revert the state on error
          wishlistedItems.value = {
            ...wishlistedItems,
            serviceId: !(wishlistedItems[serviceId] ?? false)
          };
          update(); // Force UI update

          CustomSnackBar.showCustomErrorToast(
            message: error.response?.data['message']?.toString() ??
                'Error updating wishlist',
          );
        },
      );
    } catch (e) {
      print('Exception in toggleWishlist: $e');
      // Revert the state on error
      wishlistedItems.value = {
        ...wishlistedItems,
        serviceId: !(wishlistedItems[serviceId] ?? false)
      };
      update(); // Force UI update

      CustomSnackBar.showCustomErrorToast(
        message: 'Error updating wishlist',
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

// Future<void> toggleWishlist(String serviceId, int providerId) async {
//   try {
//     isLoading.value = true;
//
//     // Toggle local state first for immediate feedback
//     final bool currentState = wishlistedItems[serviceId] ?? false;
//     wishlistedItems[serviceId] = !currentState;
//
//     await BaseClient.safeApiCall(
//       // currentState ? Constants.removeWishList : Constants.createWishList,
//       Constants.createWishList,
//       RequestType.post,
//       data: {
//         'service_id': serviceId,
//         'provider_id': providerId,
//       },
//       onSuccess: (response) {
//         if (response.statusCode == 200) {
//           final wishlistResponse = FavoriteModel.fromJson(response.data);
//           CustomSnackBar.showCustomToast(
//             message: wishlistResponse.message ??
//                 (currentState
//                     ? 'Removed from wishlist'
//                     : 'Added to wishlist'),
//           );
//         }
//       },
//       onError: (error) {
//         // Revert local state on error
//         wishlistedItems[serviceId] = currentState;
//         CustomSnackBar.showCustomErrorToast(
//           message: error.response?.data['message']?.toString() ??
//               'Error updating wishlist',
//         );
//       },
//     );
//   } finally {
//     isLoading.value = false;
//     update();
//   }
// }
}
