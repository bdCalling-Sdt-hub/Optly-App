import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/controller/profile_controller.dart';

class EmployerRelevantInformation extends StatelessWidget {
   EmployerRelevantInformation({super.key});

  final _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var data = _profileController.profileData.value.data!.info!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textTile("employed_as","Full-time / Part-time" ),
        _textTile("personnel_number", data.employeenumber??""),
        _textTile("job_title", data.jobtitle??""),
        _textTile("place_of_work", ""),
        _textTile("locations", data.location??""),
        _textTile("working_area", data.workplace??""),
        _textTile("holiday_entitlement",""),
        _textTile("superior", data.supervisorid??""),
        _textTile("deputy_supervisor", ""),
        _textTile("entry_date", data.entrydate??""),
        _textTile("contract_end", data.exitdate??""),
        _textTile("the_employee_has_provided_all_evidence", ""),
        _textTile("active", data.active!?"Ja":"Nein"),
      ],
    );
  }


  _textTile(String title, subTitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:8.h),
      child: Row(
        children: [
          Flexible(
            child: Text(
              "${title.tr}: ",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
              child: Text(
                subTitle,
                textAlign: TextAlign.left,
                style: const TextStyle(fontWeight:FontWeight.w600,),
              )),
        ],
      ),
    );
  }

}
