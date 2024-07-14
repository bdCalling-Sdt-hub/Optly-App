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

import '../../../controller/dashboard_controller.dart';
import '../../../utils/app_colors.dart';
import 'widget/complete_month_dialog.dart';

class BookedWorking extends StatefulWidget {
  BookedWorking({super.key, required this.id,this.initDate});

  var id;
  DateTime? initDate;

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
    if(widget.initDate != null){
      _focusedDay=widget.initDate!;
    }
    _bookedWorkingController.getBookedWorking(
        id: widget.id.toString(),
        month: DateTimeFormatterHelper.formatMM(_focusedDay),
        year:_focusedDay.year.toString()
        
        );
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
            ? const CustomPageLoading()
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
                                          builder: (_) => CompleteMonthDialog(
                                              id: widget.id.toString(),
                                              month: DateTimeFormatterHelper
                                                  .formatMM(_focusedDay),
                                              year:
                                                  _focusedDay.year.toString()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        textStyle: const TextStyle(
                                            color: AppColors.white)),
                                    child: const Text(
                                     "Monat abschliessen",
                                      style: TextStyle(
                                          color: AppColors.white),
                                    ),
                                  )
                                : SizedBox(),

                        SizedBox(
                          height: 10.h,
                        ),

                        Text(
                         _bookedWorkingController.bookedWorkData.value.data!.subtractbreaks==0? "Pausen werden NICHT von den geleisteten Zeiten abgezogen.":"Pausen werden von den geleisteten Zeiten abgezogen.",
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          var data = _bookedWorkingController
                                              .bookedWorkData
                                              .value
                                              .data!
                                              .entries![index];

                                          return Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ///  start date
                                              Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        DateTimeFormatterHelper
                                                            .formatDD(DateTime
                                                                .parse(data
                                                                    .start!)),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        DateTimeFormatterHelper
                                                            .formatDDMM(DateTime
                                                                .parse(data
                                                                    .start!)),
                                                        style: TextStyle(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.8)),
                                                      ),
                                                    ],
                                                  )),
                                              SizedBox(
                                                width: 9.w,
                                              ),

                                              ///  customer name

                                              Expanded(
                                                  flex: 4,
                                                  child:
                                                      data.customername == null
                                                          ? const SizedBox()
                                                          : Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        4),
                                                                decoration: BoxDecoration(
                                                                    // color: Colors
                                                                    //     .cyan
                                                                    //     .withOpacity(
                                                                    //         0.2),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r)),
                                                                child: Text(
                                                                  data.customername ??
                                                                      "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                            )),
                                              SizedBox(
                                                width: 9.w,
                                              ),

                                              ///  time
                                              Expanded(
                                                flex: 5,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      DateTimeFormatterHelper.formatTimeRange(data.start==null? null: DateTime.parse(data.start!), data.end==null? null: DateTime.parse(data.end!)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    // if (data.end!.isNotEmpty &&
                                                    //     data.start!.isNotEmpty)
                                                    //   Text(
                                                    //     "Bestätigt",
                                                    //     style: TextStyle(
                                                    //         color: Colors.cyan
                                                    //             .withOpacity(
                                                    //                 0.8)),
                                                    //   )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 9.w,
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(data.workedtime ==
                                                          null
                                                      ? ""
                                                      : DateTimeFormatterHelper
                                                          .calculateMinutesToHour(
                                                              data.workedtime!
                                                                )))
                                            ],
                                          );
                                          // return Card(
                                          //   shape: RoundedRectangleBorder(
                                          //       borderRadius: BorderRadius.all(
                                          //           Radius.circular(3.r)),
                                          //       side: BorderSide(
                                          //           color: AppColors
                                          //               .primaryColor
                                          //               .withOpacity(0.3))),
                                          //   child: Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 15.w,
                                          //         vertical: 15.h),
                                          //     child: Column(
                                          //       children: [
                                          //         _textTile("start",
                                          //             data.start.toString()),
                                          //         _textTile("end",
                                          //             data.end.toString()),
                                          //         _textTile(
                                          //             "booked_times",
                                          //             data.workedtime == null
                                          //                 ? ""
                                          //                 : DateTimeFormatterHelper
                                          //                     .calculateMinutesToHours(
                                          //                         data.workedtime!)),
                                          //         _textTile(
                                          //             "pause",
                                          //             data.entryBreak == null
                                          //                 ? ""
                                          //                 : DateTimeFormatterHelper
                                          //                     .calculateMinutesToHours(
                                          //                         data.entryBreak!)),
                                          //         _textTile(
                                          //             "times_worked",
                                          //             data.workedtime == null
                                          //                 ? ""
                                          //                 : DateTimeFormatterHelper
                                          //                     .calculateMinutesToHours(
                                          //                         data.workedtime! -
                                          //                             data.entryBreak!)),
                                          //         _textTile("location",
                                          //             "Testing center Zwanzig20"),
                                          //         _textTile("salary",
                                          //             "${data.hourlysalary} € / Std."),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: 10.h,
                                            child: Divider(
                                              color: Colors.grey,
                                            ),
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
        _textTile(
            "Durchschnittliche Arbeitszeit (3 Monate)",
            DateTimeFormatterHelper.calculateMinutesToHours(
                _bookedWorkingController
                        .bookedWorkData.value.data!.minutesPerDay ??
                    0)),
        Divider(),
        _textTile(
            "Geleistete Stunden",
            DateTimeFormatterHelper.calculateMinutesToHours(
                _bookedWorkingController.totalWorkingMinutes.value)),
        Divider(),
        _textTile(
            "Krankheit",
            DateTimeFormatterHelper.calculateMinutesToHours(
                _bookedWorkingController
                        .bookedWorkData.value.data!.sickMinutes ??
                    0)),
        Divider(),
        _textTile(
            "Urlaub",
            DateTimeFormatterHelper.calculateMinutesToHours(
                _bookedWorkingController
                        .bookedWorkData.value.data!.vacationMinutes ??
                    0)),
        Divider(),
        _textTile(
            "Feiertage",
            DateTimeFormatterHelper.calculateMinutesToHours(
                _bookedWorkingController
                        .bookedWorkData.value.data!.feiertagMinutes ??
                    0)),
        Divider(),
        _textTile(
            "Ist-Stunden",
            DateTimeFormatterHelper.calculateMinutesToHours(
                (_bookedWorkingController.totalWorkingMinutes.value +
                    _bookedWorkingController
                        .bookedWorkData.value.data!.feiertagMinutes! +
                    _bookedWorkingController
                        .bookedWorkData.value.data!.vacationMinutes! +
                    _bookedWorkingController
                        .bookedWorkData.value.data!.sickMinutes!))),
        // Divider(),
        // _textTile("Gesamtlohn", "${(_bookedWorkingController.totalWorkingMinutes/60)*25.00}"),
        SizedBox(
          height: 50.h,
        )
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
