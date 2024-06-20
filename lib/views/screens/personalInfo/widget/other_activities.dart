import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/profile_controller.dart';
import '../../../../utils/app_colors.dart';

class OtherActivities extends StatelessWidget {
  OtherActivities({super.key});
  final _profileController = Get.put(ProfileController());

  List<String> currentAcctivituyList = [
    "Schüler/ Student",
    "Auszubildender",
    "Festanstellung",
    "Werksstudent",
    " Minijobber",
    "Rentner",
    "keine Tätigkeit",
    "arbeitslos gemeldet",
  ];

  var selectCurrentActivites;

  var isCheck = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width/2,
          child: DropdownButtonFormField<String>(
            value: selectCurrentActivites,
            isExpanded: true,
            menuMaxHeight: 300,
            onChanged: (String? value) {},
            items: currentAcctivituyList.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            decoration: InputDecoration(
                labelText: "current_main_activity".tr,
                labelStyle:
                    TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.greyColor))),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Obx(
          () => CheckboxListTile(

              value: isCheck.value,
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text("${"other_activities".tr} ?",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400),),
              controlAffinity : ListTileControlAffinity.leading,
              onChanged: (v) {
                isCheck.value = v!;
              }),
        ),
        SizedBox(height:15.h,),
        Text("for_short_term_employees".tr),
        SizedBox(height:15.h,),






      ],
    );
  }
}
