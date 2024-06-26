import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:optly/controller/absences_controller.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../../helpers/prefs_helpers.dart';
import '../../../utils/app_constants.dart';
import 'add_absences_dialog.dart';

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
    _absencesController.getAbsence(isFirst: true);
    super.initState();
  }

  double _progress = 10.0;
  bool _downloading = false;
  late Future<void> _downloadFuture;

  Future<void> downloadFile(String url, String fileName) async {
    setState(() {
      _downloading = true;
      debugPrint("Url : $url");
    });

    try {
      // Get the application directory for storing the file
      var dir = await getApplicationDocumentsDirectory();
      String filePath = "${dir.path}/$fileName";
      var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken'
      };

      // Send HTTP GET request
      var request = http.Request(
          'GET',
          Uri.parse(
            url,
          ));
      request.headers.addAll(mainHeaders);
      var response = await request.send();

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Create a file to write the downloaded bytes
        File file = File(filePath);
        var bytes = <int>[];
        int downloadedBytes = 0;

        // Listen for the response stream and write to the file
        response.stream.listen(
          (List<int> newBytes) {
            bytes.addAll(newBytes);
            downloadedBytes += newBytes.length;
            setState(() {
              _progress = downloadedBytes / response.contentLength!;
            });
          },
          onDone: () async {
            await file.writeAsBytes(bytes);
            print("File downloaded to: $filePath");
            setState(() {
              _downloading = false;
            });
          },
          onError: (e) {
            print("Download failed: $e");
            setState(() {
              _downloading = false;
            });
          },
          cancelOnError: true,
        );
      } else {
        print("Download failed: ${response.statusCode}");
        setState(() {
          _downloading = false;
        });
      }
    } catch (e) {
      print("Download failed: $e");
      setState(() {
        _downloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("absence".tr),
      ),
      body: Obx(
        () => _absencesController.isFirstLoading.value
            ? const Center(child: CustomPageLoading())
            : Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  if (_downloading)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: LinearProgressIndicator(
                        value: _progress,
                        backgroundColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  SizedBox(
                    height: 10.h,
                  ),
                  _searchBar(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                      child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            _absencesList(),
                            const Divider(),
                            _diseaseReportsList(),
                            _overviewCurrentYear(),
                            SizedBox(
                              height: 40.h,
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          child: _absencesController.loading.value
                              ? const CustomPageLoading()
                              : const SizedBox()),
                    ],
                  ))
                ],
              ),
      ),
    );
  }

  _overviewCurrentYear() {
    var data = _absencesController.absenceData.value.data!.summary;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(3.r)),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "overview_current_year".tr,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15.h,
            ),
            _textTile("Entitlement to vacation days for the current year".tr,
                subTitle: data!.vacationdays.toString()),
            const Divider(
              color: Colors.grey,
            ),
            _textTile("approved_vacation_days".tr, subTitle: "0"),
            const Divider(
              color: Colors.grey,
            ),
            _textTile("open_vacation_requests".tr,
                subTitle: data.open.toString()),
            const Divider(
              color: Colors.grey,
            ),
            _textTile("remaining_vacation_days".tr,
                subTitle: data.vacationdays.toString()),
          ],
        ),
      ),
    );
  }

  _absencesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              "absences".tr,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            )),
            OutlinedButton(
                onPressed: () {
                  showDialog(context: context, builder:(_)=>AddAbsencesDialog());
                },
                style: OutlinedButton.styleFrom(
                    maximumSize: Size(40.w, 30.w),
                    minimumSize: Size(40.w, 30.w),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        side: BorderSide(color: AppColors.primaryColor))),
                child: Text("NEU")),
          ],
        ),
        ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              var data =
                  _absencesController.absenceData.value.data!.absence![index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3.r)),
                    side: BorderSide(
                        color: AppColors.primaryColor.withOpacity(0.3))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Column(
                    children: [
                      _textTile("start_date",
                          subTitle:
                              DateFormat('dd.MM.yyyy').format(data.startdate!)),
                      _textTile("end_date",
                          subTitle:
                              DateFormat('dd.MM.yyyy').format(data.enddate!)),
                      _textTile("absence_type", subTitle: data.type ?? ""),
                      _textTile("description",
                          subTitle: data.description ?? ""),
                      _textTile("take", subTitle: ""),
                      _textTile("status",
                          widget: Text(
                            data.status == 1
                                ? "übermittelt"
                                : data.status == 2
                                    ? "Genehmigt"
                                    : "Abgelehnt",
                            style: TextStyle(
                                color: data.status == 1
                                    ? Colors.orange
                                    : data.status == 2
                                        ? Colors.green
                                        : Colors.red),
                          )),
                      if (data.status == 1)
                        _textTile("action",
                            widget: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )))),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(
                  height: 10.h,
                ),
            itemCount:
                _absencesController.absenceData.value.data!.absence!.length),
      ],
    );
  }

  _diseaseReportsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              "Disease_reports".tr,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            )),
            OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    maximumSize: Size(40.w, 30.w),
                    minimumSize: Size(40.w, 30.w),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        side: BorderSide(color: AppColors.primaryColor))),
                child: Text("NEU")),
          ],
        ),
        ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              var data =
                  _absencesController.absenceData.value.data!.sick![index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3.r)),
                    side: BorderSide(
                        color: AppColors.primaryColor.withOpacity(0.3))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Column(
                    children: [
                      _textTile("start_date",
                          subTitle:
                              DateFormat('dd.MM.yyyy').format(data.startdate!)),
                      _textTile("end_date",
                          subTitle:
                              DateFormat('dd.MM.yyyy').format(data.enddate!)),
                      _textTile("picture",
                          widget: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                                onTap: () {
                                  downloadFile(
                                      "https://api.optly.de/api/v1/files/${data.docid}",
                                      data.filename!);
                                },
                                child: Icon(Icons.request_page_sharp)),
                          )),
                      _textTile("take", subTitle: ""),
                      _textTile("status",
                          widget: Text(
                            data.status == 1
                                ? "Eingereicht"
                                : data.status == 2
                                    ? "Bearbeitet"
                                    : "",
                            style: TextStyle(
                                color: data.status == 1
                                    ? Colors.orange
                                    : data.status == 2
                                        ? Colors.green
                                        : Colors.red),
                          )),
                      _textTile("action",
                          widget: const Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(),
                            // child: IconButton(
                            //     onPressed: () {},
                            //     icon: const Icon(
                            //       Icons.delete,
                            //       color: Colors.red,
                            //     ))
                          )),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(
                  height: 10.h,
                ),
            itemCount:
                _absencesController.absenceData.value.data!.sick!.length),
      ],
    );
  }

  _textTile(String title, {String? subTitle, Widget? widget}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title.tr,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: 50.w,
          ),
          widget ??
              Text(
                subTitle ?? "",
                textAlign: TextAlign.right,
              ),
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
            onPressed: () {
              _absencesController.getAbsence();
            },
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
