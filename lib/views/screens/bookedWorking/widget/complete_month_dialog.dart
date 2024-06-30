import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

import '../../../../controller/booked_working_controller.dart';
import '../../../../utils/app_colors.dart';

class CompleteMonthDialog extends StatefulWidget {
  CompleteMonthDialog(
      {super.key, required this.id, required this.month, required this.year});

  final String id;
  final String month;
  final String year;

  @override
  State<CompleteMonthDialog> createState() => _CompleteMonthDialogState();
}

class _CompleteMonthDialogState extends State<CompleteMonthDialog> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  Uint8List? _signatureData;
  var base64String;
  File? signaturePath;

  bool _hasSignature = false;

  // Future<void> _saveSignature() async {
  //   final data = await _signaturePadKey.currentState?.toImage();
  //   if (data != null) {
  //     final pngBytes = await data.toByteData(format: ui.ImageByteFormat.png);
  //     if (pngBytes != null) {
  //       setState(() {
  //         _signatureData = pngBytes.buffer.asUint8List();
  //         if (_signatureData != null) {
  //           base64 = base64Encode(_signatureData!);
  //         }
  //       });
  //     }
  //   }
  // }

  Future<void> _saveSignature() async {
    // final data = await _signaturePadKey.currentState?.toImage();
    // if (data != null) {
    //   final pngBytes = await data.toByteData(format: ui.ImageByteFormat.png);
    //   if (pngBytes != null) {
    //     setState(() {
    //       _signatureData = pngBytes.buffer.asUint8List();
    //       signaturePath
    //       _hasSignature = true; // Update this if needed
    //     });
    //
    //     // Convert to Base64 string directly after saving the signature data
    //      base64String  = 'data:image/png;base64/${base64Encode(_signatureData!)}';
    //
    //     print(base64String); // You can use this string as needed
    //   }
    // }
    final image = await _signaturePadKey.currentState?.toImage();
    if (image != null) {
      // Convert the image to a Uint8List
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {



        final Uint8List data = byteData.buffer.asUint8List();
        String base64Image = 'data:image/png;base64,${base64Encode(data)}';
        print(base64Image);
        base64String = base64Image;
        final path = await _saveUint8ListToFile(data, 'signature.png');
        print('Signature saved at: $path');
        signaturePath = File(path);
        setState(() {
          _signatureData = byteData.buffer.asUint8List();
          _hasSignature = true;
        });
      }
    }
  }

  Future<String> _saveUint8ListToFile(Uint8List data, String filename) async {
    try {
      // Get the directory to save the file
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/$filename';

      // Create the file
      final file = File(path);

      // Write the Uint8List data to the file
      await file.writeAsBytes(data);

      return path;
    } catch (e) {
      print('Error saving file: $e');
      return '';
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

  final BookedWorkingController _bookedWorkingController =
      Get.put(BookedWorkingController());

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
                color: Colors.orange, borderRadius: BorderRadius.circular(8.r)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "!",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                    child: Text(
                  "pleaseCheckTheEntries".tr,
                  style: const TextStyle(color: Colors.white),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "closeTheMonthWithYourSignature".tr,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(width: 1)),
            height: 160,
            width: 300,
            child: SfSignaturePad(
              key: _signaturePadKey,
              backgroundColor: Colors.white,
              onDrawStart: _onDrawStart,
              onDrawEnd: _onDrawEnd,
            ),
          ),
          TextButton(
              onPressed: _clearSignature,
              child: Text(
                "delete_signature".tr,
                style: TextStyle(color: Colors.redAccent),
              ))
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Get.back();
          },
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red)),
          child: Text(
            "cancel".tr,
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_signatureData != null) {
              _bookedWorkingController.closeMonthFinalize(
                  id: widget.id,
                  month: widget.month,
                  year: widget.year,
                  signature: base64String!);
            }
          },
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
          child: Text(
            "complete_month".tr,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
