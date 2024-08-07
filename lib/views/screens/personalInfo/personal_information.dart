import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/views/screens/personalInfo/widget/employer_relevant_information.dart';
import 'package:optly/views/screens/personalInfo/widget/occupation.dart';
import 'package:optly/views/screens/personalInfo/widget/other_activities.dart';
import 'package:optly/views/screens/personalInfo/widget/social_insurance.dart';
import 'package:optly/views/screens/personalInfo/widget/tax.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';

import '../../../controller/profile_controller.dart';
import 'widget/personal_info.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {

   final _profileController = Get.put(ProfileController());
  @override
  void initState() {
    _profileController.getProfile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("information".tr),
      ),
      body: Obx(()=> _profileController.loading.value
            ? const CustomPageLoading():
         SingleChildScrollView(
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
                height: 25.h,
              ),
              _headerText("other_activities"),
              OtherActivities(),
              SizedBox(
                height: 25.h,
              ),
              _headerText("employer_relevant_information",Colors.green),
        
              EmployerRelevantInformation(),
        
              SizedBox(
                height: 35.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _headerText(String title, [Color? color]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.tr,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: color ?? AppColors.primaryColor),
        ),
        Divider(
          color: color ?? AppColors.primaryColor,
        )
      ],
    );
  }
}
