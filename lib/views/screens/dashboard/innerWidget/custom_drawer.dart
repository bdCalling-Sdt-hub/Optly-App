import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_icons.dart';
import '../../../widgets/custom_text.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
           DrawerHeader(child:Padding(
             padding:  EdgeInsets.symmetric(horizontal: 50.w),
             child: Image.asset(AppIcons.appLogo,),
           )),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              children: [
                //===========================> Overview Tile <======================
                // CustomListTile(
                //   priIcon:AppIcons.overview,
                //   title: 'Overview',
                //   onTab: () {},
                // ),
                //==========================> MyProfile Tile <======================
                CustomListTile(
                  priIcon: AppIcons.person,
                  title: 'My Profile',
                  onTab: () {
                    Get.back();
                    Get.toNamed(AppRoutes.profileScreen);
                  },
                ),
                //============================> Task Tile <=========================
                // CustomListTile(
                //   priIcon: AppIcons.task,
                //   title: 'Task',
                //   onTab: () {
                //     Get.back();
                //     Get.toNamed(AppRoutes.tasksScreen);
                //   },
                // ),
                // //===========================> Notes Tile <=========================
                // CustomListTile(
                //   priIcon:AppIcons.notes,
                //   title: 'Notes',
                //   onTab: () {
                //     Get.back();
                //     Get.toNamed(AppRoutes.notesScreen);
                //   },
                // ),
                //=========================> Shift Plan Tile <========================
                CustomListTile(
                  priIcon: AppIcons.shiftPlan,
                  title: 'Shift Plan',
                  onTab: () {},
                ),
                //========================> Availability Tile <=======================
                CustomListTile(
                  priIcon:AppIcons.availability,
                  title: 'Availability',
                  onTab: () {},
                ),
                //========================> Hygiene plans Tile <=====================
                // CustomListTile(
                //   priIcon:AppIcons.hygienePlan,
                //   title: 'Hygiene Plans',
                //   onTab: () {},
                // ),
                // //====================> Hygiene maintenance Tile <===================
                // CustomListTile(
                //   priIcon:AppIcons.hygieneMain,
                //   title: 'Hygiene Maintenance',
                //   onTab: () {},
                // ),
                // //===========================> Products Tile <========================
                // CustomListTile(
                //   priIcon: AppIcons.products,
                //   title: 'Products',
                //   onTab: () {},
                // ),
                // //=========================> Inventories Tile <======================
                // CustomListTile(
                //   priIcon: AppIcons.inventories,
                //   title: 'Inventories',
                //   onTab: () {},
                // ),
                // //========================> Team Calendar Tile <======================
                // CustomListTile(
                //   priIcon: AppIcons.calender,
                //   title: 'Team Calendar',
                //   onTab: () {},
                // ),
                //===========================> Absence Tile <=========================
                CustomListTile(
                  priIcon:AppIcons.absences,
                  title: 'Absence',
                  onTab: () {},
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
        leading: SvgPicture.asset(priIcon,height: 24,width: 24,),
        title: CustomText(text: title,fontWeight: FontWeight.w600,fontsize: 14.sp,textAlign: TextAlign.start,),
        onTap: onTab);
  }
}
