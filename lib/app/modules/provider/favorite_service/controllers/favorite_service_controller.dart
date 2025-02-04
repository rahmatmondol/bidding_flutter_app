import 'package:get/get.dart';

import '../../../../../utils/urls.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../data/user_service/user_service.dart';
import '../../../../services/base_client.dart';
import '../model/fevorite_model.dart';

class FavoriteServiceController extends GetxController {
  final RxMap<String, bool> wishlistedItems = <String, bool>{}.obs;
  final RxBool isLoading = false.obs;
  final RxList<WishlistItem> favoriteServices = <WishlistItem>[].obs;
  RxList<String> images = <String>[].obs;
  RxInt currenIndex = 0.obs;

  final UserService userService = UserService();

  @override
  void onInit() {
    print('FavoriteServiceController: onInit called');
    super.onInit();
    fetchWishlistedItems();
  }

  void setImages(Service data) {
    if (data.images != null && data.images!.isNotEmpty) {
      // Clear existing images first
      images.clear();
      // Add all valid image paths
      images.addAll(
        data.images!
            .where((image) => image.path != null && image.path!.isNotEmpty)
            .map((image) => image.path!)
            .toList(),
      );
      // Reset current index
      currenIndex.value = 0;
      print(
          'FavoriteServiceController: Set ${images.length} images: ${images.value}');
    }
  }

  Future<List<WishlistItem>> fetchWishlistedItems() async {
    print('FavoriteServiceController: fetchWishlistedItems started');
    try {
      isLoading.value = true;
      final token = await userService.getTokenProvider();
      print('FavoriteServiceController: Token received: ${token != null}');

      if (token == null) {
        CustomSnackBar.showCustomErrorToast(
            message: 'Please login to continue');
        return [];
      }

      final response = await BaseClient.safeApiCall(
        Constants.getWishList,
        RequestType.get,
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
        },
        onSuccess: (response) {
          if (response.statusCode == 200 && response.data != null) {
            print('FavoriteServiceController: API response received');
            print('FavoriteServiceController: Response data: ${response.data}');

            try {
              final favoriteModel = FavoriteModel.fromJson(response.data);
              favoriteServices.value = favoriteModel.data ?? [];

              print(
                  'FavoriteServiceController: Parsed ${favoriteServices.length} items');

              // Update wishlistedItems map
              wishlistedItems.clear();
              for (var item in favoriteServices) {
                if (item.serviceId != null) {
                  wishlistedItems[item.serviceId.toString()] = true;
                  print(
                      'FavoriteServiceController: Added item ${item.serviceId} to wishlist');
                }
              }
            } catch (e) {
              print('FavoriteServiceController: Error parsing response: $e');
              CustomSnackBar.showCustomErrorToast(
                message: 'Error processing response data',
              );
            }
          }
        },
        onError: (error) {
          print('FavoriteServiceController: API error: ${error.toString()}');
          CustomSnackBar.showCustomErrorToast(
            message: error.response?.data['message']?.toString() ??
                'Error fetching wishlist',
          );
        },
      );

      return favoriteServices;
    } catch (e) {
      print('FavoriteServiceController: Exception caught: ${e.toString()}');
      return [];
    } finally {
      isLoading.value = false;
      print(
          'FavoriteServiceController: fetchWishlistedItems completed. Items count: ${favoriteServices.length}');
    }
  }

  Future<void> createWishlist(String serviceId, int providerId) async {
    print(
        'FavoriteServiceController: createWishlist called for service $serviceId');
    try {
      final token = await userService.getTokenProvider();

      if (token == null) {
        CustomSnackBar.showCustomErrorToast(
            message: 'Please login to continue');
        return;
      }

      final currentState = wishlistedItems[serviceId] ?? false;
      wishlistedItems[serviceId] = !currentState;

      await BaseClient.safeApiCall(
        Constants.createWishList,
        RequestType.post,
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        data: {
          'service_id': serviceId,
          'provider_id': providerId,
        },
        onSuccess: (response) {
          if (response.statusCode == 200) {
            print(
                'FavoriteServiceController createWishlist: Toggle successful');
            CustomSnackBar.showCustomToast(
              message: response.data['message'] ?? 'Updated wishlist',
            );
            fetchWishlistedItems();
          }
        },
        onError: (error) {
          print(
              'FavoriteServiceController createWishlist: Toggle error: ${error.toString()}');
          wishlistedItems[serviceId] = currentState;
          CustomSnackBar.showCustomErrorToast(
            message: error.response?.data['message']?.toString() ??
                'Error updating wishlist',
          );
        },
      );
    } catch (e) {
      print(
          'FavoriteServiceController createWishlist: Toggle exception: ${e.toString()}');
      CustomSnackBar.showCustomErrorToast(message: 'Error updating wishlist');
    }
  }

  Future<void> deleteWishlist(int wishlistId, String serviceId) async {
    print(
        'FavoriteServiceController: deleteWishlist called for wishlist $wishlistId');
    try {
      final token = await userService.getTokenProvider();

      if (token == null) {
        CustomSnackBar.showCustomErrorToast(
            message: 'Please login to continue');
        return;
      }

      // Store current state before deletion
      final currentState = wishlistedItems[serviceId] ?? false;

      await BaseClient.safeApiCall(
        Constants.deleteWishList(wishlistId),
        RequestType.delete, // Use DELETE method
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
        },
        onSuccess: (response) {
          if (response.statusCode == 200) {
            print(
                'FavoriteServiceController: Delete successful for wishlist $wishlistId');

            // Update local state
            wishlistedItems[serviceId] = false;

            // Show success message
            CustomSnackBar.showCustomToast(
              message: response.data['message'] ?? 'Removed from wishlist',
            );

            // Refresh the wishlist
            fetchWishlistedItems();
          }
        },
        onError: (error) {
          print('FavoriteServiceController: Delete error: ${error.toString()}');

          // Revert the state on error
          wishlistedItems[serviceId] = currentState;

          CustomSnackBar.showCustomErrorToast(
            message: error.response?.data['message']?.toString() ??
                'Error removing from wishlist',
          );
        },
      );
    } catch (e) {
      print('FavoriteServiceController: Delete exception: ${e.toString()}');
      CustomSnackBar.showCustomErrorToast(
          message: 'Error removing from wishlist');
    }
  }
}
