import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/controller/availability_controller.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';
import 'package:optly/views/widgets/custom_text_field.dart';

import '../../../helpers/date_period_helper.dart';
import '../../../utils/app_colors.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  late DatePeriod _currentPeriod;
  final AvailabilityController _availabilityController =
      Get.put(AvailabilityController());
  TextEditingController _notesCtrl=TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentPeriod = DatePeriod(DateTime.now());

    _availabilityController.getAvailability(
        _currentPeriod.getFormattedStartDate(), true);
  }

  void _nextPeriod() {
    setState(() {
      _currentPeriod = _currentPeriod.next();
      _availabilityController.getAvailability(
          _currentPeriod.getFormattedStartDate(), false);
    });
  }

  void _previousPeriod() {
    setState(() {
      _currentPeriod = _currentPeriod.previous();
      _availabilityController.getAvailability(
          _currentPeriod.getFormattedStartDate(), false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("availability".tr),
      ),
      body: Obx(
        () => _availabilityController.isFirstLoading.value
            ? const CustomPageLoading()
            : Stack(
                children: [
                  SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      children: [_buildHeader(), dayByShift(),
                        SizedBox(height: 15.h,),
                        CustomTextField(controller:_notesCtrl,maxLines: 2,labelText: "Notiz",),
                        SizedBox(height: 15.h,),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: const ListTile(
                            leading: Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Verfügbarkeiten können für diese Woche nicht mehr geändert / abgegeben werden.",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )


                      ],
                    ),
                  ),
                  Positioned(
                      child: _availabilityController.loading.value
                          ? const CustomPageLoading()
                          : const SizedBox()),
                ],
              ),
      ),
    );
  }

  dayByShift() {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var data = _currentPeriod.getSortDayNameAndDates()[index];
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                width: double.infinity,
                color: data['date'].isAfter(DateTime.now())
                    ? Colors.blueGrey
                    : const Color(0xFF973131),
                child: Text(
                  "${data['day'].toString().replaceAll('.', '')} ${data['date'].day}.${data['date'].month}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                width: double.infinity,
                color: data['date'].isAfter(DateTime.now())
                    ? Colors.blueGrey.withOpacity(0.3)
                    : const Color(0xFF973131).withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _availabilityController.availabilityData.value.data !=
                                null ||
                            _availabilityController
                                    .availabilityData.value.data!.config !=
                                null ||
                            _availabilityController.availabilityData.value.data!
                                    .config!.schichtnames !=
                                null
                        ? const Text("Schichten")
                        : const Text("Uhrzeit"),
                    SizedBox(height: 10.h,),
                    if (_availabilityController.availabilityData.value.data !=
                            null ||
                        _availabilityController
                                .availabilityData.value.data!.config !=
                            null ||
                        _availabilityController.availabilityData.value.data!
                                .config!.schichtnames !=
                            null)
                      Wrap(
                        children: _availabilityController
                            .availabilityData.value.data!.config!.schichtnames!
                            .map((e) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
                          margin: EdgeInsets.only(right: 10.w,bottom: 10.h),
                          decoration: BoxDecoration(
                            color: !data['date'].isAfter(DateTime.now())
                                ? Colors.white.withOpacity(0.6)
                                : const Color(0xFF973131).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(50.r)
                          ),
                          child: Text(e.name),
                        ))
                            .toList(),
                      )
                  ],
                ),
              )
            ],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10.h,
          );
        },
        itemCount: _currentPeriod.getSortDayNameAndDates().length);
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
            onPressed: _previousPeriod, // Disabled previous month button
          ),
          Expanded(
              child: Text(
            textAlign: TextAlign.center,
            _currentPeriod.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          IconButton(
            icon: const Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
            onPressed: _nextPeriod,
          ),
        ],
      ),
    );
  }
}
