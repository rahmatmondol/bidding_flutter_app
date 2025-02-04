import 'package:get/get.dart';

import '../controllers/customer_privacy_and_policy_controller.dart';

class PrivacyAndPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyAndPolicyController>(
      () => PrivacyAndPolicyController(),
    );
  }
}
