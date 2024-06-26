import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:optly/views/widgets/custom_text_field.dart';

import '../../../controller/absences_controller.dart';

class AddAbsencesDialog extends StatefulWidget {
  AddAbsencesDialog({super.key});

  @override
  State<AddAbsencesDialog> createState() => _AddAbsencesDialogState();
}

class _AddAbsencesDialogState extends State<AddAbsencesDialog> {
  final AbsencesController _absencesController = Get.put(AbsencesController());
  TextEditingController startTextCtrl = TextEditingController();

  TextEditingController endTextCtrl = TextEditingController();
  TextEditingController description = TextEditingController();
  Rx<DateTime?> selectStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectEndDate = Rx<DateTime?>(null);

  pickDate(bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      if (isStart) {
        startTextCtrl.text = DateFormat('dd.MM.yyyy').format(pickedDate);
        selectStartDate.value = pickedDate;
      } else {
        endTextCtrl.text = DateFormat('dd.MM.yyyy').format(pickedDate);
        selectEndDate.value = pickedDate;
      }
      setState(() {});
    }
  }

  final List<String> items = ['Urlaub'];
  String? selectedItem;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "Neuen Abwesenheitsantrag erstellen",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.date_range),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: TextFormField(
                    controller: startTextCtrl,
                    readOnly: true,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Dieses Feld ist erforderlich.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "from_date".tr),
                    onTap: () {
                      pickDate(true);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                const Icon(Icons.date_range),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: TextFormField(
                    controller: endTextCtrl,
                    readOnly: true,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Dieses Feld ist erforderlich.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "till_date".tr),
                    onTap: () {
                      pickDate(false);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: DropdownButtonFormField<String>(
                hint: const Text('Abwesenheitstyp'),
                value: selectedItem,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Dieses Feld ist erforderlich.";
                  }
                  return null;
                },
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: description,
                decoration: const InputDecoration(hintText: "Beschreibung"),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            if (selectEndDate.value != null &&
                selectStartDate.value != null &&
                selectStartDate.value!.month != selectEndDate.value!.month)
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.blue),
                padding: EdgeInsets.all(10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Flexible(
                        child: Text(
                      "Ihr Urlaubsantrag geht über das Monatsende hinaus. Es werden automatisch jeweils pro Monat ein Urlaubsantrag erstellt.",
                      style: TextStyle(color: Colors.white),
                    )),
                  ],
                ),
              )
          ],
        ),
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _absencesController.addAbsence(
                    type: selectedItem ?? "",
                    startDate: selectStartDate.value!,
                    endDate: selectEndDate.value!);
              }
            },
            child: const Text("Erstellen")),
        OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Abbrechen",
              style: TextStyle(color: Colors.red),
            )),
      ],
    );
  }
}
