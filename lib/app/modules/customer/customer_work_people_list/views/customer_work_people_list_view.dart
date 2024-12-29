// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/modules/customer/customer_work_people_details/views/customer_work_people_details_view.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/customer_work_people_list_controller.dart';

class CustomerWorkPeopleListView
    extends GetView<CustomerWorkPeopleListController> {
  final int serviceId;
  CustomerWorkPeopleListView(this.serviceId, {Key? key}) : super(key: key);
  final CustomerWorkPeopleListController customerWorkPeopleListController =
      Get.put(CustomerWorkPeopleListController());

  @override
  Widget build(BuildContext context) {
    controller.getBettingList(serviceId);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.getBettingListModel.value.data != null &&
            controller.getBettingListModel.value.data!.betting != null &&
            controller.getBettingListModel.value.data!.betting!.isEmpty) {
          return Center(
              child: Text('No bidding available',style: TextStyle(color: LightThemeColors.whiteColor, fontWeight: FontWeight.bold),
          ));
        } else {
          return Container(
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
                    'Willing to work',
                    style: kTitleTextstyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
                gapHeight(size: 20),
                Text(
                  "(${controller.getBettingListModel.value.data?.betting?.length??0}) Service providers want to do this job",
                  style: kSubtitleStyle,
                ),
                gapHeight(size: 20),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller
                        .getBettingListModel.value.data?.betting?.length,
                    itemBuilder: (context, index) {
                      var betting = controller
                          .getBettingListModel.value.data?.betting?[index];
                      if (betting != null) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 20.r),
                          child: InkWell(
                            onTap: () {
                              Get.to(CustomerWorkPeopleDetailsView(betting.provider!.id!.toInt(),betting.id!.toInt()));
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30.r,
                                  backgroundImage: NetworkImage(
                                      betting.provider!.image.toString()),
                                ),
                                gapWidth(size: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${betting.provider!.name}",
                                        style: kTitleTextstyle,
                                      ),
                                      gapHeight(size: 5),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 14.sp,
                                            color:
                                                LightThemeColors.primaryColor,
                                          ),
                                          gapWidth(size: 5),
                                          Text(
                                            "UAE,Dubai",
                                            style: kSubtitleStyle.copyWith(
                                              color: LightThemeColors
                                                  .secounderyTextColor,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Dialog errorDialog = Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12.0)), //this right here
                                          child: Container(
                                            height: 300.0,
                                            width: 300.0,
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
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                    "assets/images/dialog_image.png"),
                                                Text(
                                                  "Getting ready at your service",
                                                  style: TextStyle(
                                                      color: LightThemeColors
                                                          .scaffoldBackgroundColor,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  "See your service has been added on\n                 the booking page.",
                                                  style: TextStyle(
                                                      color: LightThemeColors
                                                          .scaffoldBackgroundColor,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          width: 120,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color(0xff5A5D63),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(15),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            "Cancle",
                                                            style: kTitleTextstyle
                                                                .copyWith(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (betting.id !=
                                                              null) {
                                                            controller
                                                                .bettingBooking(
                                                                    betting.id!
                                                                        .toInt());
                                                          } else{
                                                            //handle api error 
                                                          }
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          width: 120,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                LightThemeColors
                                                                    .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            "Booked",
                                                            style:
                                                                kTitleTextstyle
                                                                    .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                errorDialog);
                                      },
                                      child: CircleAvatar(
                                        radius: 20.r,
                                        backgroundColor:
                                            LightThemeColors.primaryColor,
                                        child: Icon(
                                          Icons.done,
                                          color: LightThemeColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                    gapWidth(size: 5),
                                    CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor:
                                          LightThemeColors.redColor,
                                      child: Icon(
                                        Icons.close,
                                        color: LightThemeColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        // Handle api erorr
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
