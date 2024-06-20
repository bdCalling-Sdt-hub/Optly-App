import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:optly/models/absence_model.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';
import 'package:path_provider/path_provider.dart';

class AbsencesController extends GetxController {
  TextEditingController startTextCtrl = TextEditingController();
  TextEditingController endTextCtrl = TextEditingController();
  Rx<DateTime?> selectStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectEndDate = Rx<DateTime?>(null);

  firstDayOfCurrentMonth() {
    final now = DateTime.now();
    selectStartDate.value = DateTime(now.year, now.month, 1);
    startTextCtrl.text =DateFormat('dd.MM.yyyy').format(selectStartDate.value!);
  }

  // Calculate the last day of the month four months from the current month
  lastDayAfterFourMonths() {
    final now = DateTime.now();
    final nextMonth = now.month + 4;
    final year = now.year + (nextMonth > 12 ? 1 : 0);
    final month = nextMonth % 12 == 0 ? 12 : nextMonth % 12;
    final lastDayOfTargetMonth = DateTime(year, month + 1, 0);
    selectEndDate.value = lastDayOfTargetMonth;
    endTextCtrl.text =
        DateFormat('dd.MM.yyyy').format(lastDayOfTargetMonth);
  }

  pickStartDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectStartDate.value) {
      selectStartDate.value = pickedDate;
      startTextCtrl.text = DateFormat('dd.MM.yyyy').format(pickedDate);
    }
  }

  pickEndDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectEndDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectEndDate.value) {
      selectEndDate.value = pickedDate;
      endTextCtrl.text = DateFormat('dd.MM.yyyy').format(pickedDate);
    }
  }

  var loading = false.obs;
  var isFirstLoading = false.obs;

  Rx<AbsenceModel> absenceData = AbsenceModel().obs;

  getAbsence({bool isFirst = false}) async {
    if (isFirst) {
      isFirstLoading(true);
    } else {
      loading(true);
    }

    var response = await ApiClient.getData(
        ApiConstant.getAbsence( DateFormat('yyyy-MM-dd').format(selectStartDate.value!),  DateFormat('yyyy-MM-dd').format(selectEndDate.value!)));
    if (response.body['success']) {
      absenceData.value = AbsenceModel.fromJson(response.body);
      if (isFirst) {
        isFirstLoading(false);
      } else {
        loading(false);
      }
    } else {
      ApiChecker.checkApi(response);
      loading(false);
    }
  }


}
