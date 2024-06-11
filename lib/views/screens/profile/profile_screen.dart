import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/controller/profile_controller.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/views/widgets/cache_network_image.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';

import '../../../utils/app_strings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileController = Get.put(ProfileController());
  @override
  void initState() {
    _profileController.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.profile.tr),
      ),
      body: Obx(
        () => _profileController.loading.value
            ? const CustomPageLoading()
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20.h),
                child: Column(
                  children: [
                    Center(
                      child: CustomNetworkImage(
                        imageUrl: _profileController
                            .profileData.value.data!.info!.imageurl!,
                        height: 100.h,
                        width: 100.h,
                        boxShape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      _profileController.profileData.value.data!.info!.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(_profileController
                        .profileData.value.data!.info!.email!),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(_profileController
                        .profileData.value.data!.info!.username!),
                    SizedBox(
                      height: 30.h,
                    ),
                    _listTile(AppString.bookedWorkingHours.tr, () {}),
                    _listTile(AppString.information.tr, () {}),
                    _listTile(AppString.fee.tr, () {}),
                    _listTile(AppString.documents.tr, () {}),
                    _listTile(AppString.timeAccount.tr, () {}),
                    _listTile(AppString.pinCode.tr, () {}),
                  ],
                ),
              ),
      ),
    );
  }

  _listTile(String title, [Function()? onTap]) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5)),
      child: ListTile(
          onTap: onTap,
          title: Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right_outlined,
          )),
    );
  }
}
