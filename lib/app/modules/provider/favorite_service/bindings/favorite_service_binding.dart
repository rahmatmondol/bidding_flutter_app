import 'package:get/get.dart';

import '../controllers/favorite_service_controller.dart';

class FavoriteServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteServiceController>(
      () => FavoriteServiceController(),
    );
  }
}
