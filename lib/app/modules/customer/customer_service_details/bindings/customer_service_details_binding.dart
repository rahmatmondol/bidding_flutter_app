import 'package:get/get.dart';

import '../controllers/customer_service_details_controller.dart';

class CustomerServiceDetailsBinding extends Bindings {
  final int serviceId;

  CustomerServiceDetailsBinding(this.serviceId);

  @override
  void dependencies() {
    Get.lazyPut<CustomerServiceDetailsController>(
      () => CustomerServiceDetailsController(serviceId),
      fenix: false, // Don't reuse the controller
      tag: serviceId.toString(), // Add unique tag
    );
  }
}
