import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:optly/controller/data_controller.dart';
import '../../../../controller/dashboard_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';
import '../../Absences/absences_screen.dart';
import '../../availability/availability_screen.dart';
import '../../bookedWorking/booked_working.dart';
import '../../folder&documents/folders.dart';
import '../../mySchedulePlan/my_schedule_plan.dart';
import '../../personalInfo/personal_information.dart';
import '../../timeAccount/time_account.dart';


class CustomDrawer extends StatelessWidget {
   CustomDrawer({
    super.key,
  });

  final _dataController = Get.put(DataController());
   final _dashboardController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Image.asset(
              AppIcons.appLogo,
            ),
          )),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              children: [
                //==========================> MyProfile Tile <======================
                CustomListTile(
                  priIcon: "assets/icons/view-grid.svg",
                  title: "Überblick",
                  onTab: () {
                    Get.back();
                    _dashboardController.getDashboard();
                  },
                ),
                //==========================> MyProfile Tile <======================
                CustomListTile(
                  priIcon: "assets/icons/user-circle.svg",
                  title: "Mein Profil",
                  onTab: () {
                   Get.toNamed(AppRoutes.profileScreen);
                  },
                ),

                CustomListTile(
                  title: AppString.bookedWorkingHours.tr,
                  onTab: () {
                    Get.to(BookedWorking(
                      id: _dataController.userId.value.toString(),
                    ));
                  },
                  priIcon: "assets/icons/clip_pt.svg",
                ),
                //=========================> Shift Plan Tile <========================
                CustomListTile(
                  priIcon:"assets/icons/alearts.svg",
                  title: 'shift_plan'.tr,
                  onTab: () {
                    Get.back();
                    Get.to(const MySchedulePlanScreen());
                  },
                ),

                //========================> Availability Tile <=======================
                CustomListTile(
                  priIcon:"assets/icons/alearts_2.svg",
                  title: 'availability'.tr,
                  onTab: () {
                    Get.back();
                    Get.to(AvailabilityScreen());
                  },
                ),



                CustomListTile(
                  title: AppString.documents.tr,
                  onTab: () {
                    Get.to(FoldersScreen(
                      userId:_dataController.userId.value.toString(),
                    ));
                  },
                  priIcon:"assets/icons/File_Document.svg",
                ),
                CustomListTile(
                  title: "timeAccount".tr,
                  onTab: () {
                    Get.to( TimeAccountScreen(
                      userId: _dataController.userId.value.toString(),
                    ));
                  },
                  priIcon: "assets/icons/Timer.svg",
                ),
                CustomListTile(
                  title: AppString.information.tr,
                  onTab: () {
                    Get.to(const PersonalInformation());
                  },
                  priIcon: "assets/icons/clip_pt2.svg",
                ),



                //===========================> Absence Tile <=========================
                CustomListTile(
                  priIcon: "assets/icons/calendar.svg",
                  title: 'absence'.tr,
                  onTab: () {
                    Get.back();
                    Get.to(const AbsencesScreen());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String priIcon;
  final VoidCallback onTab;
  const CustomListTile({
    super.key,
    required this.title,
    required this.priIcon,
    required this.onTab,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
        // contentPadding: EdgeInsets.zero,
        // dense: true,
        // horizontalTitleGap: ,
        leading: SvgPicture.asset(
          priIcon,
          height: 24,
          width: 24,
          color: Colors.grey,
        ),
        title: CustomText(
          text: title,
          fontWeight: FontWeight.w600,
          fontsize: 14.sp,
          color: Colors.black54,
          textAlign: TextAlign.start,
        ),
        onTap: onTab);
  }
}
