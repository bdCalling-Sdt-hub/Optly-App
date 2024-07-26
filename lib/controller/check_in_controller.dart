import 'package:get/get.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';

class CheckInController extends GetxController {
  var loading = false.obs;
  getCheckInData(String workType, String id) async {
    loading(true);
    var response = await ApiClient.getData(ApiConstant.checkIn(workType, id));
    if (response.body['success']) {
      loading(false);
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
