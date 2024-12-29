import 'package:get/get.dart';

import '../controllers/customer_work_people_list_controller.dart';

class CustomerWorkPeopleListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerWorkPeopleListController>(
      () => CustomerWorkPeopleListController(),
    );
  }
}
