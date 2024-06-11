import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../widgets/custom_text_field.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextCtrl = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
              controller: searchTextCtrl,
              sufixicons:
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 3,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5.h),
                        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5),

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Title",style: TextStyle(fontWeight: FontWeight.w600),),
                            Row(
                              children: [
                                Text("Created by : ",style: TextStyle(color:AppColors.greyColor),),
                                const Flexible(child: Text("Super 2 Admin",style: TextStyle(color:Colors.red),)),
                              ],
                            ),
                            Row(children: [
                              Text("Created on : ",style: TextStyle(color:AppColors.greyColor),),
                              Flexible(child: Text("27.05.2024 16:06",style: TextStyle(color: Colors.black.withOpacity(0.7)),))
                            ],),
                            Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14.sp)),
                          ],
                        ),


                      );

                    })
            )
          ],
        ),
      ),
    );
  }
}
