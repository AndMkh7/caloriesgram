import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../services/responsive_sizer.dart';
import '../../../../values/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        width: ResponsiveSizer.horizontalScale(62),
        height: ResponsiveSizer.verticalScale(21),
        color: AppColors.greyBackground,
        child: Center(
          child: Text(
            'Logo',
            style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: ResponsiveSizer.moderateScale(16)),
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: AppColors.yellow,
          borderRadius:
              BorderRadius.circular(ResponsiveSizer.moderateScale(20)),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSizer.horizontalScale(7)),
        child: Row(
          children: [
            const Text('Get Premium'),
            SizedBox(width: ResponsiveSizer.horizontalScale(4)),
            SvgPicture.asset(
              'assets/images/crown.svg',
              height: ResponsiveSizer.moderateScale(14),
            ),
          ],
        ),
      ),
      Container(
        width: ResponsiveSizer.horizontalScale(62),
        height: ResponsiveSizer.verticalScale(21),
        alignment: Alignment.centerRight,
        child: SvgPicture.asset(
          'assets/images/notification.svg',
          height: ResponsiveSizer.moderateScale(14),
        ),
      ),
    ]);
  }
}
