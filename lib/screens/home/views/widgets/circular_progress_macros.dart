import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../services/responsive_sizer.dart';
import '../../../../values/app_colors.dart';

class CircularProgressMacros extends StatefulWidget {
  const CircularProgressMacros({
    super.key,
    required this.dailyGoal,
    required this.dailyProgress,
    required this.progressColor,
    required this.name,
  });

  final int dailyGoal;
  final int dailyProgress;
  final Color progressColor;
  final String name;

  @override
  CircularProgressMacrosState createState() => CircularProgressMacrosState();
}

class CircularProgressMacrosState extends State<CircularProgressMacros> {
  late double dailyProgress;

  @override
  void initState() {
    super.initState();
    calculateProgress();
  }

  void calculateProgress() {
    setState(() {
      dailyProgress = widget.dailyProgress / widget.dailyGoal;
    });
  }

  @override
  void didUpdateWidget(CircularProgressMacros oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dailyGoal != widget.dailyGoal ||
        oldWidget.dailyProgress != widget.dailyProgress) {
      calculateProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        widget.name,
        style: TextStyle(
            fontSize: ResponsiveSizer.moderateScale(12),
            fontWeight: FontWeight.w700,
            color: widget.progressColor),
      ),
      SizedBox(height: ResponsiveSizer.horizontalScale(6)),
      Stack(
        alignment: Alignment.center,
        children: [
          CircularPercentIndicator(
            radius: ResponsiveSizer.moderateScale(45),
            lineWidth: ResponsiveSizer.horizontalScale(6),
            percent: 1.0,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(widget.dailyProgress).toInt()}',
                  style: TextStyle(
                      fontSize: ResponsiveSizer.moderateScale(16),
                      fontWeight: FontWeight.w700,
                      color: AppColors.black),
                ),
                Text(
                  '/${(widget.dailyGoal).toInt()}g',
                  style: TextStyle(
                      fontSize: ResponsiveSizer.moderateScale(8),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            progressColor: AppColors.greyBackground,
            backgroundColor: AppColors.greyBackground,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          CircularPercentIndicator(
            radius: ResponsiveSizer.moderateScale(45),
            lineWidth: ResponsiveSizer.horizontalScale(6),
            percent: widget.dailyProgress / widget.dailyGoal,
            progressColor: widget.progressColor,
            backgroundColor: AppColors.greyBackground,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
      SizedBox(height: ResponsiveSizer.verticalScale(10)),
      Text(
        '${widget.dailyGoal - widget.dailyProgress}g left',
        style: TextStyle(
            fontSize: ResponsiveSizer.moderateScale(12),
            fontWeight: FontWeight.w400,
            color: AppColors.greyText),
      ),
    ]);
  }
}
