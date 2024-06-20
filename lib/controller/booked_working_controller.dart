import 'package:get/get.dart';
import 'package:optly/models/booked_working_model.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';

import '../helpers/prefs_helpers.dart';
import '../utils/app_constants.dart';

class BookedWorkingController extends GetxController {
  Rx<BookedWorkingModel> bookedWorkData = BookedWorkingModel().obs;
  var loading = false.obs;

  getBookedWorking(
      {required String id, required String month, required String year}) async {
    loading(true);
    // var   bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    // var headers = {
    //   'Authorization': 'Bearer $bearerToken'
    // };
    var response =
        await ApiClient.getData(ApiConstant.getBookedWorking(id, month, year,));
    if (response.body['success']) {
      bookedWorkData.value = BookedWorkingModel.fromJson(response.body);
      loading(false);
    } else {
      if (bookedWorkData.value.data != null) {
        loading(false);
      }
      ApiChecker.checkApi(response);
    }
  }
}
