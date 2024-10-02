import 'package:caloriesgram/screens/home/views/charts/steps_chart.dart';
import 'package:flutter/material.dart';

import '../../../services/responsive_sizer.dart';
import '../../../values/app_colors.dart';

class StepsView extends StatelessWidget {
  const StepsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        child: SizedBox(
          width: ResponsiveSizer.horizontalScale(298),
          height: ResponsiveSizer.verticalScale(198),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Steps',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: ResponsiveSizer.moderateScale(14),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: StepsChart(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
