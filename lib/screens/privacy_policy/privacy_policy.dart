import 'package:caloriesgram/values/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/responsive_sizer.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.keyboard_arrow_left,
                          color: AppColors.white,
                          size: ResponsiveSizer.moderateScale(30)),
                    ),
                  ),
                  Positioned(
                    bottom: ResponsiveSizer.verticalScale(25),
                    left: 0,
                    right: 0,
                    child: Center(
                        child: Text('Privacy Policy',
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
              child: SingleChildScrollView(
                padding: EdgeInsets.all(ResponsiveSizer.horizontalScale(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1. Types data we collect",
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(18),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(32)),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.",
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(16),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(32)),
                    Text(
                      "2. Use of your personal data",
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(18),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(32)),
                    Text(
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.\n\nNemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.\n\nAt vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.\n\nEt harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.\n\nTemporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus.",
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(16),
                          fontWeight: FontWeight.w500),
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
