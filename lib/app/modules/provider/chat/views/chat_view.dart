import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //******************************************* Header Section******************************* */

            Container(
              padding:
                  EdgeInsets.symmetric(vertical: 10.r).copyWith(bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.only(10),
                color: LightThemeColors.transparentColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    //******************************************* Person Image ************************** */

                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage(Img.personImg),
                    ),
                    gapWidth(size: 8.0.w),
                    //******************************************* Name section ************************** */

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "User 123",
                            style: kHeadingTextStyle.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              //color: LightThemeColors.grayColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 15.sp,
                                color: LightThemeColors.primaryColor,
                              ),
                              gapWidth(size: 4.r),
                              Text(
                                "UAE, Dubai",
                                style: kSubtitleStyle.copyWith(
                                  color: LightThemeColors.secounderyTextColor,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    //******************************************* Call Butonn ************************** */
                    Text(
                      "Active",
                      style: kSubtitleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: LightThemeColors.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(),
            gapHeight(size: 20.0.h),
            //************************************************ Body Text ************************************ */
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10.r),
                            decoration: BoxDecoration(
                              color: LightThemeColors.secounderyColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 10.h),
                              child: Text(
                                "How can i help You",
                                textAlign: TextAlign.center,
                                style: kHeadingTextStyle.copyWith(
                                  fontSize: 13.0.sp,
                                  fontWeight: FontWeight.w300,
                                  //color: LightThemeColors.grayColor,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: LightThemeColors.primaryColor,
                            backgroundImage: AssetImage(Img.personImg),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            //************************************** Text Field ****************************** */

            Container(
              padding: EdgeInsets.only(bottom: 10.r),
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0.r),
                  topRight: Radius.circular(8.0.r),
                ),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.r),
                padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5)
                    .copyWith(left: 15.r, right: 0),
                // height: MediaQuery.sizeOf(context).height * 0.05,
                decoration: BoxDecoration(
                  color: LightThemeColors.secounderyColor,
                  borderRadius: BorderRadius.circular(50.0.r),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff495777),
                      LightThemeColors.secounderyColor
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add_reaction_outlined,
                        color: LightThemeColors.whiteColor),
                    gapWidth(size: 10),
                    Expanded(
                      child: TextFormField(
                        cursorColor: LightThemeColors.primaryColor,
                        style: kTitleTextstyle.copyWith(
                            color: LightThemeColors.whiteColor),
                        decoration: InputDecoration(
                          fillColor: Colors.red,
                          hoverColor: Colors.amber,
                          border: InputBorder.none,
                          focusColor: Colors.amberAccent,
                          hintText: 'Type here...',
                        ),
                      ),
                    ),
                    gapWidth(size: 10.w),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        // height: MediaQuery.sizeOf(context).height * 0.05,
                        padding: EdgeInsets.all(15.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0.r),
                          color: LightThemeColors.primaryColor,
                        ),
                        child: Icon(Icons.send,
                            color: LightThemeColors.whiteColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
