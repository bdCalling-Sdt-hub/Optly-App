import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:optly/controller/data_controller.dart';
import 'package:optly/helpers/prefs_helpers.dart';
import 'package:optly/routes/app_routes.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';
import 'package:optly/utils/app_constants.dart';

class AuthController extends GetxController {
  final dataController = Get.put(DataController(), permanent: true);

  var loadingSignIn = false.obs;

  handleSignIn(String email, pass) async {
    loadingSignIn(true);
    var header = {
      'Content-Type': 'application/json',
    };
    var response = await ApiClient.postData(
        ApiConstant.signIn(email, pass), null,
        headers: header);
    if (response.body['success']) {
      await PrefsHelper.setString(
          AppConstants.bearerToken, response.body['data']['token']);

      await dataController.setData(
          nameD: response.body['data']['user']['name'],
          roleD: response.body['data']['user']['role'],
          emailD: response.body['data']['user']['email'],
          firstnameD: response.body['data']['user']['firstname'],
          lastnameD: response.body['data']['user']['lastname'],
          imageD: response.body['data']['user']['imageurl'],
          userid: response.body['data']['user']['id']);

      Get.offAllNamed(AppRoutes.dashboardScreen);
    } else {
      ApiChecker.checkApi(response, getXSnackBar: true);
      debugPrint("test snackbar");
    }
    loadingSignIn(false);
  }
}
