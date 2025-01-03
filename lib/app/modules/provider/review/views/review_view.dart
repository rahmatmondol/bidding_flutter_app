import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Review',
                  style: kTitleTextstyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
              ),
              gapHeight(size: 20),
              CircleAvatar(
                radius: 60.r,
                backgroundImage: AssetImage(Img.personImg),
              ),
              gapHeight(size: 20),
              Text(
                "User123",
                style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
              ),
              gapHeight(size: 20),
              Text(
                "Click on the stars of this service",
                style: kSubtitleStyle,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Icon(
                        Icons.star,
                        color: LightThemeColors.primaryColor,
                      );
                    },
                  ),
                ),
              ),
              gapHeight(size: 20),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: LightThemeColors.secounderyColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Write your review",
                      style: kTitleTextstyle.copyWith(
                        color: LightThemeColors.whiteColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.r),
                          child: Icon(
                            Icons.edit,
                            color: LightThemeColors.primaryColor,
                          ),
                        ),
                        gapWidth(size: 5),
                        Expanded(
                          child: Container(
                            // color: Colors.red,
                            //height: 100,
                            child: TextFormField(
                              maxLength:
                                  100, // Set the maximum character count here

                              scrollPadding: EdgeInsets.zero,
                              maxLines:
                                  null, // Set maxLines to null to make it expandable

                              decoration: InputDecoration(
                                  hintText:
                                      "Tell us same things about this service",
                                  border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              gapHeight(size: 30),
              CustomButton(
                bgColor: LightThemeColors.primaryColor,
                ontap: () {},
                widget: Text("Submit Review"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
