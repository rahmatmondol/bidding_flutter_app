import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/components/custome_payment_card.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/divider.dart';
import '../controllers/customer_payment_controller.dart';

class CustomerPaymentView extends GetView<CustomerPaymentController> {
  const CustomerPaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Payment',
                style: kTitleTextstyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            gapHeight(size: 20),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14.r,
                vertical: 20.r,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: LightThemeColors.secounderyColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Addresses",
                    style: kTitleTextstyle,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 35.r,
                        color: LightThemeColors.whiteColor,
                      ),
                      gapWidth(size: 5),
                      Expanded(
                        child: Text(
                          "Dubai Outlet Mall, Route 66 - Al Ain - Dubai Road ",
                          style: kSubtitleStyle,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            gapHeight(size: 20),
            Text(
              "Date and Time",
              style: kTitleTextstyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            gapHeight(size: 20),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: LightThemeColors.whiteColor,
                        size: 15.sp,
                      ),
                      gapWidth(size: 5),
                      Text(
                        "UAE, Dubai",
                        style: kSubtitleStyle,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: LightThemeColors.whiteColor,
                        size: 15.sp,
                      ),
                      gapWidth(size: 5),
                      Expanded(
                        child: Text(
                          "Sep 09/09/23",
                          style: kSubtitleStyle,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_clock,
                        color: LightThemeColors.whiteColor,
                        size: 15.sp,
                      ),
                      gapWidth(size: 5),
                      Expanded(
                        child: Text(
                          "01:00 PM",
                          style: kSubtitleStyle,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            gapHeight(size: 20),
            Text(
              "Bill",
              style: kTitleTextstyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            gapHeight(size: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: LightThemeColors.secounderyColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.r,
                      vertical: 10.r,
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          Icon(
                            Icons.payment,
                            color: LightThemeColors.whiteColor,
                            size: 30.r,
                          ),
                          gapWidth(size: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Option",
                                  style: kTitleTextstyle.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Choose your preferred payment system ',
                                  style:
                                      kSubtitleStyle.copyWith(fontSize: 11.sp),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      gapHeight(size: 20),
                      customPaymentCard(title: "Sub-Total", price: "BDT 1,360"),
                      gapHeight(size: 8),
                      customPaymentCard(
                          title: "Hot Deals",
                          price: "AED 200",
                          // subtitle: "EDOM0823",
                          icon: Icon(Icons.remove),
                          color: LightThemeColors.primaryColor),
                      gapHeight(size: 12),
                      customPaymentCard(
                          title: "Convenience!",
                          price: "AED 100",
                          icon: Icon(Icons.add),
                          color: LightThemeColors.midBlackColor),
                      gapHeight(size: 15),
                    ]),
                  ),
                  Container(
                    //height: 80,
                    decoration: BoxDecoration(
                        color: LightThemeColors.primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'You pay',
                                      style: kHeadingTextStyle.copyWith(
                                          color: LightThemeColors.whiteColor,
                                          fontSize: 16),
                                      children: [
                                        TextSpan(
                                            text: '(for 1 Traveler )',
                                            style: kHeadingTextStyle.copyWith(
                                                color: LightThemeColors
                                                    .secounderyTextColor,
                                                fontSize: 14))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AED \$1,360',
                                style: kHeadingTextStyle.copyWith(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'AED 1,900 Taxes Free ',
                                style: kTitleTextstyle.copyWith(fontSize: 8.r),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomButton(
              bgColor: LightThemeColors.primaryColor,
              ontap: () {
                Get.toNamed(Routes.THANKS);
              },
              widget: Text(
                "Confirm & Pay now",
                style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            divider,
          ],
        ),
      ),
    );
  }
}
