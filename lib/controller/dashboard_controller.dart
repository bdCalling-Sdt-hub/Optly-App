import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:optly/models/dashboard_model.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';
import 'package:optly/utils/app_colors.dart';

import '../helpers/date_time_formatter.dart';

class DashboardController extends GetxController {
  var loading = false.obs;
  var difference = "".obs;
  Rx<DashboardModel> dashboardData = DashboardModel().obs;

  getDashboard({bool isLoading = false}) async {
    if(isLoading) {
      loading(true);
    }
    var response = await ApiClient.getData(ApiConstant.getDashboard);
    if (response.body['success']) {
      dashboardData.value = DashboardModel.fromJson(response.body);
      if (dashboardData.value.data!.currents!.isNotEmpty) {
        difference.value = DateTimeFormatterHelper.calculateTimeDifference(
            dashboardData.value.data!.currents![0].start);
      }
      loading(false);
      if (dashboardData.value.data!.notes != null &&
          dashboardData.value.data!.notes!.isNotEmpty) {
        showNoteDialog();
      }
    } else {
      ApiChecker.checkApi(response);
    }
  }

  var currentIndex = 0.obs;
  
  confirmNotes(String id)async{
    var response= await ApiClient.postData(ApiConstant.notesConfirm(id), null);
    if(response.body['success']){
      showNextNote();
    }else{
      ApiChecker.checkApi(response);
    }
  }

  void showNextNote() {
    if (currentIndex.value < dashboardData.value.data!.notes!.length - 1) {
      currentIndex.value++;
      Get.back(); // Close the current dialog
      showNoteDialog();
    } else {
      Get.back();
      debugPrint("Check Dialog dispose");
    }
  }

  void showNoteDialog() {
    var notesList = dashboardData.value.data!.notes!;
    showDialog(
        context: Get.context!,
        barrierDismissible: false,

        builder: (_) => AlertDialog(
          backgroundColor: Colors.white,
                title: Text("Hinweise",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600),),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notesList[currentIndex.value].title,
                      style:  TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black54,fontSize: 15.sp),
                    ),
                    Text(
                      notesList[currentIndex.value].description,
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor
                    ),
                    onPressed: () {
                   confirmNotes(notesList[currentIndex.value].id.toString());
                    },
                    child: const Text("ALS GELESEN MARKIEREN",style: TextStyle(color:Colors.white),),
                  ),
                ]));
  }


  /// Paused
  pause(String id)async{
    var response = await ApiClient.postData(ApiConstant.pause(id), null);
    if(response.body['success']){
      getDashboard();
    }else{
      ApiChecker.checkApi(response);
    }
  }

  ///   Resume
  resume(String id)async{
    var response = await ApiClient.postData(ApiConstant.resume(id), null);
    if(response.body['success']){
      getDashboard();
    }else{
      ApiChecker.checkApi(response);
    }
  }




  int diffInMinutes(DateTime date1, DateTime date2) {
    if (date1 == null || date2 == null) {
      return 0;
    }
    return date2.difference(date1).inMinutes;
  }

  // Function to calculate total break time from a list of break times
  // int calcBreak(String breaktimes) {
  //   int pause = 0;
  //   List<String> times = breaktimes.split(",");
  //
  //   for (int i = 0; i < times.length - 1; i += 2) {
  //     DateTime breakStart = DateFormat("yyyy-MM-dd HH:mm:ss").parse(times[i]);
  //     DateTime breakStop = DateFormat("yyyy-MM-dd HH:mm:ss").parse(times[i + 1]);
  //     pause += diffInMinutes(breakStart, breakStop);
  //   }
  //
  //   return pause;
  // }
  int calcBreak(List<Map<String, String>> breaktimes) {
    int pause = 0;
    for (var time in breaktimes) {
      DateTime breakStart = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time['start']!);
      DateTime breakStop = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time['end']!);
      pause += diffInMinutes(breakStart, breakStop);
    }
    return pause;
  }


  // Function to format the total duration in hours and minutes
  String getHoursAndMinutes(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return '$hours hours and $remainingMinutes minutes';
  }

  breakStop(String id ,String startDate,List<Map<String, String>> breakTimes)async{
    var breakTime= convertBreakTimes(breakTimes);
    var body={
      'id': id,
      'start':startDate,
      'break': "",
      'method': '4',
      'breaktimes': breakTime
    };
    var response= await ApiClient.postMultipartData(ApiConstant.bookTimeStop(id), body, multipartBody: []);
    if(response.body['success']){
      getDashboard();
      Get.back();
    }else{
      ApiChecker.checkApi(response);
    }
  }

  String convertBreakTimes(List<Map<String, String>> breakTimes) {
    List<String> times = [];
    for (var breaktime in breakTimes) {
      times.add(breaktime['start']!);
      times.add(breaktime['end']!);
    }
    return times.join(',');
  }



}
