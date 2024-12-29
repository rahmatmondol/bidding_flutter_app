import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import '../controllers/customer_work_people_details_controller.dart';
import 'package:dirham_uae/app/components/animated_progress_indicator.dart';

class CustomerWorkPeopleDetailsView extends GetView<CustomerWorkPeopleDetailsController> {
  final int id;
  final int bettingId;
  
   CustomerWorkPeopleDetailsView(this.id, this.bettingId, {Key? key}) : super(key: key);
  final CustomerWorkPeopleDetailsController customerWorkPeopleDetailsController= Get.put(CustomerWorkPeopleDetailsController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    controller.getCustomerBetListDetails(id, bettingId);
    return Scaffold(
      body: Obx(
        ()=> Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top + 20.r,
            left: 15.r,
            right: 15.r,
          ),
          decoration: BoxDecoration(gradient: buildCustomGradient()),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Details',
                    style: kTitleTextstyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
                gapHeight(size: 20),
      
                //******************************** Header Section ************************/
                Container(
                  margin: EdgeInsets.only(bottom: 20.r),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.CUSTOMER_WORK_PEOPLE_DETAILS);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage: AssetImage(Img.personImg),
                        ),
                        gapWidth(size: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${controller.getBettingListDetailsModel.value.data?.provider?.name}",
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
                                  Text(
                                    "${controller.getBettingListDetailsModel.value.data?.provider?.country}",
                                    style: kSubtitleStyle.copyWith(
                                      color: LightThemeColors.secounderyTextColor,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.CHAT);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: LightThemeColors.primaryColor,
                            ),
                            child: ImageIcon(
                              AssetImage(Img.chatIcon),
                              color: LightThemeColors.whiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
      
                //
      
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "For this task you have fixed the amount",
                        style: kTitleTextstyle,
                      ),
                    ),
                    Text(
                      "\$${controller.getBettingListDetailsModel.value.data?.provider?.betting?.metadata?.price}",
                      style: kTitleTextstyle.copyWith(
                        color: LightThemeColors.primaryColor,
                      ),
                    )
                  ],
                ),
                gapHeight(size: 10),
      
                //**************************************** Bid Section ***************** */
      
                Text(
                  "Bid",
                  style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "This client is scheduled to complete the task",
                        style: kSubtitleStyle,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.r,
                        vertical: 10.r,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: LightThemeColors.secounderyColor,
                      ),
                      child: Text(
                        "\$${controller.getBettingListDetailsModel.value.data?.provider?.betting?.metadata?.providerAmount}",
                        style: kSubtitleStyle.copyWith(
                          color: LightThemeColors.whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
                gapHeight(size: 10),
      
                Text(
                  "10% Service fee ",
                  style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 10),
      
                //**************************************** Additional detalis  ***************** */
      
                Text(
                  "Additional detalis ",
                  style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 10),
      
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: LightThemeColors.secounderyColor),
                  child: Text(
                    "${controller.getBettingListDetailsModel.value.data?.provider?.betting?.additionalDetails}",
                    style: kSubtitleStyle,
                  ),
                ),
                gapHeight(size: 10),
      
                //**************************************** about provider Section ***************** */
                if(controller.getBettingListDetailsModel.value.data?.provider?.bio!=null)
                Text(
                  "About the provider",
                  style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 10),
                Text(
                  "${controller.getBettingListDetailsModel.value.data?.provider?.bio??""
                  }",
                  style: kSubtitleStyle,
                ),
                gapHeight(size: 10),
      
                //**************************************** Review Section ***************** */
      
                Text(
                  "Review",
                  style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
                ),
      
                gapHeight(size: 10),
      
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${controller.getBettingListDetailsModel.value.data?.provider?.avgRating}",
                          style: kTitleTextstyle.copyWith(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Out of 5",
                          style: kTitleTextstyle.copyWith(
                            color: LightThemeColors.secounderyTextColor,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          StarBox(item: 1),
                          StarBox(item: 4),
                          StarBox(item: 3),
                          StarBox(item: 2),
                          StarBox(item: 1),
                        ],
                      ),
                    ),
                    gapWidth(size: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AnimatedLinearProgressIndicator(percentage: 0.9),
                          AnimatedLinearProgressIndicator(percentage: 0.7),
                          AnimatedLinearProgressIndicator(percentage: 0.5),
                          AnimatedLinearProgressIndicator(percentage: 0.3),
                          AnimatedLinearProgressIndicator(percentage: 0.1),
                        ],
                      ),
                    )
                  ],
                ),
                gapHeight(size: 20),
      
                //**************************************** Button Section ***************** */
      
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        bgColor: LightThemeColors.redColor,
                        ontap: () {},
                        widget: Text(
                          "Cancel",
                          style: kTitleTextstyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    gapWidth(size: 20),
                    Expanded(
                      child: CustomButton(
                        bgColor: LightThemeColors.primaryColor,
                        ontap: () {
                          Get.toNamed(Routes.CUSTOMER_PAYMENT);
                        },
                        widget: Text(
                          "Accept",
                          style: kTitleTextstyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                gapHeight(size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StarBox extends StatelessWidget {
  final int item;
  const StarBox({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: item,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: LightThemeColors.primaryColor,
        ),
      ),
    );
  }
}
