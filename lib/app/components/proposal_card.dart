import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/light_theme_colors.dart';
import '../../config/theme/my_styles.dart';

class ProposalCard extends StatelessWidget {
  final String name;
  final String date;
  final String duration;
  final String status;
  final VoidCallback ontap;

  const ProposalCard({
    super.key,
    required this.name,
    required this.date,
    required this.duration,
    required this.status,
    required this.ontap,
  });

  Color _getStatusColor(String status) {
    return switch (status.toLowerCase()) {
      'pending' => Colors.orange,
      'accepted' => Colors.green,
      'completed' => LightThemeColors.primaryColor,
      _ => Colors.grey,
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapHeight(size: 5),
                    Row(
                      children: [
                        Text(
                          date,
                          style: kSubtitleStyle,
                        ),
                        gapWidth(size: 10),
                        Expanded(
                          child: Text(
                            duration,
                            style: kSubtitleStyle.copyWith(
                              fontSize: 10.sp,
                              color: LightThemeColors.secounderyTextColor,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Text(
                status,
                style: kSubtitleStyle.copyWith(
                  color: _getStatusColor(status),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Divider(thickness: 2),
        ],
      ),
    );
  }
}
