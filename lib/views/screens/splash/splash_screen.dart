import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:optly/controller/splash_controller.dart';
import 'package:optly/utils/app_colors.dart';

import '../../../utils/app_icons.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
  final _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
   _controller.jumpToNextPage();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,

          children: [
            Center(child: Image.asset(AppIcons.appLogo,width: Get.width/1.5,)),

            Positioned(
                bottom:50.h,
                child:SpinKitChasingDots(
              color:AppColors.primaryColor,
              size: 50.0,
            )
            )
          ],
        ),
      ),

    );
  }
}
