import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/search_button.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/inbox_controller.dart';

class InboxView extends GetView<InboxController> {
  const InboxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                'Inbox',
                style: kTitleTextstyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            gapHeight(size: 20),
            SearchButton(
              hintsText: "Search",
              ontap: () {
                Get.toNamed(Routes.SEARCH);
              },
            ),
            gapHeight(size: 20),
            Text(
              "All Chat's (10)",
              style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            gapHeight(size: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: 50,
                itemBuilder: (context, index) {
                  return InboxCard(
                    image: Img.personImg,
                    name: "User 123",
                    location: "UAE, Dubai",
                    status: "Active",
                    ontap: () {
                      Get.toNamed(Routes.CHAT);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InboxCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final String status;
  final VoidCallback ontap;

  const InboxCard({
    super.key,
    required this.image,
    required this.name,
    required this.location,
    required this.status,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.r),
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: LightThemeColors.secounderyColor,
      ),
      child: InkWell(
        onTap: ontap,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: AssetImage(image),
            ),
            gapWidth(size: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: kTitleTextstyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: LightThemeColors.primaryColor,
                        size: 14.sp,
                      ),
                      gapWidth(size: 4),
                      Text(
                        location,
                        style: kSubtitleStyle.copyWith(
                          fontSize: 10.sp,
                          color: LightThemeColors.secounderyTextColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Text(
              status,
              style: kSubtitleStyle.copyWith(
                color: LightThemeColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
