// import 'package:dirham_uae/config/theme/light_theme_colors.dart';
// import 'package:dirham_uae/config/theme/my_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class PopularServiceCard extends StatelessWidget {
//   final String name;
//   final String location;
//   final String? description;
//   final String priceLevel;
//   final String price;
//   final int? itemCount;
//   final String? skill;
//   final Function()? onTap;
//
//   const PopularServiceCard(
//       {super.key,
//       required this.size,
//       required this.name,
//       required this.location,
//       this.description,
//       required this.priceLevel,
//       required this.price,
//       required this.onTap,
//       this.itemCount,
//       this.skill});
//
//   final Size size;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         // width: size.width * 0.8,
//         // margin: EdgeInsets.only(left: 14.r),
//         padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.r),
//           color: LightThemeColors.secounderyColor,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: kTitleTextstyle.copyWith(
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       gapHeight(size: 4),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.location_on,
//                             size: 15.sp,
//                             color: LightThemeColors.whiteColor,
//                           ),
//                           gapWidth(size: 5),
//                           Expanded(
//                             child: Text(
//                               location,
//                               style: kSubtitleStyle.copyWith(
//                                 color: LightThemeColors.whiteColor,
//                               ),
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 CircleAvatar(
//                   backgroundColor: LightThemeColors.keywordBoxColor,
//                   child: Icon(Icons.favorite_border),
//                 )
//               ],
//             ),
//             gapHeight(size: 10),
//             Text(
//               description!,
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//               style: kSubtitleStyle.copyWith(
//                 fontSize: 10.sp,
//                 color: LightThemeColors.secounderyTextColor,
//               ),
//               textAlign: TextAlign.justify,
//             ),
//             Text(
//               priceLevel,
//               style: kSubtitleStyle.copyWith(
//                 color: LightThemeColors.whiteColor,
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Expanded(
//               child: Row(
//                 children: [
//                   // Expanded(
//                   //   child: Container(
//                   //     //color: Colors.red,
//                   //     height: size.height * 0.03,
//                   //     child: ListView.builder(
//                   //       scrollDirection: Axis.horizontal,
//                   //       itemCount: itemCount,
//                   //       itemBuilder: (context, index) {
//                   //         return Container(
//                   //           padding: EdgeInsets.symmetric(horizontal: 10.r),
//                   //           margin: EdgeInsets.only(right: 5.r),
//                   //           decoration: BoxDecoration(
//                   //             borderRadius: BorderRadius.circular(25.r),
//                   //             color: LightThemeColors.keywordBoxColor,
//                   //           ),
//                   //           child: Center(
//                   //             child: Text(
//                   //               skill.toString(),
//                   //               style: kSubtitleStyle.copyWith(
//                   //                   color: LightThemeColors.whiteColor),
//                   //             ),
//                   //           ),
//                   //         );
//                   //       },
//                   //     ),
//                   //   ),
//                   // ),
//                   Expanded(
//                     child: Container(
//                       height: size.height * 0.03,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 10.r),
//                         margin: EdgeInsets.only(right: 5.r),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25.r),
//                           color: LightThemeColors.keywordBoxColor,
//                         ),
//                         child: Center(
//                           child: Text(
//                             skill.toString(),
//                             style: kSubtitleStyle.copyWith(
//                                 color: LightThemeColors.whiteColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Text(
//                     price,
//                     style: kTitleTextstyle.copyWith(
//                       fontSize: 14.sp,
//                       color: LightThemeColors.primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularServiceCard extends StatelessWidget {
  final String name;
  final String location;
  final String? description;
  final String priceLevel;
  final String price;
  final int? itemCount;
  final String? skill;
  final Function()? onTap;
  final bool isWishlisted; // New parameter
  final Function()? onWishlistTap; // New parameter for handling wishlist taps
  final bool showFavorite; // Add this new parameter

  const PopularServiceCard({
    super.key,
    required this.size,
    required this.name,
    required this.location,
    this.description,
    required this.priceLevel,
    required this.price,
    required this.onTap,
    this.itemCount,
    this.skill,
    this.isWishlisted = false, // Default to false
    this.onWishlistTap,
    this.showFavorite = true, // Default to true for backward compatibility
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: size.height * 0.55,
        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: LightThemeColors.secounderyColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      gapHeight(size: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 15.sp,
                            color: LightThemeColors.whiteColor,
                          ),
                          gapWidth(size: 5),
                          Expanded(
                            child: Text(
                              location,
                              style: kSubtitleStyle.copyWith(
                                color: LightThemeColors.whiteColor,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                if (showFavorite)
                  InkWell(
                    onTap: onWishlistTap,
                    child: CircleAvatar(
                      backgroundColor: LightThemeColors.keywordBoxColor,
                      child: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        color: isWishlisted
                            ? Colors.red
                            : LightThemeColors.whiteColor,
                      ),
                    ),
                  )
              ],
            ),
            gapHeight(size: 10),
            Text(
              description ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: kSubtitleStyle.copyWith(
                fontSize: 10.sp,
                color: LightThemeColors.secounderyTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              priceLevel,
              style: kSubtitleStyle.copyWith(
                color: LightThemeColors.whiteColor,
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: size.height * 0.03,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        margin: EdgeInsets.only(right: 5.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: LightThemeColors.keywordBoxColor,
                        ),
                        child: Center(
                          child: Text(
                            skill?.toString() ?? 'N/A',
                            style: kSubtitleStyle.copyWith(
                              color: LightThemeColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    price,
                    style: kTitleTextstyle.copyWith(
                      fontSize: 14.sp,
                      color: LightThemeColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
