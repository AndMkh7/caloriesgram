import 'package:caloriesgram/values/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:caloriesgram/services/firestore.dart';

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
  late String _tempSelectedGender;
  late int _tempSelectedYear;
  late double _tempSelectedWeight;
  late double _tempSelectedHeight;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _tempSelectedGender = _selectedGender;
    _tempSelectedYear = _selectedYear;
    _tempSelectedWeight = _selectedWeight;
    _tempSelectedHeight = _selectedHeight;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await _firestoreService.getUserData();
    if (userData != null) {
      setState(() {
        _selectedGender = userData['sex'] ?? 'Female';
        _selectedYear = userData['yearOfBirth'] ?? 2001;
        _selectedWeight = userData['weight'] ?? 55;
        _selectedHeight = userData['height'] ?? 160;

        _tempSelectedGender = _selectedGender;
        _tempSelectedYear = _selectedYear;
        _tempSelectedWeight = _selectedWeight;
        _tempSelectedHeight = _selectedHeight;
      });
    }
  }

  Future<void> _updateUserData() async {
    await _firestoreService.updateUserData({
      'sex': _selectedGender,
      'yearOfBirth': _selectedYear,
      'weight': _selectedWeight,
      'height': _selectedHeight,
    });
  }

  void _togglePicker(String pickerType) {
    setState(() {
      _currentlyOpenPicker =
          (_currentlyOpenPicker == pickerType) ? '' : pickerType;
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
                  _updateSelectedData();
                  _updateUserData();
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
              children: items.map((item) {
                return Center(
                  child: Text(
                    item.toString(),
                    style: TextStyle(
                      fontSize: ResponsiveSizer.moderateScale(16),
                      color: AppColors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _updateSelectedData() {
    switch (_currentlyOpenPicker) {
      case 'gender':
        _selectedGender = _tempSelectedGender;
        break;
      case 'year':
        _selectedYear = _tempSelectedYear;
        break;
      case 'weight':
        _selectedWeight = _tempSelectedWeight;
        break;
      case 'height':
        _selectedHeight = _tempSelectedHeight;
        break;
    }
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
    final iconPaths = {
      'Sex': 'assets/images/sex.svg',
      'Year of birth': 'assets/images/cake.svg',
      'Weight': 'assets/images/scale.svg',
      'Height': 'assets/images/height.svg',
    };

    return Container(
      height: ResponsiveSizer.verticalScale(20),
      width: ResponsiveSizer.horizontalScale(20),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        iconPaths[title] ?? '',
        width: ResponsiveSizer.horizontalScale(24),
        height: ResponsiveSizer.verticalScale(24),
      ),
    );
  }
}
