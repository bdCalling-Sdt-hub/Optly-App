import 'package:get/get.dart';

import '../models/availability_model.dart';
import '../services/api_check.dart';
import '../services/api_constant.dart';
import '../services/api_services.dart';

class AvailabilityController extends GetxController{

  Rx<AvailabilityModel> availabilityData = AvailabilityModel().obs;

  var loading = false.obs;
  var isFirstLoading = false.obs;

  getAvailability(String date, bool isFirst) async {
    if (isFirst) {
      isFirstLoading(true);
    } else {
      loading(true);
    }

    var response = await ApiClient.getData(ApiConstant.getAvailability(date));
    if (response.statusCode == 404) {
      if (isFirst) {
        isFirstLoading(false);
      } else {
        loading(false);
      }
      availabilityData.value = AvailabilityModel.fromJson(response.body);
    } else if (response.body['success']) {
      if (isFirst) {
        isFirstLoading(false);
      } else {
        loading(false);
      }
      availabilityData.value = AvailabilityModel.fromJson(response.body);
    } else {
      if (isFirst) {
        //  isFirstLoading(false);
      } else {
        loading(false);
      }
      ApiChecker.checkApi(response);
    }
  }

}