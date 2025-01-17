import 'package:dirham_uae/app/modules/services/models/get_services_models.dart';
import 'package:get/get.dart';

class ServiceDetailsController extends GetxController {
  RxList<String> images = <String>[].obs;
  RxInt currentIndex = 0.obs;

  void setImages(ServiceModel data) {
    images.clear();
    if (data.images != null) {
      for (var image in data.images!) {
        if (image.path != null) {
          images.add(image.path!);
        }
      }
    }
  }
}
