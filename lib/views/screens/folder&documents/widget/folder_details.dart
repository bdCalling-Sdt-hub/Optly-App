import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';

class FolderDetails extends StatelessWidget {
  const FolderDetails(
      {super.key,
      required this.folderName,
      required this.folderType,
      required this.userId});
  final String folderName;
  final String folderType;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(folderName),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3.r)),
                  side: BorderSide(
                      color: AppColors.primaryColor.withOpacity(0.3))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  children: [
                    _textTile("name", "sdfsdf",
                        TextStyle(color: AppColors.primaryColor)),
                    _textTile("created_by", "alalalllal",
                        TextStyle(fontWeight: FontWeight.w500)),
                    _textTile("created_on", "sdfsdf",
                        TextStyle(color: Colors.black.withOpacity(0.6))),
                    _textTile(
                      "name",
                      "sdflsdfjlsjdfljljl",
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10.h,
            );
          },
          itemCount: 2),
    );
  }

  _textTile(String title, subTitle, [TextStyle? subTitleStyle]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Text(
            title.tr,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          Expanded(
              child: Text(
            subTitle,
            textAlign: TextAlign.right,
            style: subTitleStyle,
          )),
        ],
      ),
    );
  }
}
