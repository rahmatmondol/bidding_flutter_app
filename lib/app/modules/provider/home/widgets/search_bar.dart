// search_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../description/views/description_view.dart';
import '../controllers/home_controller.dart';

class ServiceSearchWidget extends GetView<HomeController> {
  const ServiceSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar with filter button
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.searchController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search Your Service",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey[400]),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.r, vertical: 12.r),
                        ),
                        onChanged: (value) {
                          controller.filterServices(value);
                          controller.update();
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: LightThemeColors.primaryColor,
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(8.r)),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.filter_list, color: Colors.white),
                        onPressed: () {
                          controller.toggleFilterOptions();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Filter options and search results
        GetBuilder<HomeController>(
          builder: (controller) => Column(
            children: [
              // Filter options
              if (controller.showFilterOptions.value)
                Container(
                  margin: EdgeInsets.only(top: 8.r),
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Filters:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.clearFilters();
                              controller.update();
                            },
                            child: Text('Clear All',
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),
                      _buildFilterSection(
                          'Status:',
                          controller.availableStatuses,
                          controller.selectedStatuses),
                      _buildFilterSection(
                          'Currency:',
                          controller.availableCurrencies,
                          controller.selectedCurrencies),
                      _buildFilterSection('Level:', controller.availableLevels,
                          controller.selectedLevels),
                      _buildFilterSection(
                          'Price Type:',
                          controller.availablePriceTypes,
                          controller.selectedPriceTypes),
                    ],
                  ),
                ),

              // Search results - only show when searching
              if (controller.searchController.text.isNotEmpty)
                Column(
                  children: [
                    // Loading indicator
                    if (controller.isSearching.value)
                      Padding(
                        padding: EdgeInsets.all(8.r),
                        child: CircularProgressIndicator(),
                      ),

                    // No results message
                    if (!controller.isSearching.value &&
                        controller.searchResults.isEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 8.r),
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            'No results found',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                    // Search results list
                    if (!controller.isSearching.value &&
                        controller.searchResults.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 8.r),
                        constraints: BoxConstraints(maxHeight: 300.h),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.searchResults.length,
                          itemBuilder: (context, index) {
                            final service = controller.searchResults[index];
                            return ListTile(
                              title: Text(
                                service.title ?? 'N/A',
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.description ?? 'N/A',
                                    style: TextStyle(color: Colors.grey[400]),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${service.location ?? 'N/A'} | ${service.currency ?? ''} ${service.price?.toString() ?? 'N/A'}',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 12),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Get.to(() => DescriptionView(service));
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection(
      String title, RxList<String> options, RxSet<String> selectedOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.white)),
        SizedBox(height: 8.r),
        Wrap(
          spacing: 8.r,
          children: options
              .map((option) => GetBuilder<HomeController>(
                    builder: (controller) => FilterChip(
                      label: Text(option),
                      selected: selectedOptions.contains(option),
                      onSelected: (bool selected) {
                        controller.toggleFilter(option, selectedOptions);
                        controller.update();
                      },
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 16.r),
      ],
    );
  }
}
