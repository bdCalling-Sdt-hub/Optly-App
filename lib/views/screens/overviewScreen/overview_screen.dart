import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:optly/routes/app_routes.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/utils/app_images.dart';
import 'package:optly/views/widgets/custom_text.dart';
import '../../../controller/overview_controller.dart';
import '../../../utils/app_icons.dart';
import 'innerWidget/overview_drawer.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});
  final OverviewController _overviewController = Get.put(OverviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _overviewController.scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: IconButton(
            icon: SvgPicture.asset(AppIcons.menu),
            onPressed: () {
              _overviewController.scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: CircleAvatar(
                child: Image.asset(AppImages.person, fit: BoxFit.contain),
              ),
            ),
          )
        ],
      ),
      drawer: OverviewDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: 'This is Overview Screen',
            )
          ],
        ),
      ),
    );
  }
}
