import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_icons.dart';
import '../../../widgets/custom_text.dart';

class OverviewDrawer extends StatelessWidget {
  const OverviewDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280.w,
      child: ListView(
        children: [
          //===========================> Overview Tile <======================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.overview),
            title: 'Overview',
            onTab: () {},
          ),
          //==========================> MyProfile Tile <======================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.person),
            title: 'My Profile',
            onTab: () {},
          ),
          //============================> Task Tile <=========================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.task),
            title: 'Task',
            onTab: () {},
          ),
          //===========================> Notes Tile <=========================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.notes),
            title: 'Notes',
            onTab: () {},
          ),
          //=========================> Shift Plan Tile <========================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.shiftPlan),
            title: 'Shift Plan',
            onTab: () {},
          ),
          //========================> Availability Tile <=======================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.availability),
            title: 'Availability',
            onTab: () {},
          ),
          //========================> Hygiene plans Tile <=====================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.hygienePlan),
            title: 'Hygiene Plans',
            onTab: () {},
          ),
          //====================> Hygiene maintenance Tile <===================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.hygieneMain),
            title: 'Hygiene Maintenance',
            onTab: () {},
          ),
          //===========================> Products Tile <========================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.products),
            title: 'Products',
            onTab: () {},
          ),
          //=========================> Inventories Tile <======================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.inventories),
            title: 'Inventories',
            onTab: () {},
          ),
          //========================> Team Calendar Tile <======================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.calender),
            title: 'Team Calendar',
            onTab: () {},
          ),
          //===========================> Absence Tile <=========================
          CustomListTile(
            priIcon: SvgPicture.asset(AppIcons.absences),
            title: 'Absence',
            onTab: () {},
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final Widget priIcon;
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
        leading: priIcon,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: title),
          ],
        ),
        onTap: onTab);
  }
}
