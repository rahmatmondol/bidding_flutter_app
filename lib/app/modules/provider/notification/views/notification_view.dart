import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/app/components/notification_card.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Container(
        width: size.width,
        padding: EdgeInsets.only(
          top: 0,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Obx(() => controller.isNotificationLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.notifications.isEmpty
                ? _buildEmptyState(size)
                : _buildNotificationList()),
      ),
    );
  }

  Widget _buildEmptyState(Size size) {
    return Column(
      children: [
        CustomHeaderBar(title: 'Notification'),
        const Spacer(),
        Image.asset(Img.emptyNotification),
        gapHeight(size: 20),
        Text(
          "Empty Notification",
          style: kTitleTextstyle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildNotificationList() {
    return Column(
      children: [
        CustomHeaderBar(title: 'Notification'),
        gapHeight(size: 10),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];
              return NotificationCard(
                image: controller.getValidImageUrl(notification.data['avatar']),
                name: "User 2",
                title: notification.data['message'] ?? "",
                time: controller.formatNotificationTime(notification.createdAt),
              );
            },
          ),
        )
      ],
    );
  }
}
