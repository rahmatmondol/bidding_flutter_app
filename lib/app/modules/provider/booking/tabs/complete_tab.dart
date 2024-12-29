import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dirham_uae/app/components/booking_card.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';

class CompleteServiceTab extends StatelessWidget {
  const CompleteServiceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Complete Service (02)",
            style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          gapHeight(size: 10),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.r),
                  child: BookingCard(
                    size: size,
                    name: "Electronics & Gadgets Repair sjdf sldjfls fsdlfj",
                    location: "Cambodia",
                    description:
                        "Marketplace offers solution to all your desktop hardware and software related problems without you needing to get out of your ",
                    priceLevel: "Fixed Price- Entry level",
                    price: "200",
                    isButton: true,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
