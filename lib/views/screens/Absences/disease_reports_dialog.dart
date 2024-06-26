import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:optly/views/widgets/custom_text_field.dart';

import '../../../controller/absences_controller.dart';
import 'package:file_picker/file_picker.dart';

class DiseaseReportsDialog extends StatefulWidget {
  DiseaseReportsDialog({super.key});

  @override
  State<DiseaseReportsDialog> createState() => _DiseaseReportsDialogState();
}

class _DiseaseReportsDialogState extends State<DiseaseReportsDialog> {
  final AbsencesController _absencesController = Get.put(AbsencesController());
  TextEditingController startTextCtrl = TextEditingController();
  TextEditingController endTextCtrl = TextEditingController();
  TextEditingController fileNameTextCtrl = TextEditingController();

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

  final _formKey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();
  File? imageFile;

  pickImage(ImageSource imageSource) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      fileNameTextCtrl.text = p.basename(image.path);
      Get.back();
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        fileNameTextCtrl.text = file.name;
        imageFile = File(file.path!);
        Get.back();
      });
    } else {
      // User canceled the picker
    }
  }

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
              height: 15.h,
            ),
            Row(
              children: [
                const Icon(Icons.file_present),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: fileNameTextCtrl,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Dieses Feld ist erforderlich.";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Arbeitsunfähigkeitsbescheinigung hochladen",
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder()),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: Colors.white,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        pickImage(ImageSource.gallery);
                                      },
                                      title: const Text("Fotobibliothek"),
                                      trailing: const Icon(
                                          Icons.photo_library_outlined),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        pickImage(ImageSource.camera);
                                      },
                                      title: const Text("Foto aufnehmen"),
                                      trailing: const Icon(
                                          Icons.photo_camera_outlined),
                                    ),
                                     ListTile(
                                      title: Text("Datei auswählen"),
                                      trailing: Icon(Icons.folder_copy),
                                      onTap: (){
                                        _pickFile();
                                      },
                                    )
                                  ],
                                ),
                              ));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            if (selectEndDate.value != null &&
                selectStartDate.value != null &&
                selectEndDate.value!
                        .difference(selectStartDate.value!)
                        .inDays >=
                    3)
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
                      " Du kannst maximal 3 Tage ohne eine Arbeitsunfähigkeitsbescheinigung fehlen.",
                      style: TextStyle(color: Colors.white),
                    )),
                  ],
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
                      "Ihre Krankenmeldung geht über das Monatsende hinaus. Es werden automatisch jeweils pro Monat eine Krankenmeldung erstellt.",
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
                _absencesController.addSickAbsence(
                    startDate: selectStartDate.value!,
                    endDate: selectEndDate.value!,filePath:imageFile);
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
