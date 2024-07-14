import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

  getDashboard() async {
    loading(true);
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
}
