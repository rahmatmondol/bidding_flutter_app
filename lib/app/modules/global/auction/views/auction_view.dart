import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auction_booking_controller.dart';
import '../tabs/all_auction_tab.dart';
import '../tabs/my_auction_tab.dart';

class CustomerAuctionView extends GetView<CustomerAuctionController> {
  const CustomerAuctionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
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
                  " My Auctions",
                  style: kTitleTextstyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 16.r),
                ),
              ),
              gapHeight(size: 25),
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
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Img.allServiceIcon),
                        gapWidth(size: 2.5.r),
                        Text(
                          "All Auction",
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Img.completeIcon),
                        gapWidth(size: 1.5.r),
                        Text("My Auction"),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Image.asset(Img.acceptIcon),
                  //     gapWidth(size: 4),
                  //     Text("Accept"),
                  //   ],
                  // ),
                ],
              ),
              gapHeight(size: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    CustomerAllAuctionTab(),
                    MyAuctionsTab(),
                    // CustomerAcceptAuction(),
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
