import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../controllers/customer_home_controller.dart';

class CarouselSlider extends StatelessWidget {
  const CarouselSlider({
    super.key,
    required this.controller,
  });

  final CustomerHomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: double.infinity,
      child: Stack(
        children: [
          // Banner Pages
          PageView.builder(
            onPageChanged: (index) {
              controller.currentBannerIndex.value = index;
            },
            itemCount: controller.bannerImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: LightThemeColors.secounderyColor.withOpacity(0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    controller.bannerImages[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color:
                            LightThemeColors.secounderyColor.withOpacity(0.1),
                        child: const Center(
                          child: Icon(Icons.error_outline),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),

          // Dot Indicators
          Positioned(
            bottom: 16.r,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.bannerImages.length,
                (index) => Obx(
                  () => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.r),
                    height: 8.r,
                    width: controller.currentBannerIndex.value == index
                        ? 24.r
                        : 8.r,
                    decoration: BoxDecoration(
                      color: controller.currentBannerIndex.value == index
                          ? LightThemeColors.primaryColor
                          : LightThemeColors.whiteColor,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
