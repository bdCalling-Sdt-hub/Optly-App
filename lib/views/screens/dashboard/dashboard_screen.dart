import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:optly/routes/app_routes.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/utils/app_images.dart';
import 'package:optly/views/widgets/custom_text.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import 'innerWidget/custom_drawer.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: CircleAvatar(
                child: Image.asset(AppImages.person, fit: BoxFit.contain),
              ),
            ),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            //==============================> May 2024 Container <===========================
            Container(
              decoration: BoxDecoration(
                color: Color(0xfffb8c00),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.exclamation),
                        CustomText(
                          text: AppString.theFollowing,
                          fontsize: 14.w,
                          maxline: 2,
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    //==================================> Register Button <===========================
                    GestureDetector(
                      onTap: () {
                        //Get.toNamed(AppRoutes.overviewScreen);
                      },
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Color(0xff832700)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          child: CustomText(
                            text: 'MAY 2024',
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.white
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      bottom: 20.h,
                      text: AppString.currentTime,
                    fontsize: 18.w,
                    ),
                    CustomText(
                      bottom: 20.h,
                      text: AppString.testingCenter,
                    fontsize: 12.w,
                      fontWeight: FontWeight.w600,
                    ),
                    //=======================> Start Of Work Row <=========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(
                          bottom: 10.h,
                          text: AppString.startOfWork,
                          fontsize: 14.w,
                        ),
                        CustomText(
                          bottom: 10.h,
                          text: '27.05.24 12:05',
                          fontsize: 14.w,
                        ),
                      ],
                    ),
                    Divider(color: AppColors.greyColor,),
                    //=============================> Length of Time Row <=====================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(
                          bottom: 10.h,
                          text: AppString.lengthOfTime,
                          fontsize: 14.w,
                        ),
                        CustomText(
                          bottom: 10.h,
                          text: '184 hours 13min',
                          fontsize: 14.w,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Color(0xfffb8c00))
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(AppIcons.exclamation, color: Color(0xfffb8c00)),
                            CustomText(
                              text: 'After 6 hours, you are legally obliged \nto take a break of 30 minutes!',
                              color: const Color(0xfffb8c00),
                              maxline: 4,
                              fontsize: 14.w,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    //==================================> Stop Break Time Button <===========================
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          //Get.toNamed(AppRoutes.overviewScreen);
                        },
                        child: Container(
                          decoration: BoxDecoration(color: AppColors.white,
                            border: Border.all(width: 1.w, color: Colors.cyan)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            child: CustomText(
                              text: AppString.stopBreak,
                              color: Colors.cyan,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    //==================================> Stop Time Button <===========================
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          //Get.toNamed(AppRoutes.overviewScreen);
                        },
                        child: Container(
                          decoration:
                          const BoxDecoration(color: Color(0xff832700)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            child: CustomText(
                              text: AppString.stopTime,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
