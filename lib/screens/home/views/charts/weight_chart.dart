import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../services/responsive_sizer.dart';
import '../../../../values/app_colors.dart';

class WeightChart extends StatelessWidget {
  const WeightChart({super.key});

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
                  interval: 20,
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
                        return const Text('JAN',
                            style: TextStyle(color: Colors.grey, fontSize: 8));
                      case 1:
                        return const Text('FEB',
                            style: TextStyle(color: Colors.grey, fontSize: 8));
                      case 2:
                        return const Text('MAR',
                            style: TextStyle(color: Colors.grey, fontSize: 8));
                      case 3:
                        return const Text('APR',
                            style: TextStyle(color: Colors.grey, fontSize: 8));
                      case 4:
                        return const Text('MEI',
                            style: TextStyle(color: Colors.grey, fontSize: 8));
                      case 5:
                        return const Text('JUN',
                            style: TextStyle(color: Colors.grey, fontSize: 8));
                      case 6:
                        return const Text('JUL',
                            style: TextStyle(color: Colors.grey, fontSize: 8));
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
            maxY: 120,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 48),
                  const FlSpot(1, 57),
                  const FlSpot(2, 69),
                  const FlSpot(3, 74),
                  const FlSpot(4, 55),
                  const FlSpot(5, 89),
                  const FlSpot(6, 57),
                ],
                isCurved: false,
                color: AppColors.weightCartLine,
                barWidth: 2,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.weightCartColor,
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
