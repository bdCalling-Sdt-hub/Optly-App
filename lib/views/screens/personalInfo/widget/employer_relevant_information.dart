import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmployerRelevantInformation extends StatelessWidget {
  const EmployerRelevantInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textTile("employed_as", ""),
        _textTile("personnel_number", ""),
        _textTile("job_title", ""),
        _textTile("locations", ""),
        _textTile("working_area", ""),
        _textTile("holiday_entitlement", ""),
        _textTile("superior", ""),
        _textTile("deputy_supervisor", ""),
        _textTile("entry_date", ""),
        _textTile("contract_end", ""),
        _textTile("the_eployee_has_provided_all_evidence", ""),
        _textTile("active", ""),






      ],
    );
  }


  _textTile(String title, subTitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
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
                textAlign: TextAlign.right,
                style: const TextStyle(fontWeight:FontWeight.w600,),
              )),
        ],
      ),
    );
  }

}
