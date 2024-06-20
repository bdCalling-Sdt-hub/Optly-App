import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/controller/time_account_controller.dart';
import 'package:optly/helpers/date_time_formatter.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';

import '../../../utils/app_colors.dart';

class TimeAccountScreen extends StatefulWidget {
  const TimeAccountScreen({super.key, required this.userId});
  final String userId;

  @override
  State<TimeAccountScreen> createState() => _TimeAccountScreenState();
}

class _TimeAccountScreenState extends State<TimeAccountScreen> {
  final TimeAccountController _timeAccountController =
      Get.put(TimeAccountController());

  @override
  void initState() {
    _timeAccountController.getTimeAccount(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("timeAccount".tr),
      ),
      body: Obx(
        () => _timeAccountController.loading.value
            ? const CustomPageLoading()
            : Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.primaryColor.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "flexitime".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        _textTile(
                            "overtime",
                            DateTimeFormatterHelper.calculateMinutesToHours(
                                _timeAccountController
                                        .timeAccountList.first.overhours ??
                                    0),
                            const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.separated(
                    itemCount: _timeAccountController.timeAccountList.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    itemBuilder: (context, index) {
                      var data = _timeAccountController.timeAccountList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.r)),
                            side: BorderSide(
                                color:
                                    AppColors.primaryColor.withOpacity(0.3))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          child: Column(
                            children: [
                              _textTile(
                                "date",
                                "${"monthly_closing".tr} ${data.month}.${data.year}",
                              ),
                              _textTile("description", data.description ?? "",
                                  const TextStyle(fontWeight: FontWeight.w500)),
                              _textTile(
                                  "overtime",
                                  DateTimeFormatterHelper
                                      .calculateMinutesToHours(
                                          data.overhours ?? 0),
                                  TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                              _textTile(
                                "action",
                                "",
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
                  )),
                ],
              ),
      ),
    );
  }

  _textTile(String title, subTitle, [TextStyle? subTitleStyle]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.tr,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 50.w,
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
