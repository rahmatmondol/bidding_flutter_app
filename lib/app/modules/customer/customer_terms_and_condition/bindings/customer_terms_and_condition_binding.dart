import 'package:get/get.dart';

import '../controllers/customer_terms_and_condition_controller.dart';

class CustomerTermsAndConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerTermsAndConditionController>(
      () => CustomerTermsAndConditionController(),
    );
  }
}
