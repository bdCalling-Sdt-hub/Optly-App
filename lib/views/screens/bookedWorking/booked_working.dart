import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:optly/controller/booked_working_controller.dart';
import 'package:optly/helpers/date_time_formatter.dart';
import 'package:optly/models/booked_working_model.dart';
import 'package:optly/views/widgets/custom_button.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';

import '../../../utils/app_colors.dart';
import 'widget/complete_month_dialog.dart';

class BookedWorking extends StatefulWidget {
  BookedWorking({super.key, required this.id});

  var id;

  @override
  State<BookedWorking> createState() => _BookedWorkingState();
}

class _BookedWorkingState extends State<BookedWorking> {
  DateTime _focusedDay = DateTime.now();

  final BookedWorkingController _bookedWorkingController =
      Get.put(BookedWorkingController());

  String dropdownvalue = 'sort_by';



  @override
  void initState() {
    _bookedWorkingController.getBookedWorking(
        id: widget.id.toString(),
        month: DateTimeFormatterHelper.formatMM(_focusedDay),
        year: _focusedDay.year.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("booked_working_hours".tr),
      ),
      body: Obx(
        () => _bookedWorkingController.loading.value &&
                _bookedWorkingController.bookedWorkData.value.data == null
            ? CustomPageLoading()
            : Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        _buildHeader(),
                        SizedBox(
                          height: 10.h,
                        ),
                        _bookedWorkingController
                                    .bookedWorkData.value.data!.finalization !=
                                null
                            ? Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color:
                                        AppColors.greenColor.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Text(
                                    "Dieser Monat wurde am ${_bookedWorkingController.bookedWorkData.value.data!.finalization!.createdAt} abgeschlossen und kann nicht mehr verändert werden."),
                              )
                            : _bookedWorkingController.bookedWorkData.value
                                        .data!.hasClosePermisson ==
                                    true
                                ? ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              CompleteMonthDialog(  id: widget.id.toString(),
                                                  month: DateTimeFormatterHelper.formatMM(_focusedDay),
                                                  year: _focusedDay.year.toString()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        textStyle: const TextStyle(
                                            color: AppColors.white)),
                                    child: Text(
                                      "month_complete".tr,
                                      style: const TextStyle(
                                          color: AppColors.white),
                                    ),
                                  )
                                : SizedBox(),

                        SizedBox(
                          height: 10.h,
                        ),

