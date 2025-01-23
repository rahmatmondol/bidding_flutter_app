import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/theme/my_styles.dart';
import '../modules/provider/favorite_service/controllers/favorite_service_controller.dart';

class ServiceCard extends GetView<FavoriteServiceController> {
  const ServiceCard({
    super.key,
    required this.price,
    required this.imgPath,
    required this.placeName,
    required this.title,
    required this.reviewsPoint,
    required this.reviewsText,
    required this.size,
    this.onTap,
    this.onWishlistTap,
    // required this.isWishlisted,
    required this.serviceId,
  });

  final Function()? onTap;
  final Function()? onWishlistTap;
  final Size size;
  final String imgPath;
  final String price;
  final String placeName;
  final String title;
  final String reviewsPoint;
  final String reviewsText;

  // final bool isWishlisted;
  final String serviceId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0.w).copyWith(right: 0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: size.height / 3,
          width: size.width / 2,
          decoration: BoxDecoration(
            color: LightThemeColors.secounderyColor,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height / 8,
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage(imgPath),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  gapHeight(size: 2.0.h),
                  Padding(
                    padding: EdgeInsets.only(left: 6.0.w),
                    child: Text(
                      title,
                      maxLines: 2,
                      style: kTitleTextstyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 6.0.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 15.0,
                          color: LightThemeColors.grayColor,
                        ),
                        Expanded(
                          child: Text(
                            placeName,
                            maxLines: 1,
                            style: kSubtitleStyle.copyWith(
                              color: LightThemeColors.grayColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.r, right: 5.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "\$${price}",
                                  style: kTitleTextstyle.copyWith(
                                    fontSize: 16.sp,
                                    color: LightThemeColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.amber,
                        ),
                        Text(
                          reviewsPoint,
                          style: kSubtitleStyle,
                        ),
                      ],
                    ),
                  ),
                  gapHeight(size: 5.0.h)
                ],
              ),
              // Wishlist Button
              // Replace the GetBuilder widget with Obx
              Positioned(
                top: 10.r,
                right: 10.r,
                child: Obx(() => InkWell(
                      // Changed from GetBuilder to Obx
                      onTap: () {
                        print('Wishlist button tapped for service $serviceId');
                        print(
                            'Current state: ${controller.wishlistedItems[serviceId]}');
                        onWishlistTap?.call();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          controller.wishlistedItems[serviceId] ?? false
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.wishlistedItems[serviceId] ?? false
                              ? Colors.red
                              : Colors.white,
                          size: 20.r,
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
