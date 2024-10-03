import 'package:caloriesgram/values/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/responsive_sizer.dart';

class BodyMeasurementsScreen extends StatefulWidget {
  const BodyMeasurementsScreen({super.key});

  @override
  BodyMeasurementsScreenState createState() => BodyMeasurementsScreenState();
}

class BodyMeasurementsScreenState extends State<BodyMeasurementsScreen> {
  String _selectedGender = 'Female';
  int _selectedYear = 2001;
  double _selectedWeight = 55;
  double _selectedHeight = 160;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<int> _years = List.generate(100, (index) => 2024 - index);
  final List<double> _weights = List.generate(150, (index) => 30.0 + index);
  final List<double> _heights = List.generate(100, (index) => 120.0 + index);

  String _currentlyOpenPicker = '';
  int _tempSelectedYear = 2001;
  String _tempSelectedGender = 'Female';
  double _tempSelectedWeight = 55;
  double _tempSelectedHeight = 160;

  void _togglePicker(String pickerType) {
    setState(() {
      if (_currentlyOpenPicker == pickerType) {
        _currentlyOpenPicker = '';
      } else {
        _currentlyOpenPicker = pickerType;
      }
    });
  }

  Widget _buildPicker(List<dynamic> items, int selectedIndex,
      ValueChanged<int> onSelectedItemChanged) {
    return SizedBox(
      height: ResponsiveSizer.verticalScale(200),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (_currentlyOpenPicker == 'gender') {
                    _selectedGender = _tempSelectedGender;
                  } else if (_currentlyOpenPicker == 'year') {
                    _selectedYear = _tempSelectedYear;
                  } else if (_currentlyOpenPicker == 'weight') {
                    _selectedWeight = _tempSelectedWeight;
                  } else if (_currentlyOpenPicker == 'height') {
                    _selectedHeight = _tempSelectedHeight;
                  }
                  _currentlyOpenPicker = '';
                });
              },
              child: Text("Done",
                  style: TextStyle(
                      fontSize: ResponsiveSizer.moderateScale(18),
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor)),
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: ResponsiveSizer.moderateScale(32),
              onSelectedItemChanged: onSelectedItemChanged,
              scrollController:
                  FixedExtentScrollController(initialItem: selectedIndex),
              children: items.map((item) => Text(item.toString())).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Measurements'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
              size: ResponsiveSizer.verticalScale(30)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: ResponsiveSizer.verticalScale(75)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveSizer.horizontalScale(16)),
          child: Card(
            elevation: ResponsiveSizer.verticalScale(4),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(ResponsiveSizer.moderateScale(12)),
            ),
            child: Padding(
              padding: EdgeInsets.all(ResponsiveSizer.verticalScale(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMeasurementRow('Sex', _selectedGender, () {
                    _tempSelectedGender = _selectedGender;
                    _togglePicker('gender');
                  }),
                  if (_currentlyOpenPicker == 'gender')
                    _buildPicker(
                      _genders,
                      _genders.indexOf(_selectedGender),
                      (index) =>
                          setState(() => _tempSelectedGender = _genders[index]),
                    ),
                  _buildMeasurementRow(
                      'Year of birth', _selectedYear.toString(), () {
                    _tempSelectedYear = _selectedYear;
                    _togglePicker('year');
                  }),
                  if (_currentlyOpenPicker == 'year')
                    _buildPicker(
                      _years,
                      _years.indexOf(_selectedYear),
                      (index) =>
                          setState(() => _tempSelectedYear = _years[index]),
                    ),
                  _buildMeasurementRow(
                      'Weight', '${_selectedWeight.toStringAsFixed(1)} kg', () {
                    _tempSelectedWeight = _selectedWeight;
                    _togglePicker('weight');
                  }),
                  if (_currentlyOpenPicker == 'weight')
                    _buildPicker(
                      _weights,
                      _weights.indexOf(_selectedWeight),
                      (index) =>
                          setState(() => _tempSelectedWeight = _weights[index]),
                    ),
                  _buildMeasurementRow(
                      'Height', '${_selectedHeight.toStringAsFixed(1)} cm', () {
                    _tempSelectedHeight = _selectedHeight;
                    _togglePicker('height');
                  }),
                  if (_currentlyOpenPicker == 'height')
                    _buildPicker(
                      _heights,
                      _heights.indexOf(_selectedHeight),
                      (index) =>
                          setState(() => _tempSelectedHeight = _heights[index]),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMeasurementRow(String title, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: ResponsiveSizer.verticalScale(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _getIconForTitle(title),
                SizedBox(width: ResponsiveSizer.horizontalScale(18)),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: ResponsiveSizer.moderateScale(14),
                      fontWeight: FontWeight.w400,
                      color: AppColors.black),
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: ResponsiveSizer.moderateScale(14),
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIconForTitle(String title) {
    switch (title) {
      case 'Sex':
        return Container(
          height: ResponsiveSizer.verticalScale(20),
          width: ResponsiveSizer.horizontalScale(20),
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/images/sex.svg',
              width: ResponsiveSizer.horizontalScale(24),
              height: ResponsiveSizer.verticalScale(24)),
        );
      case 'Year of birth':
        return Container(
          height: ResponsiveSizer.verticalScale(20),
          width: ResponsiveSizer.horizontalScale(20),
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/images/cake.svg',
              width: ResponsiveSizer.horizontalScale(24),
              height: ResponsiveSizer.verticalScale(24)),
        );
      case 'Weight':
        return Container(
          height: ResponsiveSizer.verticalScale(20),
          width: ResponsiveSizer.horizontalScale(20),
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/images/scale.svg',
              width: ResponsiveSizer.horizontalScale(24),
              height: ResponsiveSizer.verticalScale(24)),
        );
      case 'Height':
        return Container(
          height: ResponsiveSizer.verticalScale(20),
          width: ResponsiveSizer.horizontalScale(20),
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/images/height.svg',
              width: ResponsiveSizer.horizontalScale(24),
              height: ResponsiveSizer.verticalScale(24)),
        );
      default:
        return Icon(Icons.info, size: ResponsiveSizer.horizontalScale(24));
    }
  }
}
