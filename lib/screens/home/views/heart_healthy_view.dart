import 'package:flutter/material.dart';
import '../../../services/responsive_sizer.dart';
import '../../../values/app_colors.dart';
import 'widgets/heart_health_indicator.dart';

class HeartHealthyView extends StatelessWidget {
  const HeartHealthyView({super.key});

  static const _heartHealthyData = [
    {'name': 'Fat', 'maxLimit': 237, 'dailyUsed': 160},
    {'name': 'Sodium', 'maxLimit': 256, 'dailyUsed': 142},
    {'name': 'Cholesterol', 'maxLimit': 286, 'dailyUsed': 96},
  ];

  //TODO: Here we can get data form API or use users phone data for showing his heart healthy data

  static const _textStyle = TextStyle(
    color: AppColors.black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        child: SizedBox(
          width: ResponsiveSizer.horizontalScale(298),
          height: ResponsiveSizer.verticalScale(198),
          child: Column(
            children: [
              const ListTile(
                title: Text('Heart Healthy', style: _textStyle),
              ),
              ..._heartHealthyData.map((data) => HeartHealthyIndicator(
                    name: data['name'] as String,
                    maxLimit: data['maxLimit'] as int,
                    dailyUsed: data['dailyUsed'] as int,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
