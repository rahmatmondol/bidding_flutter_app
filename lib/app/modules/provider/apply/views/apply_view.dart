import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/modules/provider/apply/controllers/apply_controller.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/divider.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: LightThemeColors.whiteColor,
                          size: 20.0,
                        ),
                      ),
                      gapWidth(size: 18.0.h),
                      Text(
                        "Job details",
                        style: kTitleTextstyle,
                      ),
                    ],
                  ),
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
                        child: Text("Fixed Car Panting"),
                      ),
                      gapWidth(size: 10.0),
                      Text("Post by 9-7- 23"),
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
                    "Skill and Expertice",
                    style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                  ),

                  //*********Skills list********* */
                  gapHeight(size: 8.0),
                  Container(
                    padding: EdgeInsets.only(
                        left: 8.0.w, right: 8.0.w, top: 3.0.h, bottom: 3.0.h),
                    decoration: BoxDecoration(
                      color: LightThemeColors.grayColor,
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
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Bid Amount',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.attach_money),
                            ),
                            onChanged: (value) =>
                                controller.amount.value = value,
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
                          child: TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Message',
                              border: OutlineInputBorder(),
                              hintText: 'Write your proposal...',
                            ),
                            onChanged: (value) =>
                                controller.message.value = value,
                          ),
                        ),
                      ),
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

                  // Container(
                  //   height: size.height / 7,
                  //   //height: 200.0,
                  //   decoration: BoxDecoration(
                  //     color: LightThemeColors.secounderyColor,
                  //     borderRadius: BorderRadius.circular(10.0.r),
                  //   ),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  //     child: TextField(
                  //       maxLength: 500,
                  //       maxLines: 8,
                  //       style: TextStyle(color: LightThemeColors.whiteColor),
                  //       onChanged: (newValue) {
                  //         controller.enteredText.value = newValue;
                  //       },
                  //       decoration: InputDecoration(
                  //         hintText: "Type here...",
                  //         hintStyle: kSubtitleStyle,
                  //         border: InputBorder.none,
                  //         counterText:
                  //             '${controller.enteredText.value.length.toString()}/500  ',
                  //         counterStyle: kSubtitleStyle,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
