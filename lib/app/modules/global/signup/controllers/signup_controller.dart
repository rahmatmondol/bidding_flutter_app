import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:get/get.dart';

import '../../customer_tab/views/customertab_view.dart';
import '../../provider_tab/views/provider_tab_view.dart';

class SignupController extends GetxController {
  RxBool isCustomerChecked = true.obs;
  RxBool isProviderChecked = false.obs;
  RxInt currentIndex = 0.obs;

  RxList itemIcons = <String>[
    Img.customerIcon,
    Img.providerIcon,
  ].obs;
  RxList<String> items = [
    "Customer",
    "Provider",
  ].obs;
  RxList tabScreen = [
    CustomertabView(),
    ProviderTabView(),
  ].obs;

  final count = 0.obs;

  @override
  void onInit() {
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
