// ignore_for_file: unused_label

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/row_text.dart';
import 'package:dirham_uae/app/components/search_button.dart';
import 'package:dirham_uae/app/components/small_custom_button.dart';
import 'package:dirham_uae/app/components/small_service_card.dart';
import 'package:dirham_uae/app/modules/provider/description/views/description_view.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      body: Container(
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
        child:  SafeArea(
                child: SingleChildScrollView(
                  child: Obx(
                    ()=> homeController.isGetCategoriesloading.value? Center(child: CircularProgressIndicator(),): Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.r)
                              .copyWith(top: 30.r),
                          child: Column(
                            children: [
                              //****************************************** header section ****************************** */
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Good Morning",
                                          style: kTitleTextstyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "User 1234",
                                          style: kSubtitleStyle,
                                        )
                                      ],
                                    ),
                                  ),
                                  SmallCustomButton(
                                    color: LightThemeColors.secounderyColor,
                                    ontap: () {
                                      Get.toNamed(Routes.PICK_LOCATION);
                                    },
                                    widget: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.r),
                                      child: Row(
                                        children: [
                                          Image.asset(Img.locationIcon),
                                          gapWidth(size: 4),
                                          Text(
                                            "UAE, Dubai",
                                            style: kSubtitleStyle,
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: LightThemeColors.whiteColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  gapWidth(size: 5),
                                  SmallCustomButton(
                                      color: LightThemeColors.secounderyColor,
                                      ontap: () {
                                        Get.toNamed(Routes.NOTIFICATION);
                                      },
                                      widget: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child:
                                            Image.asset(Img.notificationIcon),
                                      ))
                                ],
                              ),
                              gapHeight(size: 20),

                              //****************************************** Search section ****************************** */

                              Row(
                                children: [
                                  Expanded(
                                    child: SearchButton(
                                      hintsText: "Search Your Service",
                                      ontap: () {
                                        Get.toNamed(Routes.SEARCH);
                                      },
                                    ),
                                  ),
                                  gapWidth(size: 10),
                                  // Container(
                                  //   padding: EdgeInsets.all(16.r),
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(8.r),
                                  //     gradient: LinearGradient(
                                  //       colors: [
                                  //         Color(0xff3BAAF3),
                                  //         Color(0xff2481F4),
                                  //       ],
                                  //       begin: Alignment.topLeft,
                                  //       end: Alignment.bottomRight,
                                  //     ),
                                  //   ),
                                  //   child: Image.asset(
                                  //     Images.filterIcon,
                                  //     scale: 1.5,
                                  //   ),
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ),
                        gapHeight(size: 20),

                        //****************************************** banner section ****************************** */

                        SizedBox(
                          height: size.height * 0.2,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Container(
                                width: size.width * 0.8,
                                margin: EdgeInsets.only(left: 14.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: LightThemeColors.secounderyColor,
                                  image: DecorationImage(
                                      image: AssetImage(Img.bannerImg),
                                      fit: BoxFit.cover),
                                ),
                              );
                            },
                          ),
                        ),
                        gapHeight(size: 20),

                        //****************************************** Category section ****************************** */

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.r),
                          child: Column(
                            children: [
                              RowText(
                                title: "Category",
                                buttonName: "See all",
                                ontap: () {
                                  Get.toNamed(Routes.ALL_CATEGORY);
                                },
                              ),
                              gapHeight(size: 10),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3.r,
                                  crossAxisSpacing: 8.r,
                                  mainAxisSpacing: 8.r,
                                ),
                                // scrollDirection: Axis.horizontal,
                                itemCount: homeController.getCategoriesDataModel
                                    .value.data?.category?.length,
                                itemBuilder: (context, index) {
                                  final category = homeController.getCategoriesDataModel.value.data?.category?[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.ALL_SUB_CATEGORY);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10.r),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: LightThemeColors.secounderyColor,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 6.r),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color: LightThemeColors.whiteColor,
                                            ),
                                            padding: EdgeInsets.all(5.r),
                                            child: Image(
                                              image: NetworkImage(
                                                category?.image.toString()??"",
                                              ),
                                            ),
                                          ),
                                          gapWidth(size: 5),
                                          Expanded(
                                            child: Text(
                                              category?.name.toString()??'',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: kSubtitleStyle.copyWith(
                                                color:
                                                    LightThemeColors.whiteColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        gapHeight(size: 20),

                        // //****************************************** Popular section ****************************** */

                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 16.r),
                        //   child: RowText(
                        //     title: "Popular Service",
                        //     buttonName: "See all",
                        //     ontap: () => Get.toNamed(Routes.DESCRIPTION),
                        //   ),
                        // ),
                        // gapHeight(size: 20),
                        // SizedBox(
                        //   height: size.height * 0.2.h,
                        //   child: ListView.builder(
                        //     physics: BouncingScrollPhysics(),
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: 4,
                        //     itemBuilder: (context, index) {
                        //       return Container(
                        //         margin: EdgeInsets.only(left: 14.r),
                        //         width: size.width * 0.8.h,
                        //         child: PopularServiceCard(
                        //           size: size,
                        //           name:
                        //               "Electronics & Gadgets Repair sjdf sldjfls fsdlfj",
                        //           location: "Cambodia",
                        //           description:
                        //               "Marketplace offers solution to all your desktop hardware and software related problems without you needing to get out of your ",
                        //           priceLevel: "Fixed Price- Entry level",
                        //           price: "200",
                        //           onTap: () => Get.toNamed(Routes.DESCRIPTION),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),

                        //****************************************** Recommended section ****************************** */

                        gapHeight(size: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            RowText(
                              title: "Recommended services",
                              buttonName: "",
                              ontap: () {},
                            ),
                            gapHeight(size: 10),
                            GridView.builder(
                              itemCount: homeController.getProviderServiceModel.value.data!.service!.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7.r,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6,
                              ),
                              physics:  NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                final service= homeController.getProviderServiceModel.value.data!.service![index];
                              return ServiceCard(
                                onTap: (){
                                  Get.to(DescriptionView(service));
                                },
                                    imgPath: Img.message,
                                    countryName: service.zone![0].name.toString(),
                                    placeName: service.name.toString(),
                                    reviewsPoint: "4.9/5",
                                    reviewsText: "(306 Reviews)",
                                    size: size,
                                    price: service.price.toString(),
                                  );


                                                          },
                            ),
                          ]),
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
