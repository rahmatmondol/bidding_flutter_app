import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/my_styles.dart';

class ServiceCard extends StatelessWidget {
  const  ServiceCard({
    super.key,
    required this.price,
    required this.imgPath,
    required this.countryName,
    required this.placeName,
    required this.reviewsPoint,
    required this.reviewsText,
    required this.size,
    this.onTap,
  });
  final Function()? onTap;
  final Size size;
  final String imgPath;
  final String price;
  final String countryName;
  final String placeName;
  final String reviewsPoint;
  final String reviewsText;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height / 8,
                //width: 190.0,
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
                  placeName,
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
                        countryName,
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
                            // TextSpan(
                            //   text: "/ Person",
                            //   style: kTitleTextstyle.copyWith(
                            //     color: LightThemeColors.secounderyTextColor,
                            //   ),
                            // ),
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
        ),
      ),
    );
  }
}
