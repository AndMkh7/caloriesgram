import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../services/responsive_sizer.dart';
import '../../../values/app_colors.dart';
import 'widgets/circular_progress_calories.dart';

class CaloriesView extends StatelessWidget {
  const CaloriesView({super.key});

  @override
  Widget build(BuildContext context) {
    const totalGoal = 800.0;
    const totalExercise = 250.0;
    const totalFood = 200.0;
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
                  'Calories',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: ResponsiveSizer.moderateScale(18),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'Remaining = Goal-Food+Exercise ',
                  style: TextStyle(
                    color: AppColors.greyText,
                    fontSize: ResponsiveSizer.moderateScale(12),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircularProgressCalories(
                    goal: totalGoal,
                    exercise: totalExercise,
                    food: totalFood,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/trophy.svg'),
                          SizedBox(width: ResponsiveSizer.horizontalScale(17)),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Base Goal',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: ResponsiveSizer.moderateScale(10),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '$totalGoal',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: ResponsiveSizer.moderateScale(12),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                        ],
                      ),
                      SizedBox(height: ResponsiveSizer.verticalScale(7)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/carrot.svg'),
                          SizedBox(width: ResponsiveSizer.horizontalScale(12)),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Food',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: ResponsiveSizer.moderateScale(10),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '$totalFood',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: ResponsiveSizer.moderateScale(12),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                        ],
                      ),
                      SizedBox(height: ResponsiveSizer.verticalScale(7)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/fire.svg'),
                          SizedBox(width: ResponsiveSizer.horizontalScale(18)),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Exercise',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: ResponsiveSizer.moderateScale(10),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '$totalExercise ',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: ResponsiveSizer.moderateScale(12),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
