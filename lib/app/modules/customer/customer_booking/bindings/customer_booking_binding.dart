import 'package:get/get.dart';
import 'package:dirham_uae/app/modules/customer/customer_booking/controllers/customer_booking_controller.dart';

class CustomerBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerBookingController>(
      () => CustomerBookingController(),
    );
  }
}
