import 'package:caloriesgram/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../services/responsive_sizer.dart';

class CircularProgressCalories extends StatefulWidget {
  const CircularProgressCalories({
    super.key,
    required this.goal,
    required this.exercise,
    required this.food,
  });

  final double goal;
  final double exercise;
  final double food;

  @override
  CircularProgressCaloriesState createState() =>
      CircularProgressCaloriesState();
}

class CircularProgressCaloriesState extends State<CircularProgressCalories> {
  late double progressExercise;
  late double progressFood;

  @override
  void initState() {
    super.initState();
    calculateProgress();
  }

  void calculateProgress() {
    setState(() {
      progressExercise = widget.exercise / widget.goal;
      progressFood = (widget.exercise + widget.food) / widget.goal;
    });
  }

  @override
  void didUpdateWidget(CircularProgressCalories oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.goal != widget.goal ||
        oldWidget.exercise != widget.exercise ||
        oldWidget.food != widget.food) {
      calculateProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularPercentIndicator(
          radius: ResponsiveSizer.horizontalScale(52),
          lineWidth: ResponsiveSizer.horizontalScale(8),
          percent: 1.0,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(widget.goal - (widget.exercise + widget.food)).toInt()}',
                style: TextStyle(
                    fontSize: ResponsiveSizer.moderateScale(24),
                    fontWeight: FontWeight.w700),
              ),
              Text(
                'Remaining',
                style: TextStyle(
                    fontSize: ResponsiveSizer.moderateScale(12),
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          progressColor: AppColors.greyBackground,
          backgroundColor: AppColors.greyBackground,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        CircularPercentIndicator(
          radius: ResponsiveSizer.horizontalScale(52),
          lineWidth: ResponsiveSizer.horizontalScale(8),
          percent: progressFood,
          progressColor: AppColors.orangeFood,
          backgroundColor: Colors.transparent,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        CircularPercentIndicator(
          radius: ResponsiveSizer.horizontalScale(52),
          lineWidth: ResponsiveSizer.horizontalScale(8),
          percent: progressExercise,
          progressColor: AppColors.primaryColor,
          backgroundColor: Colors.transparent,
          circularStrokeCap: CircularStrokeCap.round,
        ),
      ],
    );
  }
}
