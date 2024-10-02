import 'package:flutter/material.dart';

import '../../../../services/responsive_sizer.dart';
import '../../../../values/app_colors.dart';

class HeartHealthyIndicator extends StatefulWidget {
  const HeartHealthyIndicator({
    super.key,
    required this.name,
    required this.maxLimit,
    required this.dailyUsed,
  });

  final int maxLimit;
  final int dailyUsed;
  final String name;

  @override
  State<HeartHealthyIndicator> createState() => _HeartHealthyIndicatorState();
}

class _HeartHealthyIndicatorState extends State<HeartHealthyIndicator> {
  static const _textStyle = TextStyle(
    color: AppColors.black,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    final verticalScale9 = ResponsiveSizer.verticalScale(9);
    final moderateScale10 = ResponsiveSizer.moderateScale(10);
    final verticalScale10 = ResponsiveSizer.verticalScale(10);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.name, style: _textStyle),
              Text('${widget.dailyUsed}/${widget.maxLimit}', style: _textStyle),
            ],
          ),
          SizedBox(height: verticalScale9),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(moderateScale10)),
            child: LinearProgressIndicator(
              value: widget.dailyUsed / widget.maxLimit,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              backgroundColor: AppColors.greyBackground,
              minHeight: verticalScale10,
            ),
          ),
        ],
      ),
    );
  }
}
