import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/helpers/data.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class BannerWidget extends StatelessWidget {
   BannerWidget({
    super.key,
    required this.date
  });
  String date;

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
              text:AppString.theFollowing.tr,
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
              //Get.toNamed(AppRoutes.overviewScreen);
            },
            child: Container(
              alignment:Alignment.center,
              decoration:
              const BoxDecoration(color: Color(0xff832700)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 12.w, vertical: 6.h),
                child: CustomText(
                  text: date,
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