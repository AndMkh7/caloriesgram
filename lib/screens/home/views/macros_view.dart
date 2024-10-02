import 'package:flutter/material.dart';

import '../../../services/responsive_sizer.dart';
import '../../../values/app_colors.dart';
import 'widgets/circular_progress_macros.dart';

class MacrosView extends StatelessWidget {
  const MacrosView({super.key});

  static const _macrosData = [
    {
      'name': 'Carbohydrates',
      'dailyGoal': 237,
      'dailyProgress': 111,
      'progressColor': AppColors.primaryColor
    },
    {
      'name': 'Fat',
      'maxLimit': 63,
      'dailyUsed': 43,
      'progressColor': AppColors.purple
    },
    {
      'name': 'Protein',
      'maxLimit': 93,
      'dailyUsed': 66,
      'progressColor': AppColors.orangeProtein
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        child: SizedBox(
          width: ResponsiveSizer.horizontalScale(298),
          height: ResponsiveSizer.verticalScale(198),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Macros',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: ResponsiveSizer.moderateScale(18),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _macrosData.map((data) {
                    int goal;
                    int progress;
                    if (data.containsKey('dailyGoal')) {
                      goal = data['dailyGoal'] as int;
                      progress = data['dailyProgress'] as int;
                    } else {
                      goal = data['maxLimit'] as int;
                      progress = data['dailyUsed'] as int;
                    }
                    return CircularProgressMacros(
                      name: data['name'] as String,
                      dailyGoal: goal,
                      dailyProgress: progress,
                      progressColor: data['progressColor'] as Color,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
