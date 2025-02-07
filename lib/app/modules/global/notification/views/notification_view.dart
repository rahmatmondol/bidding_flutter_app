import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/app/components/notification_card.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';
import '../model/notification_model.dart';

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
              // Convert readAt to boolean
              final bool isRead =
                  notification.readAt != null && notification.readAt != false;

              return NotificationCard(
                image: controller.getValidImageUrl(notification.data['avatar']),
                name: notification.data['name'] ?? "",
                title: notification.title,
                time: controller.formatNotificationTime(notification.createdAt),
                isRead: isRead,
                // Pass the converted boolean
                onTap: () {
                  controller.markAsRead(notification.id);
                  showNotificationDetails(notification);
                },
              );
            },
          ),
        )
      ],
    );
  }

  void showNotificationDetails(NotificationModel notification) {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      Container(
        height: Get.height * 0.9,
        decoration: BoxDecoration(
          gradient: buildCustomGradient(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          children: [
            // Handle bar for bottom sheet
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.r),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            // Custom header
            CustomHeaderBar(
              title: 'Notification Details',
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile section
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage: AssetImage(Img.personImg),
                          child: notification.data['avatar']
                                      ?.toString()
                                      .startsWith('http') ??
                                  false
                              ? Image.network(
                                  notification.data['avatar'],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const SizedBox();
                                  },
                                )
                              : null,
                        ),
                        gapWidth(size: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.data['name'] ?? '',
                                style: kTitleTextstyle.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              gapHeight(size: 4),
                              Text(
                                controller.formatNotificationTime(
                                    notification.createdAt),
                                style: kSubtitleStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    gapHeight(size: 20),
                    // Title
                    Text(
                      notification.title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapHeight(size: 10),
                    // Message
                    Text(
                      notification.data['message'] ?? '',
                      style: kSubtitleStyle.copyWith(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
