import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/proposals_controller.dart';

// proposals_view.dart
class ProposalsView extends GetView<ProposalsController> {
  const ProposalsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 0,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          children: [
            CustomHeaderBar(title: 'My Proposals'),
            gapHeight(size: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.bids.isEmpty) {
                  return const Center(child: Text('No proposals found'));
                }

                return RefreshIndicator(
                  onRefresh: () => controller.fetchBids(),
                  child: ListView.builder(
                    itemCount: controller.bids.length,
                    itemBuilder: (context, index) {
                      final bid = controller.bids[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 20.r),
                        child: ProposalCard(
                          name: bid.amount.toString(),
                          date: bid.createdAt.toString(),
                          duration: bid.createdAt.toString(),
                          status: bid.status.capitalizeFirst ?? 'Unknown',
                          ontap: () {
                            // Handle tap
                          },
                        ),
                      );
                    },
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class ProposalCard extends StatelessWidget {
  final String name;
  final String date;
  final String duration;
  final String status;
  final VoidCallback ontap;

  const ProposalCard({
    super.key,
    required this.name,
    required this.date,
    required this.duration,
    required this.status,
    required this.ontap,
  });

  Color _getStatusColor(String status) {
    return switch (status.toLowerCase()) {
      'pending' => Colors.orange,
      'accepted' => Colors.green,
      'completed' => LightThemeColors.primaryColor,
      _ => Colors.grey,
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kTitleTextstyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapHeight(size: 5),
                    Row(
                      children: [
                        Text(
                          date,
                          style: kSubtitleStyle,
                        ),
                        gapWidth(size: 10),
                        Expanded(
                          child: Text(
                            duration,
                            style: kSubtitleStyle.copyWith(
                              fontSize: 10.sp,
                              color: LightThemeColors.secounderyTextColor,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Text(
                status,
                style: kSubtitleStyle.copyWith(
                  color: _getStatusColor(status),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Divider(thickness: 2),
        ],
      ),
    );
  }
}
