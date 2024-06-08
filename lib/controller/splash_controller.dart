import 'package:get/get.dart';

import '../helpers/prefs_helpers.dart';
import '../routes/app_routes.dart';
import '../utils/app_constants.dart';

class SplashController extends GetxController{


  jumpToNextPage() async {
    await Future.delayed(const Duration(seconds: 3), () async {

      String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);


        if(bearerToken.isNotEmpty){
          Get.offAllNamed(AppRoutes.dashboardScreen);
        }else{
          Get.offAllNamed(AppRoutes.logInScreen);
        }
      }


    );
  }

}