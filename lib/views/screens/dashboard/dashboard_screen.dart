import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:optly/controller/dashboard_controller.dart';
import 'package:optly/controller/data_controller.dart';
import 'package:optly/helpers/data.dart';
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
    _dashboardController.getDashboard(isLoading: true);
    Future.delayed(const Duration(seconds: 1), () {
      debugPrint("check difference time ");
    });

    // Timer(const Duration(seconds: 1), (){
    //   _dashboardController.difference.value =DateTimeFormatterHelper.calculateTimeDifference(_dashboardController.dashboardData.value.data==null? null:_dashboardController.dashboardData.value.data!.currents![0].start);
    //   debugPrint("check difference time ");
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint(
        "<============== Check Change Dependencies Back to Screen =============>");
    super.didChangeDependencies();
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
                padding: EdgeInsets.only(right: 20.w, bottom: 5),
                child: Obx(() => CustomNetworkImage(
                      imageUrl: _dataController.image.value,
                      height: 60,
                      width: 60,
                      boxShape: BoxShape.circle,
                    ))),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Obx(() => _dashboardController.loading.value
          ? const CustomPageLoading()
          : _body()),
    );
  }

  _body() {
    return RefreshIndicator(
      onRefresh: () async {
        _dashboardController.getDashboard();
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            ///==============================> Banner Widget <===========================
            if (_dashboardController.dashboardData.value.data!.finalizations !=
                null)
              BannerWidget(
                date: DateTime.parse(
                    "${_dashboardController.dashboardData.value.data!.finalizations!.first.yearmonth}-01"),
                isCurrentTimeNoOnGoing: _dashboardController
                    .dashboardData.value.data!.currents!.isEmpty,
              ),
            SizedBox(height: 20.h),

            ///==============================> Current Time Recording Widget <===========================

            _currentTimeRecording(),
            const SizedBox(
              height: 20,
            ),

            ///==============================> My Layers  <===========================
            _myLayers(),
            const SizedBox(
              height: 20,
            ),

            ///==============================> My Layers  <===========================
            // _myHygienePlan(),
            // const SizedBox(
            //   height: 20,
            // ),

            /// ========================= Time account overview ======================>
            _timeAccountOverView(),
            const SizedBox(
              height: 20,
            ),

            ///  ==================  Open tasks ==================
            _openTasks()
          ],
        ),
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

          if (_dashboardController.dashboardData.value.data!.currents!.isEmpty)
            CustomText(
              text: "Du hast aktuell keine laufende Arbeitszeitaufnahme.",
              maxline: 5,
              textAlign: TextAlign.start,
            ),
          if (_dashboardController
              .dashboardData.value.data!.currents!.isNotEmpty)
            CustomText(
              bottom: 20.h,
              text:
                  "${_dashboardController.dashboardData.value.data!.currents![0].cname}",
              fontsize: 14.sp,
              fontWeight: FontWeight.w500,
            ),

          /// =======================> Start Of Work Row <=========================
          if (_dashboardController
              .dashboardData.value.data!.currents!.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: ""
                          "Arbeitsbeginn",
                      fontsize: 14.w,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text:
                          "${_dashboardController.dashboardData.value.data!.currents![0].start}",
                      fontsize: 14.w,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          if (_dashboardController
              .dashboardData.value.data!.currents!.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Divider(
                color: AppColors.dividerColor,
              ),
            ),
          //=============================> Length of Time Row <=====================
          if (_dashboardController
              .dashboardData.value.data!.currents!.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomText(
                      text: "Dauer",
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

          SizedBox(
            height: 20.h,
          ),
          if (_dashboardController
              .dashboardData.value.data!.currents!.isNotEmpty)
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
                      text: '!  ',
                      color: const Color(0xfffb8c00),
                      fontsize: 18.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: CustomText(
                        text:
                            'Nach 6 Stunden, bist du gesetzlich verpflichtet eine Pause von 30 Min. zu machen!'
                                .tr,
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
          if (_dashboardController
              .dashboardData.value.data!.currents!.isNotEmpty)
            SizedBox(height: 20.h),
          //==================================> Stop Break Time Button <===========================
          if (_dashboardController
              .dashboardData.value.data!.currents!.isNotEmpty)
            Center(
              child: GestureDetector(
                onTap: () {
                  if (_dashboardController
                          .dashboardData.value.data!.currents!.first.paused ==
                      0) {
                    _dashboardController.pause(_dashboardController
                        .dashboardData.value.data!.currents!.first.id
                        .toString());
                  } else {
                    _dashboardController.resume(_dashboardController
                        .dashboardData.value.data!.currents!.first.id
                        .toString());
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(width: 1.w, color: Colors.cyan)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    child: CustomText(
                      text: _dashboardController.dashboardData.value.data!
                                  .currents!.first.paused ==
                              0
                          ? "Pausenzeit Starten"
                          : "Pausenzeit Stoppen",
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ),
            ),
          if (_dashboardController
              .dashboardData.value.data!.currents!.isNotEmpty)
            SizedBox(height: 12.h),
          //==================================> Stop Time Button <===========================
          if (_dashboardController
              .dashboardData.value.data!.currents!.isNotEmpty)
            Center(
              child: GestureDetector(
                onTap: () {
                  if (_dashboardController
                          .dashboardData.value.data!.currents!.first.paused ==
                      0) {
                    showPausenzeitenDialog(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: _dashboardController.dashboardData.value.data!
                                  .currents!.first.paused ==
                              0
                          ? Color(0xff832700)
                          : Colors.grey),
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

  _myLayers() {
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
          _dashboardController.dashboardData.value.data!.schichten!.isEmpty
              ? CustomText(
                  text: AppString.youAreNotCurrentlyScheduledForAShift.tr,
                  fontsize: 13.sp,
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: _dashboardController
                      .dashboardData.value.data!.schichten!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = _dashboardController
                        .dashboardData.value.data!.schichten![index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/dot-single-svgrepo-com.svg",
                          color: Colors.black.withOpacity(0.6),
                        ),
                        Flexible(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text:
                                        "${DateFormat('E. dd.MM').format(data.date!)}: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.6)),
                                    children: [
                                  TextSpan(
                                    text:
                                        "${DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(data.starttime!))} - ${DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(data.endtime!))}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  )
                                ])),
                            const SizedBox(
                              height: 5,
                            ),
                            Wrap(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.black12,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Text("${data.category}"),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("${data.name}"),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("${data.standort}"),
                          ],
                        ))
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Colors.grey.shade600,
                    );
                  },
                ),
        ],
      ),
    );
  }

  _myHygienePlan() {
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

  _timeAccountOverView() {
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
                      Text(
                        AppString.actualHours.tr,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(AppString.currentMonth.tr),
                    ],
                  ),
                ),
                Expanded(
                    child: Text(
                  DateTimeFormatterHelper.calculateMinutesToHours2(
                      _dashboardController.dashboardData.value.data!.duration ==
                              null
                          ? 0
                          : int.parse(_dashboardController
                              .dashboardData.value.data!.duration)),
                  style: TextStyle(fontSize: 14, color: AppColors.greyColor),
                ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                      Text(
                        AppString.overtime.tr,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(AppString.monthly.tr),
                    ],
                  ),
                ),
                Expanded(
                    child: Text(
                  DateTimeFormatterHelper.calculateMinutesToHours2(
                      _dashboardController
                                  .dashboardData.value.data!.currentminutes ==
                              null
                          ? 0
                          : int.parse(_dashboardController
                              .dashboardData.value.data!.currentminutes!)),
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greenColor),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  _openTasks() {
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
              itemCount:
                  _dashboardController.dashboardData.value.data!.todos!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var data = _dashboardController
                    .dashboardData.value.data!.todos![index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.dividerColor),
                      color: AppColors.primaryColor.withOpacity(0.1)),
                  child: ListTile(
                    title: Text(
                      data.title ?? "",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(data.description ?? ""),
                  ),
                );
              })
        ],
      ),
    );
  }

  showPausenzeitenDialog(BuildContext context) {
    String data = _dashboardController
        .dashboardData.value.data!.currents!.first.breaktimes!;
    List<String> timestamps = data.split(',');

    List<Map<String, String>> pauses = [];
    for (int i = 0; i < timestamps.length; i += 2) {
      if (i + 1 < timestamps.length) {
        pauses.add({
          'start': timestamps[i],
          'end': timestamps[i + 1],
        });
      } else {
        pauses.add({
          'start': timestamps[i],
          'end': '',
        });
      }
    }

    var breakDuration = _dashboardController.calcBreak(pauses);
    int actualWorkingTime = _dashboardController
            .dashboardData.value.data!.currents!.first.duration ??
        0 - breakDuration;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Zeiterfassung stoppen'),
          content: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    listTile(
                        "Arbeitsbeginn",
                        DateFormat('dd.MM.yyyy HH:mm').format(
                            _dashboardController.dashboardData.value.data!
                                    .currents!.first.start ??
                                DateTime.now())),
                    const Divider(
                      color: Colors.grey,
                    ),
                    listTile("Arbeitsende",
                        DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now())),
                    const Divider(
                      color: Colors.grey,
                    ),
                    listTile(
                        "Dauer",
                        DateTimeFormatterHelper.calculateMinutesToHours2(
                            _dashboardController.dashboardData.value.data!
                                    .currents!.first.duration ??
                                0)),
                    const Divider(
                      color: Colors.grey,
                    ),

                    listTile(
                        "Pause",
                        DateTimeFormatterHelper.calculateMinutesToHours2(
                            breakDuration)),

                    const Divider(
                      color: Colors.grey,
                    ),
                    listTile(
                        "Tatsächliche Arbeitszeit",
                        DateTimeFormatterHelper.calculateMinutesToHours2(
                            breakDuration),TextStyle(fontWeight: FontWeight.w600,fontSize:14)),
                    SizedBox(height: 10.h,),
                    const Text("Pausenzeiten",style: TextStyle(fontWeight: FontWeight.w600,fontSize:14,color:Colors.black45),),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: pauses.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, String> pause = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${index + 1}. ',
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${pause['start']} - ${pause['end']}',
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    pauses.removeAt(index);
                                    breakDuration =
                                        _dashboardController.calcBreak(pauses);
                                    actualWorkingTime = _dashboardController
                                            .dashboardData
                                            .value
                                            .data!
                                            .currents!
                                            .first
                                            .duration ??
                                        0 - breakDuration;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Row listTile(String title, String subTitle,[TextStyle? style]) {
    return Row(
      children: [
        Expanded(flex: 10, child: Text(title,style: style,)),

        Expanded(flex: 8, child: Text(subTitle,style: style,)),
      ],
    );
  }
}
