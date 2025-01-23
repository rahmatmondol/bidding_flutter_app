import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/nav_bar_controller.dart';

class NavBarView extends GetView<NavBarController> {
  const NavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // extendBody: true,
      body: Container(
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Obx(
          () =>
              //controller.navScreens[controller.currentTab.value]

              IndexedStack(
            index: controller.currentTab.value,
            children: controller.navScreens,
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          controller.setCurrentTab(2);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: LightThemeColors.primaryColor,
            child: Icon(
              Icons.shopping_cart,
              color: LightThemeColors.whiteColor,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              gapWidth(size: 50),
              IconButton(
                icon: Icon(
                  CupertinoIcons.heart_fill,
                  size: 25.r,
                ),
                color: controller.currentTab.value == 3
                    ? LightThemeColors.primaryColor
                    : LightThemeColors.navIconColor,
                onPressed: () {
                  controller.setCurrentTab(3);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 25.r,
                  color: controller.currentTab.value == 4
                      ? LightThemeColors.primaryColor
                      : LightThemeColors.navIconColor,
                ),
                onPressed: () {
                  controller.setCurrentTab(4);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
