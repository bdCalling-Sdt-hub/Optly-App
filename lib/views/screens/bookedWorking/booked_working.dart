import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';

class BookedWorking extends StatefulWidget {
   BookedWorking({super.key});

  @override
  State<BookedWorking> createState() => _BookedWorkingState();
}

class _BookedWorkingState extends State<BookedWorking> {
  DateTime _focusedDay = DateTime.now();

  String dropdownvalue = 'sort_by';


  // List of items in our dropdown menu
  var items = [
    "sort_by",
    'end',
    'pause',
    'times_worked',
    'location',
    'salary',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("booked_working_hours".tr),
      ),

      body:Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h,),
            _buildHeader(),
            SizedBox(height: 10.h,),
            Align(
              alignment:Alignment.centerRight,
              child: SizedBox(
                width: Get.width/2.8,
                child: DropdownButton(
                  // Initial Value
                  value: dropdownvalue,
                  hint:Text("sort_by".tr),
                  isExpanded: true,
                 underline:Container(
                   decoration: BoxDecoration(
                     border: Border.all(color: AppColors.primaryColor)
                   ),
                 ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items.tr,maxLines: 1,overflow: TextOverflow.ellipsis,),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            )





          ],
        ),
      ),

    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: AppColors.primaryColor),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color:  Colors.black,
            ),
            onPressed: () {
                setState(() {
                  _focusedDay =
                      DateTime(_focusedDay.year, _focusedDay.month - 1, 1);

                });
            }, // Disabled previous month button
          ),
          Expanded(
              child: Text(
                textAlign: TextAlign.center,
                DateFormat('MMMM yyyy').format(_focusedDay),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          IconButton(
            icon: const Icon(Icons.chevron_right,color: Colors.black,),
            onPressed: () {
              setState(() {
                _focusedDay =
                    DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
              });
            },
          ),
        ],
      ),
    );
  }
}
