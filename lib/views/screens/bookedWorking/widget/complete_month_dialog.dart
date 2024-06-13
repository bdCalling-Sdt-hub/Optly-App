import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

import '../../../../utils/app_colors.dart';

class CompleteMonthDialog extends StatefulWidget {
   CompleteMonthDialog({super.key});

  @override
  State<CompleteMonthDialog> createState() => _CompleteMonthDialogState();
}

class _CompleteMonthDialogState extends State<CompleteMonthDialog> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
   Uint8List? _signatureData;

   bool _hasSignature = false;

   Future<void> _saveSignature() async {
     final data = await _signaturePadKey.currentState?.toImage();
     if (data != null) {
       final pngBytes = await data.toByteData(format: ui.ImageByteFormat.png);
       if (pngBytes != null) {
         setState(() {
           _signatureData = pngBytes.buffer.asUint8List();
         });
       }
     }
   }

   bool _onDrawStart() {
     if (!_hasSignature) {
       setState(() {
         _hasSignature = true;
       });

     }
     return false;
   }

   void _onDrawEnd() async {
     await _saveSignature();
   }

   void _clearSignature() {
     _signaturePadKey.currentState?.clear();
     setState(() {
       _signatureData = null;
       _hasSignature = false;
     });
   }

   @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Text("month_complete".tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(8.r)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("!",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18.sp,color: Colors.white),),
              SizedBox(width: 15.w,),
                Expanded(child: Text("pleaseCheckTheEntries".tr,style: const TextStyle(color: Colors.white),)),
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Text("closeTheMonthWithYourSignature".tr,),
          SizedBox(height: 10.h,),

          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1)
            ),
            height: 160,
            width: 300,
            child: SfSignaturePad(
              key: _signaturePadKey,
              backgroundColor: Colors.white,
                onDrawStart: _onDrawStart,
               onDrawEnd: _onDrawEnd,
            ),
          ),
          TextButton(onPressed:_clearSignature, child:Text("delete_signature".tr,style: TextStyle(color: Colors.redAccent),))


        ],
      ),
      actions: [
        OutlinedButton(onPressed: (){
          Get.back();
        },style: OutlinedButton.styleFrom(side: const BorderSide(color:Colors.red)), child:Text("cancel".tr,style: const TextStyle(color: Colors.redAccent),),),

        ElevatedButton(onPressed: ()async{
        if(_signatureData != null){

          debugPrint("check print path");

        }
        },style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor), child:Text("complete_month".tr,style: TextStyle(color:Colors.white),),),
      ],
    );
  }
}
