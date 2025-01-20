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
