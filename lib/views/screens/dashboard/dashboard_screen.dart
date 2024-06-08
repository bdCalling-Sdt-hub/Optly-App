import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:optly/controller/dashboard_controller.dart';
import 'package:optly/controller/data_controller.dart';
import 'package:optly/helpers/date_time_formatter.dart';
import 'package:optly/routes/app_routes.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/utils/app_images.dart';
import 'package:optly/views/widgets/cache_network_image.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';
import 'package:optly/views/widgets/custom_text.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import 'innerWidget/banner.dart';
import 'innerWidget/custom_drawer.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dataController = Get.put(DataController());
  final _dashboardController = Get.put(DashboardController());


  @override
  void initState() {
    _dataController.getData();
    _dashboardController.getDashboard();
    Future.delayed(Duration(seconds: 1),(){
      debugPrint("check difference time ");

    });

    // Timer(const Duration(seconds: 1), (){
    //   _dashboardController.difference.value =DateTimeFormatterHelper.calculateTimeDifference(_dashboardController.dashboardData.value.data==null? null:_dashboardController.dashboardData.value.data!.currents![0].start);
    //   debugPrint("check difference time ");
    // });
    super.initState();
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.profileScreen);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20.w,bottom: 5),
              child:Obx(()=> CustomNetworkImage(imageUrl:_dataController.image.value, height: 60, width:60,boxShape: BoxShape.circle,))
            ),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      body: Obx(()=>_dashboardController.loading.value?const CustomPageLoading():_body()),
    );
  }

  _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
          ///==============================> Banner Widget <===========================
          const BannerWidget(),
          SizedBox(height: 12.h),

          ///==============================> Current Time Recording Widget <===========================

          _currentTimeRecording(),
          const SizedBox(height: 20,),

          ///==============================> My Layers  <===========================
          _myLayers(),
          const SizedBox(height: 20,),

          ///==============================> My Layers  <===========================
          _myHygienePlan(),
          const SizedBox(height: 20,),
          /// ========================= Time account overview ======================>
          _timeAccountOverView(),
          const SizedBox(height: 20,),
          ///  ==================  Open tasks ==================
          _openTasks()
        ],
      ),
    );
  }

  _currentTimeRecording() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(3.r)),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            bottom: 20.h,
            text: AppString.currentTimeRecording.tr,
            fontsize: 16.sp,
            fontWeight: FontWeight.w600,
          ),

          CustomText(
            bottom: 20.h,
            text: "${_dashboardController.dashboardData.value.data!.currents![0].cname}",
            fontsize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          /// =======================> Start Of Work Row <=========================



          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    text: AppString.startOfWork,
                    fontsize: 14.w,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: "${_dashboardController.dashboardData.value.data!.currents![0].start}",
                    fontsize: 14.w,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w
            ),
            child: Divider(
              color: AppColors.dividerColor,
            ),
          ),
          //=============================> Length of Time Row <=====================
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomText(
                    text: AppString.lengthOfTime.tr,
                    fontsize: 14.w,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: '${_dashboardController.difference}',
                    fontsize: 14.w,
                    textAlign: TextAlign.start,
                  ),
                ),

              ],
            ),
          ),

          SizedBox(height: 20.h,),

          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1.w, color: Color(0xfffb8c00))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomText(
                    text:
                    '!  ',
                    color: const Color(0xfffb8c00),
                    fontsize: 18.w,
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: CustomText(
                      text:
                          'After 6 hours, you are legally obliged \nto take a break of 30 minutes!',
                      color: const Color(0xfffb8c00),
                      maxline: 4,
                      textAlign: TextAlign.start,
                      fontsize: 14.w,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          //==================================> Stop Break Time Button <===========================
          Center(
            child: GestureDetector(
              onTap: () {
                //Get.toNamed(AppRoutes.overviewScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(width: 1.w, color: Colors.cyan)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  child: CustomText(
                    text: AppString.stopBreakTime.tr,
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
                decoration: const BoxDecoration(color: Color(0xff832700)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  child: CustomText(
                    text: AppString.stopTimeRecording.tr,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _myLayers(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(3.r)),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            bottom: 20.h,
            text: AppString.myLayers.tr,
            fontsize: 16.sp,
            fontWeight: FontWeight.w600,
          ),

          CustomText(
            text: AppString.youAreNotCurrentlyScheduledForAShift.tr,
            fontsize: 13.sp,
          ),

        ],
      ),
    );
  }

  _myHygienePlan(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(3.r)),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            bottom: 20.h,
            text: AppString.myHygienePlan.tr,
            fontsize: 16.sp,
            fontWeight: FontWeight.w600,
          ),

          CustomText(
            text: AppString.youCurrentlyHaveNoPlannedHygienePlan.tr,
            fontsize: 13.sp,
          ),

        ],
      ),
    );
  }

  _timeAccountOverView(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(3.r)),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            bottom: 20.h,
            text: AppString.timeAccountOverView.tr,
            fontsize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.actualHours.tr,style: const TextStyle(fontWeight: FontWeight.w500),),
                      Text(AppString.currentMonth.tr),
                    ],
                  ),
                ),
                Expanded(child:Text("0hrs 0mins",style:TextStyle(fontSize: 14,color: AppColors.greyColor),))
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w
            ),
            child: Divider(
              color: AppColors.dividerColor,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.overtime.tr,style: const TextStyle(fontWeight: FontWeight.w500),),
                      Text(AppString.monthly.tr),
                    ],
                  ),
                ),
                Expanded(child:Text("0hrs 0mins",style:TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500,color: AppColors.greenColor),))
              ],
            ),
          ),




        ],
      ),
    );

  }

  _openTasks(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(3.r)),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            bottom: 20.h,
            text: AppString.openTasks.tr,
            fontsize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder:(context,index){
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              decoration: BoxDecoration(
                border: Border.all(color:AppColors.dividerColor),
                color: AppColors.primaryColor.withOpacity(0.1)
              ),
              child: ListTile(
                title: Text("Test",style: TextStyle(fontWeight:FontWeight.w600),),
                subtitle: Text("Test Max"),
              ),
            );
          })


        ],
      ),
    );
  }
}
