import 'package:caloriesgram/values/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/responsive_sizer.dart';
import 'language_list.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => LanguageScreenState();
}

class LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: ResponsiveSizer.verticalScale(130),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(ResponsiveSizer.moderateScale(30)),
                  bottomRight:
                      Radius.circular(ResponsiveSizer.moderateScale(30)),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: ResponsiveSizer.verticalScale(20),
                    left: ResponsiveSizer.horizontalScale(10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context, selectedLanguage);
                      },
                      icon: Icon(Icons.keyboard_arrow_left,
                          color: AppColors.white,
                          size: ResponsiveSizer.moderateScale(30)),
                    ),
                  ),
                  Positioned(
                    bottom: ResponsiveSizer.verticalScale(25),
                    left: ResponsiveSizer.horizontalScale(0),
                    right: ResponsiveSizer.horizontalScale(0),
                    child: Center(
                        child: Text('Language',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: ResponsiveSizer.moderateScale(22),
                              fontWeight: FontWeight.w600,
                            ))),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: ResponsiveSizer.horizontalScale(20),
                  right: ResponsiveSizer.horizontalScale(20),
                  top: ResponsiveSizer.verticalScale(20),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Suggested',
                        style: TextStyle(
                            fontSize: ResponsiveSizer.moderateScale(14),
                            fontWeight: FontWeight.w600,
                            color: AppColors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Column(
                      children: suggestedLanguages.map((language) {
                        return RadioListTile<String>(
                          title: Text(language),
                          value: language,
                          activeColor: AppColors.primaryColor,
                          fillColor:
                              WidgetStateProperty.all(AppColors.primaryColor),
                          hoverColor: AppColors.red,
                          groupValue: selectedLanguage,
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        );
                      }).toList(),
                    ),
                    Divider(
                      color: AppColors.greyBackground,
                      height: ResponsiveSizer.verticalScale(52),
                      thickness: 1,
                      endIndent: 40,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Others',
                        style: TextStyle(
                            fontSize: ResponsiveSizer.moderateScale(14),
                            fontWeight: FontWeight.w400,
                            color: AppColors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: otherLanguages.length,
                        itemBuilder: (context, index) {
                          return RadioListTile<String>(
                            title: Text(otherLanguages[index]),
                            value: otherLanguages[index],
                            activeColor: AppColors.primaryColor,
                            fillColor:
                                WidgetStateProperty.all(AppColors.primaryColor),
                            hoverColor: AppColors.red,
                            groupValue: selectedLanguage,
                            onChanged: (value) {
                              setState(() {
                                selectedLanguage = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.trailing,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
