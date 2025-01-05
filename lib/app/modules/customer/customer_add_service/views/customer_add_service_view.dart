// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison, unused_local_variable, unnecessary_brace_in_string_interps

import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/app/modules/customer/customer_pick_location/views/customer_pick_location_view.dart';
import 'package:dirham_uae/app/modules/provider/home/controllers/home_controller.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/theme/my_images.dart';
import '../../../../../utils/global_variable/divider.dart';
import '../../../provider/home/models/get_categories_model.dart';
import '../controllers/customer_add_service_controller.dart';

class CustomerAddServiceView extends GetView<CustomerAddServiceController> {
  CustomerAddServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomerAddServiceController customerAddServiceController =
        Get.put(CustomerAddServiceController());
    final HomeController homeC = Get.put(HomeController());
    Size size = MediaQuery.sizeOf(context);

    final myBox = Hive.box('mapBox');

    var currentAddress;
    currentAddress = myBox.get("address3");

    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: Obx(() {
          // final catrgory =
          //     (homeC.getCategoriesDataModel.value.data?.category ?? [])
          //         .firstWhere((c) => c.id == c.id); // Ch
          final categories =
              homeC.getCategoriesDataModel.value.data?.category ?? [];

          // Find the selected category safely
          Category? selectedCategory;
          if (controller.selectedCategory.value.isNotEmpty) {
            selectedCategory = categories.firstWhereOrNull((category) =>
                category.name == controller.selectedCategory.value);
          }

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeaderBar(title: 'Change Password'),
                      Text("Service Name",
                          style: kTitleTextstyle.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                      divider,
                      CustomTextField(
                        fillColor: LightThemeColors.scaffoldBackgroundColor,
                        hintText: "Enter Your First name",
                        controller: controller.name.value,
                      ),

                      divider,
                      // *********** Add button****************
                      InkWell(
                        onTap: () async {
                          final pickedFiles =
                              await ImagePicker().pickMultiImage();
                          if (pickedFiles != null && pickedFiles.isNotEmpty) {
                            controller.selectedthumbnail.value = pickedFiles
                                .map((pickedFile) => XFile(pickedFile.path))
                                .toList();
                            controller.customerCreateService(
                                selectedCategory?.id ?? 0,
                                controller.selectedCurrency.value,
                                controller.selectedPriceType.value,
                                controller.selectedLevelList.value);
                          } else {
                            print('Image picked successfully');
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.r,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: LightThemeColors.secounderyColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(child: Text("Add Photos")),
                        ),
                      ),

                      divider,
                      Text(" Service Description",
                          style: kTitleTextstyle.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                      //
                      gapHeight(size: 2.0.h),
                      Container(
                        height: size.height * 0.25,
                        // Reduced height since we don't need toolbar
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: TextField(
                          controller: controller.description.value,
                          style: TextStyle(color: LightThemeColors.whiteColor),
                          maxLines: null,
                          // Allows multiple lines
                          expands: true,
                          // Makes the TextField expand to fill the container
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            hintText: 'Describe your service...',
                            hintStyle: TextStyle(
                                color: LightThemeColors.whiteColor
                                    .withOpacity(0.5)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0.r),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Skill and Expertise",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapHeight(size: 2.0.h),
                      Container(
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: Column(
                          children: [
                            // Tag Input Field
                            Padding(
                              padding: EdgeInsets.all(8.r),
                              child: TextField(
                                controller: controller.tagController.value,
                                style: TextStyle(
                                    color: LightThemeColors.whiteColor),
                                decoration: InputDecoration(
                                  hintText: 'Add up to 5 skills...',
                                  hintStyle: TextStyle(
                                      color: LightThemeColors.whiteColor
                                          .withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: LightThemeColors.grayColor
                                      .withOpacity(0.2),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.add,
                                        color: LightThemeColors.whiteColor),
                                    onPressed: () {
                                      if (controller.tagController.value.text
                                          .isNotEmpty) {
                                        controller.addTag(controller
                                            .tagController.value.text
                                            .trim());
                                      }
                                    },
                                  ),
                                ),
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    controller.addTag(value.trim());
                                  }
                                },
                              ),
                            ),

                            // API Tags Suggestions
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 8.r),
                              child: Obx(() => Row(
                                    children: controller.apiTags
                                        .where((tag) => !controller.selectedTags
                                            .contains(tag))
                                        .take(5)
                                        .map((tag) => Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.r),
                                              child: InkWell(
                                                onTap: () =>
                                                    controller.addTag(tag),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.r,
                                                      vertical: 6.r),
                                                  decoration: BoxDecoration(
                                                    color: LightThemeColors
                                                        .grayColor
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.r),
                                                  ),
                                                  child: Text(
                                                    tag,
                                                    style: TextStyle(
                                                        color: LightThemeColors
                                                            .whiteColor),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  )),
                            ),

                            // Selected Tags
                            Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Obx(() => Wrap(
                                    spacing: 8.r,
                                    runSpacing: 8.r,
                                    children: controller.selectedTags
                                        .map((tag) => Chip(
                                              backgroundColor:
                                                  LightThemeColors.grayColor,
                                              label: Text(
                                                tag,
                                                style: TextStyle(
                                                    color: LightThemeColors
                                                        .whiteColor),
                                              ),
                                              deleteIcon: Icon(
                                                Icons.clear,
                                                color:
                                                    LightThemeColors.whiteColor,
                                                size: 18.r,
                                              ),
                                              onDeleted: () =>
                                                  controller.removeTag(tag),
                                            ))
                                        .toList(),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      divider,
                      Text(
                        "Select Service Category",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapHeight(size: 3.0.h),

                      //********Select Service Category*********

                      Obx(() => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: LightThemeColors.secounderyColor,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: LightThemeColors.shadowColor,
                                  offset: Offset(1, 1),
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Center(
                                child: DropdownButton(
                                    dropdownColor: LightThemeColors.primaryColor
                                        .withOpacity(.8),
                                    alignment: Alignment.centerLeft,
                                    value: controller.categoryyIds.value.isEmpty
                                        ? null
                                        : controller.categoryyIds.value,
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    hint: const Text("Choose Category"),
                                    items:
                                        (controller.categoryModel.value.data ??
                                                [])
                                            .map((mapValue) {
                                      return DropdownMenuItem(
                                        value: mapValue.name.toString(),
                                        child: Text(
                                          mapValue.name.toString(),
                                          style: TextStyle(
                                              color:
                                                  LightThemeColors.whiteColor),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      final selectedZone = (controller
                                                  .categoryModel.value.data ??
                                              [])
                                          .firstWhere((zone) =>
                                              zone.name.toString() == newValue);

                                      // Check if the selected zone is not null and has an ID
                                      // ignore: unnecessary_null_comparison
                                      if (selectedZone != null &&
                                          selectedZone.id != null) {
                                        controller.categoryyIds.value =
                                            newValue.toString();
                                        controller.categooryId = selectedZone
                                            .id; // category id is now set
                                      }
                                    }),
                              ),
                            ),
                          )),
                      //**********pricing**************** */
                      divider,
                      Row(
                        children: [
                          Text(
                            "Pricing",
                            style: kTitleTextstyle.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          gapWidth(size: 5.0.w),
                          Image.asset(
                            Img.tollIcon,
                            scale: 4,
                          ),
                        ],
                      ),

                      gapHeight(size: 10.0.h),
                      //
                      Text(
                        "Currency",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      gapHeight(size: 3.0.h),
                      //********Select Price Type*********
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Center(
                            child: DropdownButton(
                                alignment: Alignment.centerLeft,
                                value: controller.selectedCurrency.value.isEmpty
                                    ? null
                                    : controller.selectedCurrency.value,
                                isExpanded: true,
                                underline: SizedBox(),
                                hint: const Text("Choose you currency type"),
                                items:
                                    (controller.currency.value).map((mapValue) {
                                  return DropdownMenuItem(
                                    value: mapValue,
                                    child: Center(
                                        child: Text(mapValue.toString())),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  controller.selectedCurrency.value =
                                      newValue.toString();
                                  print(controller.selectedCurrency.value =
                                      newValue.toString());
                                }),
                          ),
                        ),
                      ),
                      gapHeight(size: 6.0.h),
                      //*********Price Text *************
                      Text(
                        "Price Type",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Center(
                            child: DropdownButton(
                                alignment: Alignment.centerLeft,
                                value:
                                    controller.selectedPriceType.value.isEmpty
                                        ? null
                                        : controller.selectedPriceType.value,
                                isExpanded: true,
                                underline: SizedBox(),
                                hint: const Text("Choose you price type"),
                                items: (controller.priceTypeList.value)
                                    .map((mapValue) {
                                  return DropdownMenuItem(
                                    value: mapValue,
                                    child: Center(
                                        child: Text(mapValue.toString())),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  controller.selectedPriceType.value =
                                      newValue.toString();
                                  print(controller.selectedPriceType.value =
                                      newValue.toString());
                                }),
                          ),
                        ),
                      ),
                      gapHeight(size: 6.0.h),

                      // ******************************* Price Text **************************** //
                      Text(
                        "Level",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Center(
                            child: DropdownButton(
                                alignment: Alignment.centerLeft,
                                value:
                                    controller.selectedLevelList.value.isEmpty
                                        ? null
                                        : controller.selectedLevelList.value,
                                isExpanded: true,
                                underline: SizedBox(),
                                hint: const Text("Choose you Level"),
                                items: (controller.levelList.value)
                                    .map((mapValue) {
                                  return DropdownMenuItem(
                                    value: mapValue,
                                    child: Center(
                                        child: Text(mapValue.toString())),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  controller.selectedLevelList.value =
                                      newValue.toString();
                                  print(controller.selectedLevelList.value =
                                      newValue.toString());
                                }),
                          ),
                        ),
                      ),
                      divider,
                      //*********Price Text *************
                      Text(
                        "Price",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        height: size.height / 14,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: Center(
                          child: CustomTextField(
                            fillColor: LightThemeColors.whiteColor,
                            hintText: "Price",
                            controller: controller.price.value,
                          ),
                        ),
                      ),
                      divider,
                      divider,
                      Row(
                        children: [
                          Text(
                            "Location",
                            style: kTitleTextstyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          gapWidth(size: 4.0.w),
                          Icon(
                            Icons.location_on,
                            size: 16.0,
                            color: LightThemeColors.grayColor,
                          )
                        ],
                      ),
                      gapHeight(size: 3.0.h),
                      InkWell(
                        onTap: () async {
                          controller.currentPosition = await controller
                              .locationService
                              .getCurrentLocation();
                          if (controller.currentPosition != null) {
                            Get.to(CustomerPickLocationView(
                                currentPosition: controller.currentPosition!));
                          } else {
                            print("please_get_current_loaction");
                          }
                        },
                        child: CustomTextField(
                          fillColor: LightThemeColors.whiteColor,
                          hintText: currentAddress ?? "Search Here",
                          controller: null,
                          readOnly: false,
                          isIcon: true,
                          icon: Img.searchIcon,
                        ),
                      ),
                      divider,
                      CustomButton(
                        bgColor: LightThemeColors.primaryColor,
                        ontap: () {
                          controller.customerCreateService(
                              selectedCategory?.id ?? 0,
                              controller.selectedCurrency.value,
                              controller.selectedPriceType.value,
                              controller.selectedLevelList.value);
                        },
                        widget: Text(
                          "Create",
                          style: kTitleTextstyle,
                        ),
                      ),
                      divider,
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
