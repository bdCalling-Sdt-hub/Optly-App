import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';

class Occupation extends StatelessWidget {
  Occupation({super.key});
  var selectHighestSchoolDegree;
  var selectHighestVocationalEducation;

  List<String> schoolDegreeList = [
    "ohne Schulabschluss",
    "Haupt-Volksschulabschluss",
    "Mittlere Reife/gleichwertiger Abschluss",
    "Abitur/Fachabitur",
  ];
  List<String> vocationalList = [
    "ohne beruflichen Ausbildungsabschluss",
    "Anerkannte Berufsausbildung",
    "Meister/Techniker/gleichwertiger Fachschulabschluss",
    "Bachelor",
    "Diplom/Magister/Master/Staatsexamen",
    "Promotion",
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Highest school degree
        DropdownButtonFormField<String>(
          value: selectHighestSchoolDegree,
          isExpanded: true,
          menuMaxHeight: 300,
          onChanged: (String? value) {},
          items: schoolDegreeList.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          decoration: InputDecoration(
              labelText: "Highest School Degree".tr,
              labelStyle:
                  TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyColor))),
        ),

        SizedBox(
          height: 15.h,
        ),

        /// Highest Vocational Education
        DropdownButtonFormField<String>(
          value: selectHighestVocationalEducation,
          isExpanded: true,
          menuMaxHeight: 300,
          onChanged: (String? value) {},
          items: vocationalList.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          decoration: InputDecoration(
              labelText: "Highest Vocational Education".tr,
              labelStyle:
                  TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyColor))),
        ),
      ],
    );
  }
}
