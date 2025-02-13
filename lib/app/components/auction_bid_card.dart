import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/light_theme_colors.dart';
import '../../config/theme/my_styles.dart';

// class AuctionBidCard extends StatelessWidget {
//   final String profileImage;
//   final String bidderName;
//   final String message;
//   final String amount;
//   final String currency;
//   final VoidCallback onMessageTap;
//   final VoidCallback onAccept;
//   final VoidCallback onReject;
//   final VoidCallback onCardTap;
//   final DateTime createdAt;
//
//   const AuctionBidCard({
//     Key? key,
//     required this.profileImage,
//     required this.bidderName,
//     required this.message,
//     required this.amount,
//     required this.currency,
//     required this.onMessageTap,
//     required this.onAccept,
//     required this.onReject,
//     required this.onCardTap,
//     required this.createdAt,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onCardTap,
//       child: Container(
//         margin: EdgeInsets.only(bottom: 20.r),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.grey.shade600,
//             width: 1.5,
//           ),
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         padding: EdgeInsets.all(10.r),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 30.r,
//               backgroundImage: AssetImage(Img.personImg),
//               child: profileImage.startsWith('http')
//                   ? Image.network(
//                       profileImage,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return const SizedBox();
//                       },
//                     )
//                   : null,
//             ),
//             SizedBox(width: 10.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           bidderName,
//                           style: kTitleTextstyle.copyWith(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 15.r,
//                             backgroundColor: Colors.green,
//                             child: IconButton(
//                               padding: EdgeInsets.zero,
//                               icon: Icon(Icons.check,
//                                   color: Colors.white, size: 18.r),
//                               onPressed: onAccept,
//                             ),
//                           ),
//                           SizedBox(width: 8.w),
//                           CircleAvatar(
//                             radius: 15.r,
//                             backgroundColor: Colors.red,
//                             child: IconButton(
//                               padding: EdgeInsets.zero,
//                               icon: Icon(Icons.close,
//                                   color: Colors.white, size: 18.r),
//                               onPressed: onReject,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     '$currency $amount',
//                     style: kTitleTextstyle.copyWith(
//                       fontSize: 14.sp,
//                       color: LightThemeColors.primaryColor,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     message,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: kSubtitleStyle,
//                   ),
//                   SizedBox(height: 4.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         timeAgo(createdAt),
//                         style: kSubtitleStyle.copyWith(
//                           color: Colors.grey,
//                           fontSize: 12.sp,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: onMessageTap,
//                         icon: Icon(
//                           Icons.message,
//                           color: LightThemeColors.primaryColor,
//                           size: 20.r,
//                         ),
//                         padding: EdgeInsets.zero,
//                         constraints: BoxConstraints(),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String timeAgo(DateTime dt) {
//     final now = DateTime.now();
//     final difference = now.difference(dt);
//
//     if (difference.inDays > 0) {
//       return '${difference.inDays}d ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours}h ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes}m ago';
//     } else {
//       return 'Just now';
//     }
//   }
// }
class AuctionBidCard extends StatelessWidget {
  final String profileImage;
  final String bidderName;
  final String message;
  final String amount;
  final String currency;
  final String location;
  final String status;
  final VoidCallback onMessageTap;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onCardTap;
  final DateTime createdAt;

  const AuctionBidCard({
    Key? key,
    required this.profileImage,
    required this.bidderName,
    required this.message,
    required this.amount,
    required this.currency,
    required this.onMessageTap,
    required this.onAccept,
    required this.onReject,
    required this.onCardTap,
    required this.createdAt,
    required this.location,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.r),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade600,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(10.r),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundColor: LightThemeColors.secounderyColor,
              child: profileImage.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: Image.network(
                        profileImage,
                        fit: BoxFit.cover,
                        width: 60.r,
                        height: 60.r,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30.r,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30.r,
                    ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          bidderName,
                          style: kTitleTextstyle.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (status != 'accepted' && status != 'rejected') ...[
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15.r,
                              backgroundColor: LightThemeColors.primaryColor,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.check,
                                    color: Colors.white, size: 18.r),
                                onPressed: onAccept,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            CircleAvatar(
                              radius: 15.r,
                              backgroundColor: LightThemeColors.redColor,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.close,
                                    color: Colors.white, size: 18.r),
                                onPressed: onReject,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14.sp,
                        color: LightThemeColors.primaryColor,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          location,
                          style: kSubtitleStyle.copyWith(
                            color: LightThemeColors.secounderyTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kSubtitleStyle,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$currency $amount',
                        style: kTitleTextstyle.copyWith(
                          fontSize: 14.sp,
                          color: LightThemeColors.primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            timeAgo(createdAt),
                            style: kSubtitleStyle.copyWith(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            onPressed: onMessageTap,
                            icon: Icon(
                              Icons.message,
                              color: LightThemeColors.primaryColor,
                              size: 20.r,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String timeAgo(DateTime dt) {
    final now = DateTime.now();
    final difference = now.difference(dt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
