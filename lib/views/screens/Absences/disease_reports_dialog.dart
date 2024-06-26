import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiseaseReportsDialog extends StatelessWidget {
  const DiseaseReportsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Neuen Abwesenheitsantrag erstellen",style: TextStyle(fontSize:16.sp,fontWeight:FontWeight.w600,),),
      content:Column(
        children: [



        ],
      ),
    );
  }
}
