import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/modules/customer/customer_booking/controllers/customer_booking_controller.dart';
import 'package:dirham_uae/app/modules/customer/customer_booking/tabs/customer_all_service_tab.dart';
import 'package:dirham_uae/app/modules/customer/customer_booking/tabs/customer_accept_services.dart';
import 'package:dirham_uae/app/modules/customer/customer_booking/tabs/customer_complete_tab.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';

class CustomerBookingView extends GetView<CustomerBookingController> {
  const CustomerBookingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top + 20.r,
          ),
          decoration: BoxDecoration(gradient: buildCustomGradient()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  " My Booking",
                  style: kTitleTextstyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 16.r),
                ),
              ),
              gapHeight(size: 20),
              TabBar(
                labelStyle:
                    kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
                unselectedLabelStyle: kTitleTextstyle,
                unselectedLabelColor: LightThemeColors.whiteColor,

                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.r,
                      color: LightThemeColors.primaryColor,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 50.r)),
                labelColor: LightThemeColors.primaryColor,

                //indicatorColor: Colors.white,
                indicatorWeight: 15.w,

                tabs: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Img.allServiceIcon),
                      gapWidth(size: 4),
                      Text(
                        "All Service",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Img.completeIcon),
                      gapWidth(size: 4),
                      Text("Complete"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Img.acceptIcon),
                      gapWidth(size: 4),
                      Text("Accept"),
                    ],
                  ),
                ],
              ),
              gapHeight(size: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    CustomerAllServiceTab(),
                    CustomerCompleteServiceTab(),
                    CustomerAcceptServices(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
