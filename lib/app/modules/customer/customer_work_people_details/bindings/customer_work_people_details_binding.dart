import 'package:get/get.dart';

import '../controllers/customer_work_people_details_controller.dart';

class CustomerWorkPeopleDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerWorkPeopleDetailsController>(
      () => CustomerWorkPeopleDetailsController(),
    );
  }
}
