import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/modules/customer/customer_work_people_list/views/customer_work_people_list_view.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';

import '../controllers/customer_service_details_controller.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class CustomerServiceDetailsView
    extends GetView<CustomerServiceDetailsController> {
  final id;
  CustomerServiceDetailsView(this.id, {Key? key}) : super(key: key);
  final CustomerServiceDetailsController controller =
      Get.put(CustomerServiceDetailsController());
  @override
  Widget build(BuildContext context) {
    controller.getServiceDetails(id);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff4C5B7D),
                      Color(0xff303030),
                      Color(0xff5A5D63),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gapHeight(size: 20.0.h),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                          child: Text(
                            controller.customerServiceDetailsModel.value.data!
                                .data!.name
                                .toString(),
                            style: kTitleTextstyle.copyWith(fontSize: 16.sp),
                          ),
                        ),
                        gapHeight(size: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: LightThemeColors.whiteColor,
                                size: 15,
                              ),
                              gapWidth(size: 2.0.w),
                              Expanded(
                                  child: Text(
                                      "${controller.customerServiceDetailsModel.value.data!.data!.address}",
                                      style: kSubtitleStyle)),
                              gapWidth(size: 10.0.w),
                              Text("Post at 20 minutes ago",
                                  style: kSubtitleStyle)
                            ],
                          ),
                        ),

                        gapHeight(size: 10.0.h),
                        Divider(color: LightThemeColors.grayColor),

                        // ******Describe*********
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "For this task you have ${controller.customerServiceDetailsModel.value.data!.data!.priceType} the ammount",
                                  style: TextStyle(
                                      color: LightThemeColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Text(
                                '${controller.customerServiceDetailsModel.value.data!.data!.price} ${controller.customerServiceDetailsModel.value.data!.data!.currency}',
                                style: TextStyle(
                                    color: LightThemeColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),

                        gapHeight(size: 20.0.h),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                color: LightThemeColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        gapHeight(size: 10.0.h),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                          child: HtmlWidget(
                            "${controller.customerServiceDetailsModel.value.data!.data!.description.toString()}",
                            renderMode: RenderMode.column,
                          ),
                        ),
                        gapHeight(size: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                          child: Text(
                            "Skill and Expertice",
                            style: kTitleTextstyle.copyWith(fontSize: 16.0.sp),
                          ),
                        ),
                        gapHeight(size: 7.0.h),
                        //*********Skills list********* */

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 8.0.w,
                                right: 8.0.w,
                                top: 3.0.h,
                                bottom: 3.0.h),
                            decoration: BoxDecoration(
                              color: LightThemeColors.grayColor,
                              borderRadius: BorderRadius.circular(10.0.r),
                            ),
                            child: Text(
                                "${controller.customerServiceDetailsModel.value.data!.data!.skill}"),
                          ),
                        ),
                        gapHeight(size: 20),
                        // *************************************Active on this job ********************
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                          child: Text(
                            "Job post",
                            style: kTitleTextstyle.copyWith(fontSize: 15.5.sp),
                          ),
                        ),
                        gapHeight(size: 2.0.h),
                        //*********************** */
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                        //   child: Row(
                        //     children: [
                        //       Image.asset(
                        //         Images.timeIcon,
                        //         scale: 4.5,
                        //       ),
                        //       gapWidth(size: 5.0.w),
                        //       Text(
                        //       DateFormat.MMMMEEEEd().format(controller.customerServiceDetailsModel.value.data!.data!.createdAt!.toLocal()),
                        //         style: kSubtitleStyle,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        gapHeight(size: controller.customerServiceDetailsModel.value.data!.data!.description!.length==200? 10.h:250),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.r),
                          child: CustomButton(
                            bgColor: LightThemeColors.primaryColor,
                            ontap: () {
                              Get.to(CustomerWorkPeopleListView(controller.customerServiceDetailsModel.value.data!.data!.id!.toInt()));
                              print(controller.customerServiceDetailsModel.value.data!.data!.id);
                            },
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.account_box,
                                  color: LightThemeColors.whiteColor,
                                ),
                                gapWidth(size: 5),
                                Text(
                                  "Willing to work",
                                  style: kTitleTextstyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
