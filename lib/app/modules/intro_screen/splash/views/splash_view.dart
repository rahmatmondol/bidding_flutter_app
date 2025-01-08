import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SplashController controller = Get.put(SplashController());
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: Center(
          child: Image.asset(
            Img.appLogo,
            scale: 3.6,
          ),
        ),
      ),
    );
  }
}
