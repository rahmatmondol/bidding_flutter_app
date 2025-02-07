import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/my_images.dart';

class NotificationCard extends StatelessWidget {
  final String image;
  final String name;
  final String title;
  final String time;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.image,
    required this.name,
    required this.title,
    required this.time,
    // ADDED: New required properties
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ADDED: Wrap with GestureDetector
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.r),
        // ADDED: Decoration for border
        decoration: BoxDecoration(
          border: Border.all(
            color: isRead ? Colors.green : Colors.blue,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        // ADDED: Padding for better appearance with border
        padding: EdgeInsets.all(10.r),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: AssetImage(Img.personImg),
              child: image.startsWith('http')
                  ? Image.network(
                      image,
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
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kSubtitleStyle.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  gapHeight(size: 4),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kSubtitleStyle,
                  )
                ],
              ),
            ),
            Text(
              time,
              style: kSubtitleStyle,
            )
          ],
        ),
      ),
    );
  }
}
