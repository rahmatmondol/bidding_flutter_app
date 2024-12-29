import 'package:get/get.dart';
import 'package:dirham_uae/app/modules/customer/customer_chat/controllers/customer_chat_controller.dart';


class CustomerChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerChatController>(
      () => CustomerChatController(),
    );
  }
}
