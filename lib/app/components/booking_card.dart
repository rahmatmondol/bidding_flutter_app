import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingCard extends StatelessWidget {
  final String name;
  final String? location;
  final String? description;
  final String? priceLevel;
  final String? price;
  final String? buttonText;
  final bool? isButton;
  final Function()? onTap;
  final Function()? onBodyClick;
  final bool showFavorite;
  final List<String>? skills;

  const BookingCard({
    super.key,
    required this.size,
    required this.name,
    this.location,
    required this.description,
    required this.priceLevel,
    this.buttonText,
    required this.price,
    this.isButton = false,
    this.onTap,
    this.onBodyClick,
    this.showFavorite = true,
    this.skills,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBodyClick,
      child: Container(
        // height: size.height * 0.35,
        // width: size.width * 0.8,
        // margin: EdgeInsets.only(left: 14.r),
        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: LightThemeColors.secounderyColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kTitleTextstyle.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      gapHeight(size: 4),
                      if (location != null && location!.isNotEmpty) ...[
                        gapHeight(size: 4),
                        Wrap(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 15.sp,
                              color: LightThemeColors.whiteColor,
                            ),
                            gapWidth(size: 5),
                            Text(
                              location!,
                              overflow: TextOverflow.ellipsis,
                              style: kSubtitleStyle.copyWith(
                                color: LightThemeColors.whiteColor,
                              ),
                            )
                          ],
                        )
                      ],
                    ],
                  ),
                ),
                if (showFavorite)
                  CircleAvatar(
                    backgroundColor: LightThemeColors.keywordBoxColor,
                    child: Icon(Icons.favorite_border),
                  )
              ],
            ),
            gapHeight(size: 10),
            Text(
              description!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: kSubtitleStyle.copyWith(
                fontSize: 10.sp,
                color: LightThemeColors.secounderyTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            gapHeight(size: 10),
            Text(
              priceLevel!,
              style: kSubtitleStyle.copyWith(
                color: LightThemeColors.whiteColor,
              ),
            ),
            Row(
              children: [
                if (skills != null && skills!.isNotEmpty) ...[
                  Expanded(
                    child: Container(
                      height: size.height * 0.03,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: skills!.length > 2 ? 2 : skills!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.r),
                            margin: EdgeInsets.only(right: 5.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: LightThemeColors.keywordBoxColor,
                            ),
                            child: Center(
                              child: Text(
                                skills![index],
                                style: kSubtitleStyle.copyWith(
                                    color: LightThemeColors.whiteColor),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
                Text(
                  "\$$price",
                  style: kTitleTextstyle.copyWith(
                    fontSize: 14.sp,
                    color: LightThemeColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            isButton == true
                ? Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 4.0),
                    child: CustomButton(
                      bgColor: LightThemeColors.primaryColor,
                      ontap: onTap!,
                      widget: Text(buttonText!),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
