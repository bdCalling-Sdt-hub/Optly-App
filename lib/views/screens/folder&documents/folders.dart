import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/views/screens/folder&documents/widget/folder_details.dart';

class FoldersScreen extends StatelessWidget {
 final  userId;
  FoldersScreen({super.key,required this.userId});

  final List<dynamic> folderList = [
    {"name": "timesheets".tr, "type": "timereport"},
    {"name": "payroll".tr, "type": "payroll"},
    {"name": "documents".tr, "type": "document"},
    {"name": "contracts".tr, "type": "vertrag"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("documents".tr),
      ),
      body: ListView.separated(

        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
          itemBuilder: (context, index) {
            var data= folderList[index];
            return ListTile(
              onTap:(){
                Get.to(FolderDetails(folderName:data["name"], folderType:data['type'], userId: userId.toString()));
              },
              leading: const Icon(Icons.folder,color:Colors.lightBlueAccent,),
              title: Text(data['name'],)
            );
            // return GestureDetector(
            //   onTap: (){
            //     Get.to(FolderDetails(folderName:data["name"], folderType:data['type'], userId: userId.toString()));
            //
            //   },
            //   child: Row(
            //     children: [
            //       const Icon(Icons.folder,color:Colors.lightBlueAccent,),
            //       SizedBox(width: 10.w,),
            //       Expanded(child:Text(data['name']))
            //     ],
            //   ),
            // );
          },
          separatorBuilder: (context, index) {
            return  Divider(color:AppColors.dividerColor,);
          },
          itemCount: folderList.length),
    );
  }
}
