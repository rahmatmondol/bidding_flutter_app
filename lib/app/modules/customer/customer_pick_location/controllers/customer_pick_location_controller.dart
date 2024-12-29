import 'package:get/get.dart';

class CustomerPickLocationController extends GetxController {

    RxList<String> location = [
    "Burj Khalifa",
    "Deira",
    "Dubai Mall",
    "Jebel Ali",
    "Abu Dhabi",
    "Sharjah",
  ].obs;

  final RxString selectedZoon = RxString("Burj Khalifa");

  void updateSelectedValue(String newValue) {
    selectedZoon.value = newValue;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
