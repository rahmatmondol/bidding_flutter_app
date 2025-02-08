import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/customer_nav_bar_controller.dart';

class CustomerNavBarView extends GetView<CustomerNavBarController> {
  final int initialindex;

  const CustomerNavBarView(this.initialindex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final CustomerNavBarController controller =
        Get.put(CustomerNavBarController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // extendBody: true,
      body: Container(
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Obx(
          () => IndexedStack(
            index: controller.currentTab.value,
            children: controller.navScreens,
          ),
        ),
      ),
      // floatingActionButton: InkWell(
      //   onTap: () {
      //     // controller.setCurrentTab(2);
      //     Get.toNamed(Routes.CUSTOMER_ADD_SERVICE);
      //   },
      //   child: Padding(
      //     padding: const EdgeInsets.only(top: 30.0),
      //     child: CircleAvatar(
      //       radius: 30,
      //       backgroundColor: LightThemeColors.primaryColor,
      //       child: Icon(
      //         Icons.add_circle,
      //         color: LightThemeColors.whiteColor,
      //       ),
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        color: LightThemeColors.navBarColor,
        height: size.height / 11.5,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 25.r,
                ),
                color: controller.currentTab.value == 0
                    ? LightThemeColors.primaryColor
                    : LightThemeColors.navIconColor,
                onPressed: () {
                  controller.setCurrentTab(0);
                },
              ),
              IconButton(
                icon: ImageIcon(
                  AssetImage(
                    Img.chatIcon,
                  ),
                  size: 25.r,
                  color: controller.currentTab.value == 1
                      ? LightThemeColors.primaryColor
                      : LightThemeColors.navIconColor,
                ),
                onPressed: () {
                  controller.setCurrentTab(1);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.add_circle,
                  size: 25.r,
                  color: controller.currentTab.value == 2
                      ? LightThemeColors.primaryColor
                      : LightThemeColors.navIconColor,
                ),
                onPressed: () {
                  controller.setCurrentTab(2);
                },
              ),
              IconButton(
                icon: Icon(
                  CupertinoIcons.hourglass_tophalf_fill,
                  size: 25.r,
                  color: controller.currentTab.value == 3
                      ? LightThemeColors.primaryColor
                      : LightThemeColors.navIconColor,
                ),
                onPressed: () {
                  controller.setCurrentTab(3);
                },
              ),
              // gapWidth(size: 50),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 25.r,
                ),
                color: controller.currentTab.value == 4
                    ? LightThemeColors.primaryColor
                    : LightThemeColors.navIconColor,
                onPressed: () {
                  controller.setCurrentTab(4);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.access_time_outlined,
                  size: 25.r,
                ),
                color: controller.currentTab.value == 5
                    ? LightThemeColors.primaryColor
                    : LightThemeColors.navIconColor,
                onPressed: () {
                  controller.setCurrentTab(5);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 25.r,
                  color: controller.currentTab.value == 6
                      ? LightThemeColors.primaryColor
                      : LightThemeColors.navIconColor,
                ),
                onPressed: () {
                  controller.setCurrentTab(6);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
