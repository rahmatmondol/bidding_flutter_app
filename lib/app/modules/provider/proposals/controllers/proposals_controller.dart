// controllers/proposals_controller.dart

import 'package:get/get.dart';

import '../../../../../utils/urls.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../data/user_service/user_service.dart';
import '../../../../services/base_client.dart';
import '../model/proposal_model.dart';

class ProposalsController extends GetxController {
  final RxList<Bid> bids = <Bid>[].obs;
  final RxBool isLoading = false.obs;
  final UserService userService = UserService();

  @override
  void onInit() {
    super.onInit();
    fetchBids();
  }

  Future<void> fetchBids() async {
    isLoading.value = true;

    try {
      final token = await userService.getTokenProvider();

      await BaseClient.safeApiCall(
        Constants.getBidding,
        RequestType.get,
        headers: {
          'Authorization': token ?? '',
          'Accept': 'application/json',
        },
        onSuccess: (response) {
          if (response.statusCode == 200 && response.data != null) {
            final bidData = response.data['data'] as List;
            bids.value = bidData.map((item) => Bid.fromJson(item)).toList();
          }
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorToast(
            message: error.response?.data['message']?.toString() ??
                'Error fetching bids',
          );
        },
      );
    } catch (e) {
      CustomSnackBar.showCustomErrorToast(
        message: 'Error fetching bids',
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
