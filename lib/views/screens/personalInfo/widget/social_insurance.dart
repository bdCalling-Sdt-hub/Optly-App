import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/views/screens/personalInfo/widget/personal_info.dart';

import '../../../../utils/app_colors.dart';

class SocialInsurance extends StatelessWidget {
   SocialInsurance({super.key});

  List<String> insuranceList=[
    "Gesetzlich",
    "Privat"
  ];

  var selectInsurance;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: selectInsurance,
          onChanged: (String? value) {},
          items: insuranceList.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          decoration: InputDecoration(
              labelText: "health_insurance".tr,
              labelStyle:
              TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyColor))),
        ),
        SizedBox(height: 5.h,),
        buildTextField(
          labelText: "nameOfHealthInsurance",
        ),


      ],
    );
  }
}
