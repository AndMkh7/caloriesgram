import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../services/responsive_sizer.dart';
import '../../../../values/app_colors.dart';

class StepsCard extends StatelessWidget {
  const StepsCard({super.key});

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
                'Steps',
                style: TextStyle(
                    fontSize: ResponsiveSizer.moderateScale(14),
                    fontWeight: FontWeight.w700,
                    color: AppColors.black),
              ),
              SizedBox(
                height: ResponsiveSizer.verticalScale(5),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/step.svg',
                    height: 26,
                  ),
                  const SizedBox(width: 11),
                  Text(
                    '1.600',
                    style: TextStyle(
                        fontSize: ResponsiveSizer.moderateScale(12),
                        fontWeight: FontWeight.w700,
                        color: AppColors.black),
                  ),
                ],
              ),
              SizedBox(
                height: ResponsiveSizer.verticalScale(5),
              ),
              Text(
                'Goal: 10.000 steps',
                style: TextStyle(
                    fontSize: ResponsiveSizer.moderateScale(10),
                    fontWeight: FontWeight.w400,
                    color: AppColors.black),
              ),
              SizedBox(
                height: ResponsiveSizer.verticalScale(9),
              ),
              const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: 0.16,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.red),
                  backgroundColor: AppColors.greyBackground,
                  minHeight: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
