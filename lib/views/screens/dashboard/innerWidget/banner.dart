import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:optly/controller/data_controller.dart';
import 'package:optly/helpers/data.dart';
import 'package:optly/views/screens/bookedWorking/booked_working.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class BannerWidget extends StatelessWidget {
   BannerWidget({
    super.key,
    required this.date,
    required this.isCurrentTimeNoOnGoing
  });
  DateTime date;
   var isCurrentTimeNoOnGoing;


    final _dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xfffb8c00),
      ),
      padding: EdgeInsets.symmetric(horizontal:20.0.w,vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text:"!   ",
            fontsize: 20.sp,
            maxline: 2,
            textAlign: TextAlign.start,
            color: AppColors.white,
          ),
          Expanded(
            child: CustomText(
              text:isCurrentTimeNoOnGoing?"Es müssen noch folgende Monate abgeschlossen werden" :AppString.theFollowing.tr,
              fontsize: 14.sp,
              maxline: 2,
              textAlign: TextAlign.start,
              color: AppColors.white,
            ),
          ),
          SizedBox(width: 10.w,),

          //==================================> Register Button <===========================
          GestureDetector(
            onTap: () {
               Get.to(BookedWorking(
                      id: _dataController.userId.value.toString(),
                      initDate:date,
                    ));
            },
            child: Container(
              alignment:Alignment.center,
              decoration:
              const BoxDecoration(color: Color(0xff832700)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 12.w, vertical: 6.h),
                child: CustomText(
                  text: DateFormat('MMMM yyyy').format(date),
                  color: AppColors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}