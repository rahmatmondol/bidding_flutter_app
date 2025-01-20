// import 'package:flutter/material.dart';
//
// class MyScaffoldBackground extends StatelessWidget {
//    MyScaffoldBackground({
//     super.key,
//     required this.size,
//     required this.child,
//   });
//
//   final Size size;
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//     Container(
//       height: size.height,
//       width: size.width,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color(0xff4C5B7D),
//             Color(0xff303030),
//             Color(0xff5A5D63),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: child,
//     );
//
//   }
// }
import 'package:flutter/material.dart';

class MyScaffoldBackground extends StatelessWidget {
  const MyScaffoldBackground({
    super.key,
    required this.size,
    required this.child,
    this.onRefresh,
  });

  final Size size;
  final Widget child;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4C5B7D),
            Color(0xff303030),
            Color(0xff5A5D63),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onRefresh!,
        color: Colors.white,
        backgroundColor: Color(0xff4C5B7D),
        child: content,
      );
    }

    return content;
  }
}
