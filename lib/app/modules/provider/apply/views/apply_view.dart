import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/modules/provider/apply/controllers/apply_controller.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/divider.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class ApplyView extends GetView<ApplyController> {
  const ApplyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  divider,
                  //**********Appbar*************
                  CustomHeaderBar(title: 'Job Details'),
                  gapHeight(size: 20.0.h),
                  //***********title : Water Tap Servicing************** */
                  Text(
                    controller.title,
                    style: kTitleTextstyle,
                  ),
                  gapHeight(size: 8.0.h),
                  //**************row ************/
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 8.0.w,
                            right: 8.0.w,
                            top: 3.0.h,
                            bottom: 3.0.h),
                        decoration: BoxDecoration(
                          color: LightThemeColors.grayColor,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: Text(controller.skills?.join(', ') ?? ''),
                      ),
                      gapWidth(size: 10.0),
                      Text(
                          'Posted on ${DateFormat('MMM dd, yyyy').format(controller.createdAt)}')
                    ],
                  ),
                  divider,

                  // *********Read More********
                  ReadMoreText(
                    controller.description,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Show less',
                    lessStyle: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w400,
                        color: LightThemeColors.primaryColor),
                    moreStyle: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w400,
                        color: LightThemeColors.primaryColor),
                  ),
                  divider,
                  Text(
                    "Skill and Expertise",
                    style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                  ),

                  //*********Skills list********* */
                  gapHeight(size: 8.0),
                  Container(
                    padding: EdgeInsets.only(
                        left: 8.0.w, right: 8.0.w, top: 3.0.h, bottom: 3.0.h),
                    decoration: BoxDecoration(
                      color: LightThemeColors.transparentColor,
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                    child: Wrap(
                      spacing: 8.w,
                      children: controller.skills
                          .map((skill) => Chip(
                                label: Text(skill),
                                backgroundColor:
                                    LightThemeColors.secounderyColor,
                              ))
                          .toList(),
                    ),
                  ),
                  divider,

                  //*********************** */
                  Text(
                    "What is the full amount you’d like to bid for this job?",
                    style: kTitleTextstyle.copyWith(
                        fontSize: 15.5.sp, fontWeight: FontWeight.w500),
                  ),
                  gapHeight(size: 8.0.h),

                  Text(
                    "Bid",
                    style: kTitleTextstyle.copyWith(
                        fontSize: 15.0.sp, fontWeight: FontWeight.w500),
                  ),

                  //*******Row********* */

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total amount the client will see on your proposal",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        height: size.height / 15,
                        width: size.width / 2.7,
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(5.0.r),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '\$',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 2),
                                    hintText: 'Enter Amount',
                                    hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                  onChanged: (value) =>
                                      controller.amount.value = value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  divider,
                  //*************** */
                  Text(
                    "10% Service fee",
                    style: kTitleTextstyle.copyWith(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  divider,
                  //*************** */
                  Text(
                    "you’ll Receive ",
                    style: kTitleTextstyle.copyWith(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total amount the client will seen on your proposal",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        height: size.height / 15,
                        width: size.width / 2.7,
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(5.0.r),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '\$',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    hintText: 'Bid Amount',
                                    hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                  onChanged: (value) =>
                                      controller.amount.value = value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   height: size.height / 15,
                      //   width: size.width / 2.7,
                      //   decoration: BoxDecoration(
                      //     color: LightThemeColors.secounderyColor,
                      //     borderRadius: BorderRadius.circular(5.0.r),
                      //   ),
                      //   child: Center(
                      //     child: TextField(
                      //       maxLines: 4,
                      //       decoration: InputDecoration(
                      //         labelText: 'Message',
                      //         border: OutlineInputBorder(),
                      //         hintText: 'Write your proposal...',
                      //       ),
                      //       onChanged: (value) =>
                      //           controller.message.value = value,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  divider,
                  Row(
                    children: [
                      Text(
                        'Additional detalis',
                        style: kTitleTextstyle,
                      ),
                      Text(
                        " *",
                        style: kTitleTextstyle.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: LightThemeColors.primaryColor,
                        ),
                      ),
                    ],
                  ),

                  gapHeight(size: 7.0.h),

                  Container(
                    height: size.height / 4,
                    decoration: BoxDecoration(
                      color: LightThemeColors.secounderyColor,
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: TextField(
                        maxLength: 500,
                        maxLines: 20,
                        style: TextStyle(color: LightThemeColors.whiteColor),
                        onChanged: (value) => controller.message.value = value,
                        decoration: InputDecoration(
                          hintText: "Type here...",
                          hintStyle: kSubtitleStyle,
                          border: InputBorder.none,
                          counterText:
                              '${controller.message.value.length.toString()}/500  ',
                          counterStyle: kSubtitleStyle,
                        ),
                      ),
                    ),
                  ),
                  gapHeight(size: 20.0.h),
                  CustomButton(
                    bgColor: LightThemeColors.primaryColor,
                    ontap: () => controller.submitBid(),
                    widget: Text(
                      "Apply",
                      style: kTitleTextstyle,
                    ),
                  ),
                  divider,
                  divider,
                  // **********Button**********
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
