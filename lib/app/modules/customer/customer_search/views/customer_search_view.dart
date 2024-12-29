import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';

import '../controllers/customer_search_controller.dart';

class CustomerSearchView extends GetView<CustomerSearchController> {
  const CustomerSearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top, left: 15.r, right: 15.r),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          children: [
            gapHeight(size: 20),
            Center(
              child: Text(
                "Search",
                style: kTitleTextstyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            gapHeight(size: 20),
            CustomTextField(
              hintText: "Search Here",
              controller: null,
              isIcon: true,
              icon: Img.searchIcon,
            )
          ],
        ),
      ),
    );
  
  }
}
