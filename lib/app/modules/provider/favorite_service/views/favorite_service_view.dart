import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dirham_uae/app/components/popular_service_card.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/favorite_service_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteServiceView extends GetView<FavoriteServiceController> {
  const FavoriteServiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Favorite Service’s',
                style: kTitleTextstyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            gapHeight(size: 20),
            Text(
              "You have saved these services as love services",
              style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            gapHeight(size: 10),
            Expanded(
              child: ListView.builder(
                // shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    height: size.height * 0.25.h,
                    padding: EdgeInsets.only(bottom: 10.r),
                    child: PopularServiceCard(
                      size: size,
                      name: "Electronics & Gadgets Repair sjdf sldjfls fsdlfj",
                      location: "Cambodia",
                      description:
                          "Marketplace offers solution to all your desktop hardware and software related problems without you needing to get out of your ",
                      priceLevel: "Fixed Price- Entry level",
                      price: "200",
                      onTap: () => Get.toNamed(Routes.DESCRIPTION),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
