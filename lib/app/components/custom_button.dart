import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? ontap;
  final Color bgColor;
  final BoxBorder? border;
  final Widget widget;

  const CustomButton({
    super.key,
    required this.bgColor,
    this.border,
    required this.ontap,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.r, horizontal: 20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20.r),
          border: border,
        ),
        child: Center(child: widget),
      ),
    );
  }
}

// class CustomButton extends StatelessWidget {
//   final Widget widget;
//   final Color bgColor;
//   final VoidCallback onTap;
//   const CustomButton({
//     super.key,
//     required this.widget,
//     required this.bgColor,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 15),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         child: widget,
//       ),
//     );
//   }
// }
