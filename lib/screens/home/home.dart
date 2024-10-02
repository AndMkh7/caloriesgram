import 'package:flutter/material.dart';

import '../../services/responsive_sizer.dart';
import 'views/calories_view.dart';
import 'views/heart_healthy_view.dart';
import 'views/macros_view.dart';
import 'views/steps_view.dart';
import 'views/weight_view.dart';
import 'views/widgets/exercise_card.dart';
import 'views/widgets/header.dart';
import 'views/widgets/page_indicator.dart';
import 'views/widgets/steps_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage1 = 0;
  int _currentPage2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top +
                ResponsiveSizer.verticalScale(10),
            left: ResponsiveSizer.horizontalScale(32),
            right: ResponsiveSizer.horizontalScale(32)),
        child: Column(
          children: [
            const Header(),
            Container(
              padding: EdgeInsets.only(
                  top: ResponsiveSizer.verticalScale(4),
                  bottom: ResponsiveSizer.verticalScale(17)),
              alignment: Alignment.centerLeft,
              child: Text(
                'Today',
                style: TextStyle(
                    fontSize: ResponsiveSizer.moderateScale(24),
                    fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage1 = page;
                  });
                },
                children: const [
                  CaloriesView(),
                  MacrosView(),
                  HeartHealthyView(),
                ],
              ),
            ),
            SizedBox(height: ResponsiveSizer.verticalScale(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Indicator(_currentPage1 == 0),
                Indicator(_currentPage1 == 1),
                Indicator(_currentPage1 == 2),
              ],
            ),
            SizedBox(height: ResponsiveSizer.verticalScale(32)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: StepsCard()),
                SizedBox(width: ResponsiveSizer.horizontalScale(16)),
                const Expanded(child: ExerciseCard()),
              ],
            ),
            SizedBox(height: ResponsiveSizer.verticalScale(32)),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage2 = page;
                  });
                },
                children: const [
                  WeightView(),
                  StepsView(),
                ],
              ),
            ),
            SizedBox(height: ResponsiveSizer.verticalScale(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Indicator(_currentPage2 == 0),
                Indicator(_currentPage2 == 1),
              ],
            ),
            SizedBox(height: ResponsiveSizer.verticalScale(16)),
          ],
        ),
      ),
    );
  }
}
