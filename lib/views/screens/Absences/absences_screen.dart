import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:optly/controller/absences_controller.dart';
import 'package:optly/utils/app_colors.dart';

class AbsencesScreen extends StatefulWidget {
  const AbsencesScreen({super.key});

  @override
  State<AbsencesScreen> createState() => _AbsencesScreenState();
}

class _AbsencesScreenState extends State<AbsencesScreen> {
  final AbsencesController _absencesController = Get.put(AbsencesController());
  @override
  void initState() {
    _absencesController.firstDayOfCurrentMonth();
    _absencesController.lastDayAfterFourMonths();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("absence".tr),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          _searchBar(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(3.r)),
                            side: BorderSide(
                                color: AppColors.primaryColor
                                    .withOpacity(0.3))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          child: Column(
                            children: [
                              _textTile("start",subTitle: "ss"
                                  ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(
                          height: 10.h,
                        ),
                    itemCount: 2),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return Container();
                    },
                    separatorBuilder: (_, __) => SizedBox(
                          height: 10.h,
                        ),
                    itemCount: 2),
              ],
            ),
          ))
        ],
      ),
    );
  }
  _textTile(String title, {String? subTitle,Widget? widget}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Text(
            title.tr,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          Expanded(
              child:widget??Text(
                subTitle??"",
                textAlign: TextAlign.right,
              )),
        ],
      ),
    );
  }

  _searchBar() {
    return Row(
      children: [
        SizedBox(
          width: 16.w,
        ),
        const Icon(Icons.date_range),
        SizedBox(
          width: 5.w,
        ),
        Flexible(
            child: TextFormField(
          controller: _absencesController.startTextCtrl,
          readOnly: true,
          decoration: InputDecoration(labelText: "from_date".tr),
          onTap: () {
            _absencesController.pickStartDate();
          },
        )),
        SizedBox(
          width: 16.w,
        ),
        const Icon(Icons.date_range),
        SizedBox(
          width: 5.w,
        ),
        Flexible(
            fit: FlexFit.tight,
            child: TextField(
              controller: _absencesController.endTextCtrl,
              readOnly: true,
              decoration: InputDecoration(labelText: "till_date".tr),
              onTap: () {
                _absencesController.pickEndDate();
              },
            )),
        SizedBox(
          width: 16.w,
        ),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              backgroundColor: AppColors.primaryColor,
              minimumSize: Size(40.h, 40.h),
              maximumSize: Size(40.h, 40.h),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 20.h,
            )),
        SizedBox(
          width: 16.w,
        ),
      ],
    );
  }
}
