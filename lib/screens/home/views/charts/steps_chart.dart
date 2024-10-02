import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../services/responsive_sizer.dart';
import '../../../../values/app_colors.dart';

class StepsChart extends StatelessWidget {
  const StepsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        width: ResponsiveSizer.horizontalScale(280),
        height: ResponsiveSizer.verticalScale(140),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 200,
                  getTitlesWidget: (value, meta) => Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ResponsiveSizer.moderateScale(8),
                    ),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Text('JAN',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ResponsiveSizer.moderateScale(8)));
                      case 1:
                        return Text('FEB',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ResponsiveSizer.moderateScale(8)));
                      case 2:
                        return Text('MAR',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ResponsiveSizer.moderateScale(8)));
                      case 3:
                        return Text('APR',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ResponsiveSizer.moderateScale(8)));
                      case 4:
                        return Text('MEI',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ResponsiveSizer.moderateScale(8)));
                      case 5:
                        return Text('JUN',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ResponsiveSizer.moderateScale(8)));
                      case 6:
                        return Text('JUL',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ResponsiveSizer.moderateScale(8)));
                      default:
                        return const Text('');
                    }
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: const FlGridData(
              show: true,
              drawVerticalLine: true,
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(
                  color: Color(0xff37434d),
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Color(0xff37434d),
                  width: 1,
                ),
              ),
            ),
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: 1000,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 480),
                  const FlSpot(1, 850),
                  const FlSpot(2, 785),
                  const FlSpot(3, 321),
                  const FlSpot(4, 554),
                  const FlSpot(5, 875),
                  const FlSpot(6, 455),
                ],
                isCurved: false,
                color: AppColors.stepsCartColor,
                barWidth: ResponsiveSizer.horizontalScale(2),
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.stepsCartColor.withOpacity(0.39),
                ),
                dotData: const FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
