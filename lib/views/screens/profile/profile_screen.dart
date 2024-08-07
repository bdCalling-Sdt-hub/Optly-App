import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/controller/profile_controller.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/views/screens/bookedWorking/booked_working.dart';
import 'package:optly/views/widgets/cache_network_image.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';

import '../../../utils/app_strings.dart';
import '../folder&documents/folders.dart';
import '../personalInfo/personal_information.dart';
import '../timeAccount/time_account.dart';

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
        actions: [
          IconButton(
              onPressed: () {
                _profileController.logOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ))
        ],
      ),
      body: Obx(
        () => _profileController.loading.value
            ? const CustomPageLoading()
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20.h),
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          !_profileController.uploadImageLoading.value
                              ? CustomNetworkImage(
                                  imageUrl: _profileController
                                      .profileData.value.data!.info!.imageurl!,
                                  height: 80,
                                  width: 80,
                                  boxShape: BoxShape.circle,
                                  border:
                                      Border.all(color: AppColors.primaryColor),
                                )
                              : Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  _profileController.pickImage();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 1),
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  padding: const EdgeInsets.all(5),
                                  child: const Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 15,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      _profileController
                          .profileData.value.data!.info!.username!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(_profileController
                        .profileData.value.data!.info!.jobtitle!),
                    SizedBox(
                      height: 8.h,
                    ),
                    Wrap(
                      children:List.generate(2, (index){
                        var e= _profileController.profileData.value.data!.workercategory![index];
                     
                  
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey
                                ),
                                child: Text(e.title!,style: const TextStyle(color: Colors.white),),
                          );
                        
                      }),
                      // children: _profileController
                      //     .profileData.value.data!.workercategory!
                      //     .map((e) {
                      //   var getIndex = _profileController
                      //       .profileData.value.data!.info!.workercategories!
                      //       .indexOf(e);
                      //   Color hexToColor(String hexString) {
                      //     final buffer = StringBuffer();
                      //     if (hexString.length == 6 || hexString.length == 7)
                      //       buffer.write('ff');
                      //     buffer.write(hexString.replaceFirst('#', ''));
                      //     return Color(int.parse(buffer.toString(), radix: 16));
                      //   }

                      //   if (getIndex < 2) {
                      //     return Container(
                      //       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(50),
                      //           color: hexToColor(e.color!)
                      //           ),
                      //           child: Text(e.title!,style: TextStyle(color: Colors.white),),
                      //     );
                      //   }

                      //   return Container();
                      // }).toList(),
                    
                    
                    
                    )

                    // _listTile(AppString.bookedWorkingHours.tr, () {
                    //   Get.to(BookedWorking(
                    //     id: _profileController.profileData.value.data!.info!.id,
                    //   ));
                    // }),
                    // _listTile(AppString.information.tr, () {
                    //   Get.to(const PersonalInformation());
                    // }),
                    // _listTile(AppString.documents.tr, () {
                    //   Get.to(FoldersScreen(
                    //     userId:
                    //         _profileController.profileData.value.data!.info!.id,
                    //   ));
                    // }),
                    // _listTile("timeAccount".tr, () {
                    //   Get.to(TimeAccountScreen(
                    //     userId: _profileController
                    //         .profileData.value.data!.info!.id
                    //         .toString(),
                    //   ));
                    // }),
                    // _listTile("logout".tr, () {
                    //   _profileController.logOut();
                    // }),
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
