import 'package:flutter/material.dart';

import '../../../services/responsive_sizer.dart';
import '../../../values/app_colors.dart';
import 'charts/weight_chart.dart';

class WeightView extends StatelessWidget {
  const WeightView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        child: SizedBox(
          width: ResponsiveSizer.horizontalScale(298),
          height: ResponsiveSizer.verticalScale(198),
          child:  Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Weight',
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
                  child: WeightChart(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
