import 'package:get/get.dart';
import 'package:optly/models/my_schedule_model.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';

class MySchedulePlanController extends GetxController {
  Rx<MySchedulePlanModel> mySchedulePlan = MySchedulePlanModel().obs;

  var loading = false.obs;
  var isFirstLoading = false.obs;

  getMySchedule(String date, bool isFirst) async {
    if (isFirst) {
      isFirstLoading(true);
    } else {
      loading(true);
    }

    var response = await ApiClient.getData(ApiConstant.getMySchedule(date));
    if (response.statusCode == 404) {
      if (isFirst) {
        isFirstLoading(false);
      } else {
        loading(false);
      }
      mySchedulePlan.value = MySchedulePlanModel.fromJson(response.body);
    } else if (response.body['success']) {
      if (isFirst) {
        isFirstLoading(false);
      } else {
        loading(false);
      }
      mySchedulePlan.value = MySchedulePlanModel.fromJson(response.body);
    } else {
      if (isFirst) {
        //  isFirstLoading(false);
      } else {
        loading(false);
      }
      ApiChecker.checkApi(response);
    }
  }

  List<Schichten> querySchedulePlan(int id){

    List<Schichten> demoList=[];

    mySchedulePlan.value.data!.schichten!.forEach((s){
      if(s.customerid==id){
        demoList.add(s);
      }
    });

    return demoList;

  }


}
