import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme/my_styles.dart';

class CustomHeaderBar extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingTap;
  final List<Widget>? actions;

  const CustomHeaderBar({
    Key? key,
    required this.title,
    this.leadingIcon = Icons.arrow_back_ios_new,
    this.onLeadingTap,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 0,
        right: 50,
      ),
      child: Row(
        children: [
          if (leadingIcon != null)
            IconButton(
              onPressed: onLeadingTap ?? () => Get.back(),
              icon: Icon(
                leadingIcon,
                color: Colors.white,
              ),
            ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: kTitleTextstyleNew.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}

class CenteredAppBar extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingTap;
  final List<Widget>? actions;

  const CenteredAppBar({
    Key? key,
    required this.title,
    this.leadingIcon = Icons.arrow_back_ios_new,
    this.onLeadingTap,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top +
            10, // Account for status bar height
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent, // Transparent background
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Leading Icon (Optional)
          if (leadingIcon != null)
            IconButton(
              onPressed: onLeadingTap ?? () => Get.back(),
              icon: Icon(
                leadingIcon,
                color: Colors.white, // Customize icon color as needed
              ),
            )
          else
            const SizedBox(width: 48), // Placeholder to maintain alignment

          // Title (Always Centered)
          Expanded(
            child: Center(
              child: Text(
                title,
                style: kTitleTextstyleNew.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // Customize text color as needed
                ),
              ),
            ),
          ),

          // Actions (Optional)
          if (actions != null && actions!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            )
          else
            const SizedBox(width: 48), // Placeholder to maintain alignment
        ],
      ),
    );
  }
}
