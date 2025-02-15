import 'package:get/get.dart';

import '../../home/models/provider_service_model.dart';

// DescriptionController.dart
class DescriptionController extends GetxController {
  late final Service data;
  RxList<String> images = <String>[].obs;
  RxInt currenIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Service) {
      data = Get.arguments;
      setImages(data);
    }
  }

  void setImages(Service data) {
    // Wrap in Future.microtask to avoid build-time state changes
    Future.microtask(() {
      if (data.images != null && data.images!.isNotEmpty) {
        // Clear existing images first
        images.clear();
        // Add all valid image paths
        images.addAll(
          data.images!
              .where((image) => image.path != null && image.path!.isNotEmpty)
              .map((image) => image.path!)
              .toList(),
        );
        // Reset current index
        currenIndex.value = 0;
        print('Set ${images.length} images: ${images.value}');
      }
    });
  }
}
