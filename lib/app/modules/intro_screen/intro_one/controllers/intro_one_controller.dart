import 'package:get/get.dart';

class IntroOneController extends GetxController {
  final count = 0.obs;

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
