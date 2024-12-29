import 'package:get/get.dart';

import '../controllers/all_sub_category_controller.dart';

class AllSubCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllSubCategoryController>(
      () => AllSubCategoryController(),
    );
  }
}
