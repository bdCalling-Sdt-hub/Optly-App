import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/date_period_helper.dart';
import '../../../utils/app_colors.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {

  late DatePeriod _currentPeriod;



  @override
  void initState() {
    super.initState();
    _currentPeriod = DatePeriod(DateTime.now());

  }

  void _nextPeriod() {
    setState(() {
      _currentPeriod = _currentPeriod.next();

    });
  }

  void _previousPeriod() {
    setState(() {
      _currentPeriod = _currentPeriod.previous();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("availability".tr),),
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
          children: [
            _buildHeader(),



          ],
        ),



      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.primaryColor),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: _previousPeriod, // Disabled previous month button
          ),
          Expanded(
              child: Text(
                textAlign: TextAlign.center,
                _currentPeriod.toString(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          IconButton(
            icon: const Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
            onPressed: _nextPeriod,
          ),
        ],
      ),
    );
  }
}
