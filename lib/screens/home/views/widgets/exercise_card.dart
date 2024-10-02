import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../services/responsive_sizer.dart';
import '../../../../values/app_colors.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: ResponsiveSizer.verticalScale(106),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 14, top: 10, bottom: 10, right: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exercise',
                style: TextStyle(
                    fontSize: ResponsiveSizer.moderateScale(14),
                    fontWeight: FontWeight.w700,
                    color: AppColors.black),
              ),
              SizedBox(height: ResponsiveSizer.verticalScale(16)),
              Column(
                children: [
                  Row(children: [
                    SvgPicture.asset(
                      'assets/images/fire.svg',
                      height: ResponsiveSizer.verticalScale(26),
                    ),
                    SizedBox(
                      width: ResponsiveSizer.horizontalScale(16),
                    ),
                    Text(
                      '1.600 cal',
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(12),
                          fontWeight: FontWeight.w700,
                          color: AppColors.black),
                    ),
                  ]),
                  SizedBox(height: ResponsiveSizer.verticalScale(6)),
                  Row(children: [
                    SvgPicture.asset(
                      'assets/images/clock.svg',
                      height: ResponsiveSizer.verticalScale(26),
                    ),
                    SizedBox(
                      width: ResponsiveSizer.horizontalScale(11),
                    ),
                    Text(
                      '00:25 hr',
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(12),
                          fontWeight: FontWeight.w700,
                          color: AppColors.black),
                    ),
                  ])
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
