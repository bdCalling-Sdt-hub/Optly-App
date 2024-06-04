import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/utils/app_images.dart';
import 'package:optly/utils/app_strings.dart';
import 'package:optly/views/widgets/custom_button.dart';
import 'package:optly/views/widgets/custom_text.dart';
import 'package:optly/views/widgets/custom_text_field.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_icons.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  final TextEditingController userNameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h,),
              Center(child: SvgPicture.asset(AppImages.loginImage)),

              SizedBox(height: 40.h,),

              CustomText(
                text: AppString.userName.tr,
              ),
              SizedBox(height: 8.h,),
              CustomTextField(
                contenpaddingHorizontal: 12.w,
                controller: userNameCtrl,
                hintText: AppString.enterYourName.tr,
                prifixicon: SvgPicture.asset(AppIcons.person),
              ),
              //==================================> Password Text-field <===========================
              SizedBox(height: 20.h),
              CustomText(
                text: AppString.password.tr,
              ),
              SizedBox(height: 8.h,),
              CustomTextField(
                contenpaddingHorizontal: 12.w,
                controller: passwordCtrl,
                hintText:AppString.enterYourPassword.tr,
                prifixicon: SvgPicture.asset(AppIcons.lock),
                isPassword: true,
              ),
              SizedBox(height: 60.h),
              //==================================> Register Button <===========================
              CustomButton(onTap: (){
                Get.toNamed(AppRoutes.dashboardScreen);

              }, text:AppString.signIn.tr)
            ],
          ),
        ),
      ),
    );
  }
}
