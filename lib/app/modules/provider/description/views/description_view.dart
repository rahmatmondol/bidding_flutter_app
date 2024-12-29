import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/modules/provider/home/models/provider_service_model.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/divider.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import 'package:readmore/readmore.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/description_controller.dart';

class DescriptionView extends GetView<DescriptionController> {
  final ServiceProvider data;
   DescriptionView(this.data, {Key? key}) : super(key: key);
  final DescriptionController descriptionController = Get.put(DescriptionController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    //final Completer<GoogleMapController> _controller = Completer();




    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: SingleChildScrollView(
          child: Obx(
            () => SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapHeight(size: 20.0.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Text(
                      data.name.toString(),
                      style: kTitleTextstyle.copyWith(fontSize: 22.0.sp),
                    ),
                  ),
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
                        Text(data.zone![0].name.toString()),
                        gapWidth(size: 30.0.w),
                        Text("Post at 20 minutes ago")
                      ],
                    ),
                  ),

                  gapHeight(size: 10.0.h),
                  // Divider(color: LightThemeColors.grayColor),
                Container(
                  height: 180.0,
                  color: LightThemeColors.secounderyColor,
                  width: size.width,
                  child: Stack(
                    children: [
                      Center(
                        child: controller.images.isNotEmpty? Image.network(controller.images[controller.currenIndex.value].toString()): Text("No image available"),

                      ),
                      Positioned(
                        top: 60,
                        left: 110.0,
                        child: SizedBox(
                          height: 180.0,
                          width: size.width,
                          child: ListView.builder(
                            itemCount: data.images?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var imageData = data.images?[index];
                              if (imageData != null && imageData.path != null && imageData.path!.isNotEmpty) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.currenIndex.value = index;
                                      },
                                      child: Container(
                                        height: 40.0,
                                        width: 40.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          color: LightThemeColors.grayColor.withOpacity(.5),
                                          border: Border.all(
                                            color: LightThemeColors.primaryColor,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(imageData.path![index].toString()),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5.0),
                                  ],
                                );
                              } else {
                                return SizedBox.shrink(); // return an empty widget if there's no valid image
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // ******Describe*********
                  gapHeight(size: 10.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: ReadMoreText(
                      data.description.toString(),
                      trimLines: 7,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Show less',
                      lessStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: LightThemeColors.primaryColor,
                      ),
                      moreStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: LightThemeColors.primaryColor),
                    ),
                  ),
                  divider,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Text(
                      "Skill and Expertice",
                      style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                    ),
                  ),
                  gapHeight(size: 7.0.h),
                  //*********Skills list********* */

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 8.0.w, right: 8.0.w, top: 3.0.h, bottom: 3.0.h),
                      decoration: BoxDecoration(
                        color: LightThemeColors.grayColor,
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                      child: Text(data.skill!.join('')),
                    ),
                  ),
                  divider,
                  // ***********Active on this job ***********
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Text(
                      "Active on this job",
                      style: kTitleTextstyle.copyWith(fontSize: 15.5.sp),
                    ),
                  ),
                  gapHeight(size: 2.0.h),
                  //*********************** */
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Row(
                      children: [
                        Image.asset(
                          Img.timeIcon,
                          scale: 4.5,
                        ),
                        gapWidth(size: 5.0.w),
                        Text(
                          "10 minutes ago",
                          style: kSubtitleStyle,
                        ),
                      ],
                    ),
                  ),
                  gapHeight(size: 8.0.w),
                  // ***********Provider information ***********
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  //   child: Text(
                  //     "Provider information",
                  //     style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                  //   ),
                  // ),
                  // gapHeight(size: 1.5.h),
                  //***********Roww************ */

                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  //   child: Row(
                  //     //mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           CircleAvatar(
                  //             radius: 30.0,
                  //             backgroundImage: NetworkImage(
                  //                 'https://picsum.photos/seed/821/600'),
                  //           ),
                  //           gapWidth(size: 10.0.w),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 'User 0123',
                  //                 style: kSubtitleStyle,
                  //               ),
                  //               Text(
                  //                 'Member since jun 5,2023',
                  //                 style: kSubtitleStyle,
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       Image.asset(
                  //         Img.message,
                  //         scale: 4,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // ***********What’s Nearby***********

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Text(
                      "What’s Nearby",
                      style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                    ),
                  ),
                  gapHeight(size: 8.0.h),

                  // *********Container************
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    //*******Frist Container******* */
                    child: Container(
                      height: size.height / 2.2,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: LightThemeColors.secounderyColor,
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      child: Column(
                        children: [
                          gapHeight(size: 3.0.h),

                          Container(
                            height: size.height / 5.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(

                                    target: LatLng(double.parse(data.location!.split(',')[0]),double.parse(data.location!.split(',')[1])), zoom: 10.5),
                                markers: {
                                  Marker(
                                    markerId: MarkerId("Source"),
                                    position: LatLng(double.parse(data.location!.split(',')[0]),double.parse(data.location!.split(',')[1])),
                                  )
                                },
                              ),
                            ),
                          ),

                          // Container(

                          //   height: size.height / 7,
                          //   width: size.width,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(5.0.r),
                          //     // image: DecorationImage(
                          //     //   image: AssetImage(Images.img1),
                          //     // ),
                          //   ),
                          //   child: GoogleMap(
                          //     initialCameraPosition: CameraPosition(
                          //       target: sourseLocation,
                          //       zoom: 10.5,
                          //     ),
                          //     markers: {
                          //       Marker(
                          //         markerId: MarkerId("Source"),
                          //         position: sourseLocation,
                          //       )
                          //     },
                          //   ),
                          // ),
                          gapHeight(size: 12.0.h),
                          //************* */
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 8.5,
                                  backgroundColor: LightThemeColors.whiteColor
                                      .withOpacity(.7),
                                  child: CircleAvatar(
                                    radius: 6.5,
                                    backgroundColor: LightThemeColors
                                        .secounderyColor
                                        .withOpacity(.6),
                                    child: CircleAvatar(
                                      radius: 4.5,
                                      backgroundColor: LightThemeColors
                                          .whiteColor
                                          .withOpacity(.7),
                                    ),
                                  ),
                                ),
                                gapWidth(size: 7.0.w),
                                Expanded(
                                  child: Text(
                                    data.address.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: kSubtitleStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //************************ */

                          Divider(
                            color: LightThemeColors.grayColor,
                            thickness: 1.0,
                          ),
                          //********************* */

                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                          //   child: Row(
                          //     children: [
                          //       Icon(
                          //         Icons.location_on,
                          //         color: LightThemeColors.redColor,
                          //         size: 20,
                          //       ),
                          //       gapWidth(size: 5.0.w),
                          //       Text(
                          //         "DHANMONDI, Road 12/A, Dhaka",
                          //         overflow: TextOverflow.ellipsis,
                          //         maxLines: 1,
                          //         style: kSubtitleStyle,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          //********************** */
                          divider,
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          //   child: Container(
                          //     height: size.height / 14,
                          //     width: size.width,
                          //     decoration: BoxDecoration(
                          //       //color: Colors.blue,
                          //       border: Border.all(
                          //         color: LightThemeColors.whiteColor,
                          //       ),
                          //       borderRadius: BorderRadius.circular(15.0.r),
                          //     ),
                          //     child: Padding(
                          //       padding: EdgeInsets.only(
                          //         left: 12.0.w,
                          //         right: 10.0.w,
                          //       ),
                          //       child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             'View Map',
                          //             style: kTitleTextstyle,
                          //           ),
                          //           gapWidth(size: 21.0.w),
                          //           Text(
                          //             'Find your destination',
                          //             style: kSubtitleStyle.copyWith(
                          //                 fontSize: 11.2.sp),
                          //           ),
                          //           Image.asset(
                          //             Img.arrowIcon,
                          //             scale: 3.8,
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // divider,
                          // gapHeight(size: 5.0.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.0),
                            child: CustomButton(
                              bgColor: LightThemeColors.primaryColor,
                              ontap: () => Get.toNamed(Routes.APPLY),
                              widget: Text(
                                "Bid now",
                                style: kTitleTextstyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  divider,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
