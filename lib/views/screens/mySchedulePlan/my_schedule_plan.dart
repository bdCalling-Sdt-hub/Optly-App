import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';

import '../../../controller/my_schedule_plan_controller.dart';
import '../../../helpers/date_period_helper.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_expansion_tile.dart';

class MySchedulePlanScreen extends StatefulWidget {
  const MySchedulePlanScreen({super.key});

  @override
  State<MySchedulePlanScreen> createState() => _MySchedulePlanScreenState();
}

class _MySchedulePlanScreenState extends State<MySchedulePlanScreen> {
  late DatePeriod _currentPeriod;
  final MySchedulePlanController _mySchedulePlanController =
      Get.put(MySchedulePlanController());


  @override
  void initState() {
    super.initState();
    _currentPeriod = DatePeriod(DateTime.now());
    _mySchedulePlanController.getMySchedule(
        _currentPeriod.getFormattedStartDate(), true);
  }

  void _nextPeriod() {
    setState(() {
      _currentPeriod = _currentPeriod.next();
      _mySchedulePlanController.getMySchedule(
          _currentPeriod.getFormattedStartDate(), false);
    });
  }

  void _previousPeriod() {
    setState(() {
      _currentPeriod = _currentPeriod.previous();
      _mySchedulePlanController.getMySchedule(
          _currentPeriod.getFormattedStartDate(), false);
    });
  }

var isCheck=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my_shift_plan".tr),
      ),
      body: Obx(
        () => _mySchedulePlanController.isFirstLoading.value
            ? const CustomPageLoading()
            : Stack(
                children: [

                  SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
                    child: Column(
                      children: [
                        _buildHeader(),
                        SizedBox(
                          height: 20.h,
                        ),
                        CheckboxListTile(value:isCheck ,
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            title: const Text("Nur Meine schichten anzeigen"),
                            onChanged: (v){
                          isCheck=v!;
                          setState(() {

                          });
                        }),
                        SizedBox(
                          height: 20.h,
                        ),
                        _mySchedulePlanController.mySchedulePlan.value.data ==
                                null
                            ? Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                ),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.info,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    "the_shift_schedule_has_not_yet_been_released"
                                        .tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : _subBody()
                      ],
                    ),
                  ),
                  Positioned(
                      child: _mySchedulePlanController.loading.value
                          ? const CustomPageLoading()
                          : const SizedBox()),
                ],
              ),
      ),
    );
  }

  _subBody() {
    return Column(
      children: [
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var customerData = _mySchedulePlanController
                  .mySchedulePlan.value.data!.customers![index];
              return CustomExpansionTile(
                //  collapsedBackgroundColor: Colors.grey,
                //   backgroundColor: Colors.grey,
                title: Text(customerData.name ?? ""),
                // subtitle: Text('Custom expansion arrow icon'),
                children: _currentPeriod.getDayNameAndDates()
                    .map((s) => Column(
                      children: [
                        Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 5.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s['day']!,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp),),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(s['date']!),
                                ],
                              ),
                            ),
                        if(isCheck)
                        Column(
                          children: _mySchedulePlanController.querySchedulePlan(customerData.id!).map((data){
                            var date=DateFormat('dd.MM.yyyy').format(data.date!);
                            return s['date']!= date?const SizedBox() :Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.withOpacity(0.6)
                            ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Container(
                                padding:EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
                                decoration: BoxDecoration(
                                  color: Colors.yellow.shade400,
                                  borderRadius: BorderRadius.circular(50),
                                  
                                ),
                                child:Text(data.category??"",style:const TextStyle(fontWeight: FontWeight.w600),),
                              ),
                                  const SizedBox(height:8,),
                                  Text("${data.name}"),
                                  const SizedBox(height:8,),
                                  Text("${data.starttime} - ${data.endtime}"),
                                  const SizedBox(height:8,),
                                  Text("${data.username}",style: const TextStyle(fontWeight:FontWeight.w600),),
                                ],
                              ),
                            );
                          }).toList()),
                        
                      ],
                    ))
                    .toList(),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 12.h,
              );
            },
            itemCount: _mySchedulePlanController
                .mySchedulePlan.value.data!.customers!.length)
      ],
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
