import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../customer_work_people_details/views/customer_work_people_details_view.dart';
import '../controllers/customer_work_people_list_controller.dart';

class CustomerWorkPeopleListView
    extends GetView<CustomerWorkPeopleListController> {
  final int serviceId;

  CustomerWorkPeopleListView(this.serviceId, {Key? key}) : super(key: key) {
    final controller = Get.put(CustomerWorkPeopleListController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getBettingList(serviceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // controller.getBettingList(serviceId);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final bettingList = controller.getBettingListModel.value.data;
        if (bettingList == null || bettingList.isEmpty) {
          return Container(
            decoration: BoxDecoration(gradient: buildCustomGradient()),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () => Get.back(), child: const Text('Back')),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'No bidding available',
                  style: TextStyle(
                      color: LightThemeColors.whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
          );
        }

        return Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.only(
            top: 0,
            left: 15.r,
            right: 15.r,
          ),
          decoration: BoxDecoration(gradient: buildCustomGradient()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderBar(title: 'Willing To Work'),
              gapHeight(size: 20),
              Text(
                "(${bettingList.length}) service providers want to do this job",
                style: kSubtitleStyle,
              ),
              gapHeight(size: 20),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: bettingList.length,
                  itemBuilder: (context, index) {
                    final betting = bettingList[index];
                    final provider = betting.provider;

                    if (provider == null) return null;

                    return Container(
                      margin: EdgeInsets.only(bottom: 20.r),
                      child: InkWell(
                        onTap: () {
                          if (betting.id != null && provider.id != null) {
                            Get.to(() => CustomerWorkPeopleDetailsView(
                                provider.id!.toInt(), betting.id!.toInt()));
                          }
                        },
                        child: Row(
                          children: [
                            // Profile Image
                            CircleAvatar(
                              radius: 30.r,
                              backgroundImage: NetworkImage(
                                  provider.profile?.image ?? 'placeholder_url'),
                              onBackgroundImageError: (_, __) {
                                // Handle error loading image
                              },
                            ),
                            gapWidth(size: 10),

                            // Provider Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.name ?? 'Unknown Provider',
                                    style: kTitleTextstyle,
                                  ),
                                  gapHeight(size: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14.sp,
                                        color: LightThemeColors.primaryColor,
                                      ),
                                      gapWidth(size: 5),
                                      Expanded(
                                        child: Text(
                                          provider.profile?.location ??
                                              'Location not available',
                                          style: kSubtitleStyle.copyWith(
                                            color: LightThemeColors
                                                .secounderyTextColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                  if (betting.amount != null) ...[
                                    gapHeight(size: 5),
                                    Text(
                                      'Bid Amount: \$${betting.amount!.toStringAsFixed(2)}',
                                      style: kSubtitleStyle,
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            // Action Buttons
                            if (betting.status != 'accepted' &&
                                betting.status != 'rejected') ...[
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => _showConfirmationDialog(
                                        context, betting.id!,
                                        isAccept: true),
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
                                  GestureDetector(
                                    onTap: () => _showConfirmationDialog(
                                        context, betting.id!,
                                        isAccept: false),
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor:
                                          LightThemeColors.redColor,
                                      child: Icon(
                                        Icons.close,
                                        color: LightThemeColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Dialog to confirm accept/reject action
  void _showConfirmationDialog(BuildContext context, int bettingId,
      {required bool isAccept}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: 300.0,
          width: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/dialog_image.png"),
              Text(
                isAccept
                    ? "Getting ready at your service"
                    : "Reject this service provider?",
                style: TextStyle(
                  color: LightThemeColors.scaffoldBackgroundColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 12),
              Text(
                isAccept
                    ? "See your service has been added on\n the booking page."
                    : "Are you sure you want to reject this provider?",
                style: TextStyle(
                  color: LightThemeColors.scaffoldBackgroundColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Color(0xff5A5D63),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: kTitleTextstyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isAccept) {
                          controller.acceptBidding(bettingId).then((_) {
                            Get.back();
                            Get.toNamed(Routes.CUSTOMER_BOOKING);
                          });
                        } else {
                          Get.back();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          color: isAccept
                              ? LightThemeColors.primaryColor
                              : LightThemeColors.redColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            isAccept ? "Book" : "Reject",
                            style: kTitleTextstyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
