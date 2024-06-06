import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/views/widgets/cache_network_image.dart';

import '../../../utils/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.profile.tr),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20.h),
        child: Column(
          children: [

            const Center(
              child: CustomNetworkImage(imageUrl:"https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D", height: 150, width:150,boxShape: BoxShape.circle,),

            ),

            SizedBox(height:20.h,),
            Text("Max Contract tester",style: TextStyle(fontWeight:FontWeight.w600,fontSize: 16),),
            SizedBox(height:8.h,),
            Text("test@gmail.com"),
            SizedBox(height:8.h,),
            Text("tester"),
            
            SizedBox(
              height: 30.h,
            ),
             _listTile(AppString.bookedWorkingHours.tr,(){

             }),
             _listTile(AppString.information.tr,(){

             }),
             _listTile(AppString.fee.tr,(){

             }),
             _listTile(AppString.documents.tr,(){

             }),
             _listTile(AppString.timeAccount.tr,(){

             }),
             _listTile(AppString.pinCode.tr,(){

             }),








          ],
        ),
      ),


    );
  }

   _listTile(String title,[Function()? onTap]) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
             decoration: BoxDecoration(
               color: AppColors.primaryColor.withOpacity(0.2),
               borderRadius: BorderRadius.circular(5)
             ),
             child: ListTile(
               onTap: onTap,
              title: Text(title,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
               trailing:const Icon(Icons.keyboard_arrow_right_outlined,
                         )),
           );
  }
}
