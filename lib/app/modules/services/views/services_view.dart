import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';

import '../../../../config/theme/my_styles.dart';
import '../../../components/popular_service_card.dart';
import '../../../components/search_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/services_controller.dart';

class ServicesView extends GetView<ServicesController> {
  const ServicesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: SafeArea(
          child: Obx(
            () => controller.isGetServiceloading.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Text(
                        "Services",
                        style: kTitleTextstyle.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      gapHeight(size: 20),
                      SearchButton(
                        hintsText: "Search Your Service",
                        ontap: () {
                          Get.toNamed(Routes.SEARCH);
                        },
                      ),
                      gapHeight(size: 10),
                      Expanded(
                        child: ListView.builder(
                          // shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller
                              .getServiceDataModel.value.data!.service!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: size.height * 0.25.h,
                              padding: EdgeInsets.only(bottom: 10.r),
                              child: PopularServiceCard(
                                size: size,
                                name: controller.getServiceDataModel.value.data!
                                    .service![index].name
                                    .toString(),
                                location: controller.getServiceDataModel.value
                                    .data!.service![index].address
                                    .toString(),
                                description: controller.getServiceDataModel
                                    .value.data!.service![index].description
                                    .toString(),
                                priceLevel: controller.getServiceDataModel.value
                                    .data!.service![index].level
                                    .toString(),
                                price: controller.getServiceDataModel.value
                                    .data!.service![index].price
                                    .toString(),
                                onTap: () => Get.toNamed(Routes.DESCRIPTION),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