                        Text(
                          "Breaks are deducted from the time worked.".tr,
                          style: const TextStyle(color: Colors.orange),
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: SizedBox(
                        //     width: Get.width / 2.8,
                        //     child: DropdownButton(
                        //       // Initial Value
                        //       value: dropdownvalue,
                        //       hint: Text("sort_by".tr),
                        //       isExpanded: true,
                        //       underline: Container(
                        //         decoration: BoxDecoration(
                        //             border: Border.all(color: AppColors.primaryColor)),
                        //       ),
                        //       icon: const Icon(Icons.keyboard_arrow_down),
                        //       // Array list of items
                        //       items: items.map((String items) {
                        //         return DropdownMenuItem(
                        //           value: items,
                        //           child: Text(
                        //             items.tr,
                        //             maxLines: 1,
                        //             overflow: TextOverflow.ellipsis,
                        //           ),
                        //         );
                        //       }).toList(),
                        //       // After selecting the desired option,it will
                        //       // change button value to selected value
                        //       onChanged: (String? newValue) {
                        //         setState(() {
                        //           dropdownvalue = newValue!;
                        //         });
                        //       },
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_bookedWorkingController.bookedWorkData
                                    .value.data!.entries!.isEmpty)
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                _bookedWorkingController.bookedWorkData.value
                                        .data!.entries!.isEmpty
                                    ? Center(
                                        child: Text(
                                            "no_booked_working_hours_available"
                                                .tr))
                                    : ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          var data = _bookedWorkingController
                                              .bookedWorkData
                                              .value
                                              .data!
                                              .entries![index];
                                          return Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3.r)),
                                                side: BorderSide(
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(0.3))),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w,
                                                  vertical: 15.h),
                                              child: Column(
                                                children: [
                                                  _textTile("start",
                                                      data.start.toString()),
                                                  _textTile("end",
                                                      data.end.toString()),
                                                  _textTile(
                                                      "booked_times",
                                                      data.workedtime == null
                                                          ? ""
                                                          : DateTimeFormatterHelper
                                                              .calculateMinutesToHours(
                                                                  data.workedtime!)),
                                                  _textTile(
                                                      "pause",
                                                      data.entryBreak == null
                                                          ? ""
                                                          : DateTimeFormatterHelper
                                                              .calculateMinutesToHours(
                                                                  data.entryBreak!)),
                                                  _textTile(
                                                      "times_worked",
                                                      data.workedtime == null
                                                          ? ""
                                                          : DateTimeFormatterHelper
                                                              .calculateMinutesToHours(
                                                                  data.workedtime! -
                                                                      data.entryBreak!)),
                                                  _textTile("location",
                                                      "Testing center Zwanzig20"),
                                                  _textTile("salary",
                                                      "${data.hourlysalary} € / Std."),
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
                                        itemCount: _bookedWorkingController
                                            .bookedWorkData
                                            .value
                                            .data!
                                            .entries!
                                            .length),
                                SizedBox(
                                  height: 50.h,
                                ),
                                _monthlyOverview(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (_bookedWorkingController.loading.value &&
                      _bookedWorkingController.bookedWorkData.value.data !=
                          null)
                    const Positioned(child: CustomPageLoading())
                ],
              ),
      ),
    );
  }

  _monthlyOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Monatsübersicht",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(
          height: 20.h,
        ),
        _textTile("Aktueller Lohn(pro Stunde", "25,00 "),
        Divider(),
        _textTile("Durchschnittliche Arbeitszeit (3 Monate)", "0"),
        Divider(),
        _textTile("Geleistete Stunden", DateTimeFormatterHelper.calculateMinutesToHours(_bookedWorkingController.totalWorkingMinutes.value)),
        Divider(),
        _textTile("Krankheit", DateTimeFormatterHelper.calculateMinutesToHours(_bookedWorkingController.bookedWorkData.value.data!.sickMinutes!)),
        Divider(),
        _textTile("Urlaub", DateTimeFormatterHelper.calculateMinutesToHours(_bookedWorkingController.bookedWorkData.value.data!.vacationMinutes!)),
        Divider(),
        _textTile("Feiertage", DateTimeFormatterHelper.calculateMinutesToHours(_bookedWorkingController.bookedWorkData.value.data!.feiertagMinutes!)),
        Divider(),
        _textTile("Ist-Stunden", DateTimeFormatterHelper.calculateMinutesToHours(_bookedWorkingController.totalWorkingMinutes.value)),
        Divider(),
        _textTile("Gesamtlohn", "${(_bookedWorkingController.totalWorkingMinutes/60)*25.00}"),
        Divider(),
      ],
    );
  }

  _textTile(String title, subTitle) {
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
          )),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.primaryColor),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _focusedDay =
                    DateTime(_focusedDay.year, _focusedDay.month - 1, 1);

                _bookedWorkingController.getBookedWorking(
                    id: widget.id.toString(),
                    month: DateTimeFormatterHelper.formatMM(_focusedDay),
                    year: _focusedDay.year.toString());
              });
            }, // Disabled previous month button
          ),
          Expanded(
              child: Text(
            textAlign: TextAlign.center,
            DateFormat('MMMM yyyy').format(_focusedDay),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          IconButton(
            icon: const Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _focusedDay =
                    DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
                _bookedWorkingController.getBookedWorking(
                    id: widget.id.toString(),
                    month: DateTimeFormatterHelper.formatMM(_focusedDay),
                    year: _focusedDay.year.toString());
              });
            },
          ),
        ],
      ),
    );
  }
}
