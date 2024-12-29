import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallCustomButton extends StatelessWidget {
  final VoidCallback ontap;
  final Color color;
  final BoxBorder? border;
  final Widget widget;

  const SmallCustomButton({
    super.key,
    required this.color,
    this.border,
    required this.ontap,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.r),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
          border: border,
        ),
        child: Center(child: widget),
      ),
    );
  }
}
