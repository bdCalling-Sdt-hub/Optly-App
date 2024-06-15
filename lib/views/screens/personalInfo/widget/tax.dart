import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/views/screens/personalInfo/widget/personal_info.dart';
import 'package:optly/views/screens/personalInfo/widget/social_insurance.dart';

import '../../../../utils/app_colors.dart';

class Tax extends StatelessWidget {
   Tax({super.key});

   List<String> taxBracketList=[
     "Klasse 1",
     "Klasse 2",
     "Klasse 3",
     "Klasse 4",
     "Klasse 4 mit Faktor",
     "Klasse 5",
   ];

  var selectTaxBracketFactor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField(
          labelText: "identification_number",
          textInputType: TextInputType.number,
        ),

        buildTextField(
          labelText: "child_allowances",
        ),
        DropdownButtonFormField<String>(
          value: selectTaxBracketFactor,
          onChanged: (String? value) {},
          items: taxBracketList.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          decoration: InputDecoration(
              labelText: "tax_bracket_factor".tr,
              labelStyle:
              TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyColor))),
        ),

          buildTextField(
          labelText: "denomination",
        ),





      ],
    );
  }
}
