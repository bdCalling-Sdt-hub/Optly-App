import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/utils/app_strings.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(color: AppColors.primaryColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.h),
                      child: CustomText(
                          text: AppString.logInPanel, color: AppColors.white),
                    ),
                    Container(
                      decoration: BoxDecoration(color: AppColors.fieldColor),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //==================================> Username Text-field <===========================
                            CustomText(
                              text: AppString.userName,
                            ),
                            CustomTextField(
                              contenpaddingHorizontal: 12.w,
                              controller: userNameCtrl,
                              hintText: 'Enter your user name',
                              prifixicon: SvgPicture.asset(AppIcons.person),
                            ),
                            //==================================> Password Text-field <===========================
                            SizedBox(height: 20.h),
                            CustomText(
                              text: AppString.password,
                            ),
                            CustomTextField(
                              contenpaddingHorizontal: 12.w,
                              controller: passwordCtrl,
                              hintText: 'Enter your password',
                              prifixicon: SvgPicture.asset(AppIcons.lock),
                              isPassword: true,
                            ),
                            SizedBox(height: 30.h),
                            //==================================> Register Button <===========================
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.overviewScreen);
                              },
                              child: Container(
                                decoration:
                                    BoxDecoration(color: AppColors.primaryColor),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 12.h),
                                  child: CustomText(
                                    text: AppString.register,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
