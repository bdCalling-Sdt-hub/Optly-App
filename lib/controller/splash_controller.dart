import 'package:get/get.dart';

import '../routes/app_routes.dart';

class SplashController extends GetxController{


  jumpToNextPage() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      // bool isOnboard = await PrefsHelper.getBool(AppConstants.onBoard);
      // String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      // if(isOnboard){
      //   if(bearerToken.isNotEmpty){
      //     Get.offAll(CustomNavBar(currentIndex:0),binding:NavBarBinding());
      //   }else{
      //     Get.offAllNamed(AppRoute.signInScreen);
      //   }
      // }else{
      //   Get.offAllNamed(AppRoute.onboardScreen);
      // }

      Get.offAllNamed(AppRoutes.logInScreen);

    });
  }

}