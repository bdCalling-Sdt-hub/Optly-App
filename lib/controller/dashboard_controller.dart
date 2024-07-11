import 'package:get/get.dart';
import 'package:optly/models/dashboard_model.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';

import '../helpers/date_time_formatter.dart';

class DashboardController extends GetxController {
  var loading = false.obs;
  var difference="".obs;
  Rx<DashboardModel> dashboardData = DashboardModel().obs;

  getDashboard() async {
    loading(true);
    var response = await ApiClient.getData(ApiConstant.getDashboard);
    if (response.body['success']) {
      dashboardData.value = DashboardModel.fromJson(response.body);
      if(dashboardData.value.data!.currents!.isNotEmpty){
    difference.value =DateTimeFormatterHelper.calculateTimeDifference(dashboardData.value.data!.currents![0].start);
   
      }
     loading(false);
    }else{
      ApiChecker.checkApi(response);
    }
  }
}
