import 'package:get/get.dart';
import 'package:optly/models/check_in_model.dart';
import 'package:optly/routes/app_routes.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';

class CheckInController extends GetxController {
  Rx<CheckInModel> checkInData = CheckInModel().obs;

  var loading = false.obs;
  getCheckInData(String workType, String id) async {
    loading(true);
    var response = await ApiClient.getData(ApiConstant.checkIn(workType, id));
    if (response.body['success']) {
      checkInData.value = CheckInModel.fromJson(response.body);
      loading(false);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  postReason(String id,String category) async {
    var body = {"method": 1, "comment": "start", "category": category};

    var response = await ApiClient.postData(ApiConstant.start(id), body);
    if (response.body['success']) {
      Get.offAllNamed(AppRoutes.dashboardScreen);
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
