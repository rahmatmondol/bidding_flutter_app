import 'package:get/get.dart';

import '../../home/models/provider_service_model.dart';

// DescriptionController.dart
class DescriptionController extends GetxController {
  RxList<String> images = <String>[].obs;
  RxInt currenIndex = 0.obs;

  void setImages(Service data) {
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
  }
}
