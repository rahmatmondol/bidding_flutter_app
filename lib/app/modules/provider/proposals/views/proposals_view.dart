import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/proposals_controller.dart';

class ProposalsView extends GetView<ProposalsController> {
  const ProposalsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          children: [
            Center(
              child: Text(
                'My Proposals',
                style: kTitleTextstyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            gapHeight(size: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 20.r),
                    child: ProposalCard(
                      name: "Car Painting & Decoration",
                      date: "Sup 09,2023",
                      duration: "1 monthes Ago",
                      status: "Complited",
                      ontap: () {},
                    ),
                  );
                },
              ),
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
                        ))
                      ],
                    )
                  ],
                ),
              ),
              Text(
                status,
                style: kSubtitleStyle.copyWith(
                  color: LightThemeColors.primaryColor,
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
