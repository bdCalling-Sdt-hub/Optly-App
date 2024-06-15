import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/views/screens/personalInfo/widget/occupation.dart';
import 'package:optly/views/screens/personalInfo/widget/social_insurance.dart';
import 'package:optly/views/screens/personalInfo/widget/tax.dart';

import 'widget/personal_info.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("information".tr),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText("personal_information"),
            PersonalInfo(),
            SizedBox(
              height: 25.h,
            ),
            _headerText("occupation"),
            Occupation(),
            SizedBox(
              height: 25.h,
            ),
            _headerText("tax"),
             Tax(),
            SizedBox(
              height: 25.h,
            ),
            _headerText("social_insurance"),

            SocialInsurance(),

            SizedBox(
              height: 35.h,
            ),

          ],
        ),
      ),
    );
  }

  _headerText(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.tr,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppColors.primaryColor),
        ),
        Divider(
          color: AppColors.primaryColor,
        )
      ],
    );
  }
}
