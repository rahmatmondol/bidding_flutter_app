import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:dirham_uae/app/components/search_button.dart';
import 'package:dirham_uae/app/modules/provider/inbox/views/inbox_view.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/customer_inbox_controller.dart';

class CustomerInboxView extends GetView<CustomerInboxController> {
  const CustomerInboxView({Key? key}) : super(key: key);
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
                      Get.toNamed(Routes.CUSTOMER_CHAT);
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
