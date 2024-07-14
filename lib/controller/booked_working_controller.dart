import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:optly/models/booked_working_model.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';

import '../helpers/prefs_helpers.dart';
import '../utils/app_constants.dart';
import 'dashboard_controller.dart';

class BookedWorkingController extends GetxController {
  final _dashboardController = Get.put(DashboardController());
  Rx<BookedWorkingModel> bookedWorkData = BookedWorkingModel().obs;
  var loading = false.obs;
  var totalWorkingMinutes = 0.obs;
  var totalBookedTime = 0.obs;

  getBookedWorking(
      {required String id, required String month, required String year}) async {
    loading(true);
    // var   bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    // var headers = {
    //   'Authorization': 'Bearer $bearerToken'
    // };
    var response = await ApiClient.getData(ApiConstant.getBookedWorking(
      id,
      month,
      year,
    ));
    if (response.body['success']) {
      bookedWorkData.value = BookedWorkingModel.fromJson(response.body);
      getTotalBookedTime(bookedWorkData.value.data!.entries!);
      getTotalWorkingMinutes(bookedWorkData.value.data!.entries!,
          bookedWorkData.value.data!.subtractbreaks == 1);
      _dashboardController.getDashboard();
      loading(false);
    } else {
      if (bookedWorkData.value.data != null) {
        loading(false);
      }
      ApiChecker.checkApi(response);
    }
  }

  getTotalWorkingMinutes(List<Entry> items, bool subtractBreaks) {
    int sumCount = 0;
    for (var item in items) {
      if (item.workedtime != null) {
        int workedTime = item.workedtime ?? 0;
        if (subtractBreaks) {
          workedTime -= item.entryBreak ?? 0;
        }
        sumCount += workedTime;
      }
    }

    totalWorkingMinutes.value = sumCount;
  }

  getTotalBookedTime(List<Entry> entryList) {
    for (var e in entryList) {
      if (e.workedtime != null) {
        totalBookedTime.value = totalBookedTime.value + e.workedtime!;
      }
    }
  }

  closeMonthFinalize(
      {required String id, required String month, required String year ,required String signature}) async {
    var userId = await PrefsHelper.getInt(AppConstants.userId);
     Map<String, dynamic> data = {
      'year': year,
      'month': month,
      'signature': signature};
    var response = await ApiClient.postData(ApiConstant.finalize(userId.toString()), json.encode(data));
    if (response.body['success']) {
      getBookedWorking(id: id, month: month, year: year);
      _dashboardController.getDashboard();
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
