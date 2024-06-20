import 'package:get/get.dart';

import '../views/widgets/custom_snackbar.dart';
class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) async {
    if (!response.body['success']) {
      if (response.statusCode == 401) {
      } else {

        showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
      }
    }else{

    }
  }
}