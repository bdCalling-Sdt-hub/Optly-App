import 'package:get/get.dart';
import 'package:optly/models/time_account_model.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';

class TimeAccountController extends GetxController {
  RxList<TimeAccountModel> timeAccountList = <TimeAccountModel>[].obs;
  var loading = false.obs;
  getTimeAccount(String userId) async {
    loading(true);
    var response = await ApiClient.getData(ApiConstant.getTimeAccount(userId));
    if (response.body['success']) {
      timeAccountList.value = List<TimeAccountModel>.from(
          response.body['data'].map((x) => TimeAccountModel.fromJson(x)));
      loading(false);
    }else{
      ApiChecker.checkApi(response);
    }
  }
}
