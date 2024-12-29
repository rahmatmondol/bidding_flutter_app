import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/notification_card.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/customer_notification_controller.dart';

class CustomerNotificationView extends GetView<CustomerNotificationController> {
  const CustomerNotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: size.width,
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: controller.isNotificationLoading.value == true
            ? Column(
                children: [
                  Center(
                    child: Text(
                      'Notification',
                      style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                  ),
                  Spacer(),
                  Image.asset(Img.emptyNotification),
                  gapHeight(size: 20),
                  Text(
                    "Empty Notification",
                    style: kTitleTextstyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  Spacer(),
                ],
              )
            : Column(
                children: [
                  Center(
                    child: Text(
                      'Notification',
                      style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                  ),
                  gapHeight(size: 10),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 50,
                      itemBuilder: (context, index) {
                        return NotificationCard(
                          image: Img.personImg,
                          name: "User1234",
                          title:
                              "Your new connection accept tour Requst lskdjf sldfjsldf sdf",
                          time: "3h",
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
