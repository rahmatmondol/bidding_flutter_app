import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/my_images.dart';

class NotificationCard extends StatelessWidget {
  final String image;
  final String name;
  final String title;
  final String time;

  const NotificationCard({
    super.key,
    required this.image,
    required this.name,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.r),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundImage: AssetImage(Img.personImg), // Fallback image
            child: image.startsWith('http')
                ? Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(); // Shows fallback image on error
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
    );
  }
}
