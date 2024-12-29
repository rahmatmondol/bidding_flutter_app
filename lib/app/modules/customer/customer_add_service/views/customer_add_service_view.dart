// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison, unused_local_variable, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/app/modules/customer/customer_pick_location/views/customer_pick_location_view.dart';
import 'package:dirham_uae/app/modules/provider/home/controllers/home_controller.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import '../../../../../config/theme/my_images.dart';
import '../../../../../utils/global_variable/divider.dart';
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
          final catrgory =
              (homeC.getCategoriesDataModel.value.data?.category ?? [])
                  .firstWhere((c) => c.id == c.id); // Ch
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
                      divider,
                      Text(
                        "Create a Service",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      divider,
                      divider,
                      Text("Service Name",
                          style: kTitleTextstyle.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                      CustomTextField(
                        fillColor: LightThemeColors.scaffoldBackgroundColor,
                        hintText: "Enter Your First name",
                        controller: controller.name.value,
                      ),
                      divider,
                      // *************************
                      // Container(
                      //   height: size.height / 5.5,
                      //   decoration: BoxDecoration(
                      //     color: LightThemeColors.grayColor,
                      //     borderRadius: BorderRadius.circular(5),
                      //   ),
                      //   child: controller.images == null
                      //       ? Center(
                      //           child: Text("Add Images"),
                      //         )
                      //       : ListView.builder(
                      //           scrollDirection: Axis.horizontal,
                      //           itemCount: controller.images!.length,
                      //           itemBuilder: (context, int index) {
                      //             return Padding(
                      //               padding: const EdgeInsets.only(right: 10.0),
                      //               child: ClipRRect(
                      //                 borderRadius: BorderRadius.circular(15),
                      //                 child: Image.file(
                      //                   File(controller.images![index].path
                      //                       .toString()),
                      //                   height: 150,
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //         ),
                      // ),

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
                                catrgory.id!.toInt(),
                                controller.selectedCurrency.value,
                                controller.selectedPriceType.value,
                                controller.selectedLevelList.value);
                          } else {
                            print('dvgfcvgebvvbcudebvcudvuvvcdbv');
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

                      // controller.images == null
                      //     ? Container(
                      //         height: size.height / 5.5,
                      //         decoration: BoxDecoration(
                      //             color: LightThemeColors.grayColor,
                      //             borderRadius: BorderRadius.circular(5)),
                      //         child: Center(
                      //           child: Text("Add Image's"),
                      //         ),
                      //       )
                      //     : ListView.builder(
                      //         scrollDirection: Axis.horizontal,
                      //         itemCount: controller.images!.length,
                      //         itemBuilder: (context, int index) {
                      //           return Padding(
                      //             padding: const EdgeInsets.only(right: 10.0),
                      //             child: ClipRRect(
                      //               borderRadius: BorderRadius.circular(15),
                      //               child: Image.file(
                      //                 File(controller.images![index].path),
                      //                 height: 150,
                      //               ),
                      //             ),
                      //           );
                      //         }),

                      // divider,
                      // InkWell(
                      //   onTap: () {
                      //     // showMyBottomSheet(
                      //     //     context: context, controller: controller);
                      //     controller.pickMultiImage();
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(
                      //         vertical: 15.r, horizontal: 20),
                      //     decoration: BoxDecoration(
                      //       color: LightThemeColors.secounderyColor,
                      //       borderRadius: BorderRadius.circular(20.r),
                      //       // border: BorderRadius.all(),
                      //     ),
                      //     child: Center(child: Text("Add Photos")),
                      //   ),
                      // ),

                      divider,
                      Text(" Service Description",
                          style: kTitleTextstyle.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                      //
                      gapHeight(size: 2.0.h),
                      Container(
                        height: size.height * 0.60,
                        //height: 200.0,
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: Column(
                          children: [
                            ToolBar(
                              toolBarColor: Colors.white,
                              activeIconColor: Colors.green,
                              padding: const EdgeInsets.all(8),
                              iconSize: 25,
                              controller: controller.description.value,
                            ),
                            QuillHtmlEditor(
                              textStyle:
                                  TextStyle(color: LightThemeColors.whiteColor),
                              backgroundColor: LightThemeColors.secounderyColor,
                              hintText: 'Hint text goes here',
                              controller: controller.description.value,
                              isEnabled: true,
                              ensureVisible: false,
                              minHeight: 300,
                              hintTextAlign: TextAlign.start,
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              hintTextPadding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: size.height * 0.30,
                      //   decoration: BoxDecoration(
                      //       color: LightThemeColors.secounderyColor,
                      //       borderRadius: BorderRadius.circular(8.0.r)),
                      //   child: HtmlEditor(
                      //     controller: controller.description,
                      //     htmlEditorOptions: HtmlEditorOptions(
                      //       shouldEnsureVisible: true,
                      //       hint: "write a describe your service",
                      //       spellCheck: true,
                      //       autoAdjustHeight: true,
                      //       adjustHeightForKeyboard: true,
                      //     ),
                      //     htmlToolbarOptions: HtmlToolbarOptions(
                      //       textStyle:
                      //           TextStyle(color: LightThemeColors.whiteColor),
                      //       toolbarPosition: ToolbarPosition.aboveEditor,
                      //       buttonColor: LightThemeColors.whiteColor,
                      //     ),
                      //   ),
                      // ),
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
                      // *****************
                      Container(
                        height: size.height / 5,
                        //height: 200.0,
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // TypeAheadField(
                              //   textFieldConfiguration: TextFieldConfiguration(
                              //     style: TextStyle(
                              //         color: LightThemeColors.whiteColor),
                              //     controller: controller.skill.value,
                              //     onEditingComplete: () {
                              //       if (controller.ListTags.length < 5) {
                              //         controller.ListTags.add(
                              //             controller.skill.value.text);
                              //         print(controller.skill.value.text);
                              //       }
                              //       controller.skill.value.clear();
                              //     },
                              //     autofocus: false,
                              //     decoration: InputDecoration(
                              //         border: UnderlineInputBorder(
                              //             borderSide: BorderSide.none),
                              //         hintText: 'add your five skill'),
                              //   ),
                              //   suggestionsCallback: (pattern) {
                              //     return controller.suggestList
                              //         .where((element) => false);
                              //   },
                              //   itemBuilder: (context, itemData) {
                              //     return ListTile(
                              //       leading: Icon(Icons.tag),
                              //       title: Text(itemData),
                              //     );
                              //   },
                              //   onSuggestionSelected: (suggestion) {
                              //     controller.ListTags.add(suggestion);
                              //     print("${suggestion}");
                              //   }, onSelected: (Object? value) {  },
                              // ),
                              controller.ListTags.length == 0
                                  ? Center(child: Text('No tag selected'))
                                  : Wrap(
                                      children: controller.ListTags.map(
                                          (element) => Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4),
                                                child: Chip(
                                                  backgroundColor:
                                                      LightThemeColors
                                                          .grayColor,
                                                  label: Text(element!),
                                                  deleteIcon: Icon(Icons.clear),
                                                  onDeleted: () {
                                                    controller.ListTags.remove(
                                                        element);
                                                  },
                                                ),
                                              )).toList(),
                                    )
                            ],
                          ),
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
                                value: controller.selectedCategory.value.isEmpty
                                    ? null
                                    : controller.selectedCategory.value,
                                isExpanded: true,
                                underline: SizedBox(),
                                hint: const Text("Choose you categories type"),
                                items: (homeC.getCategoriesDataModel.value.data
                                        ?.category)
                                    ?.map((mapValue) {
                                  return DropdownMenuItem(
                                    value: mapValue.name.toString(),
                                    child: Center(
                                        child: Text(mapValue.name.toString())),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  final categories = (homeC
                                              .getCategoriesDataModel
                                              .value
                                              .data
                                              ?.category ??
                                          [])
                                      .firstWhere((category) =>
                                          category.name == newValue);

                                  // Check if the selected zone is not null and has an ID
                                  if (categories != null &&
                                      categories.id != null) {
                                    controller.selectedCategory.value =
                                        newValue.toString();
                                    print(controller.selectedCategory.value =
                                        newValue.toString());
                                  }
                                }),
                          ),
                        ),
                      ),
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
                              catrgory.id!.toInt(),
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
