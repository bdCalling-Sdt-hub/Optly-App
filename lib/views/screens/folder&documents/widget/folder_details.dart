import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/controller/folder_and_docs_controller.dart';
import 'package:optly/helpers/prefs_helpers.dart';
import 'package:optly/utils/app_constants.dart';
import 'package:optly/views/widgets/custom_button.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../../../utils/app_colors.dart';

class FolderDetails extends StatefulWidget {
  const FolderDetails(
      {super.key,
      required this.folderName,
      required this.folderType,
      required this.userId});
  final String folderName;
  final String folderType;
  final String userId;

  @override
  State<FolderDetails> createState() => _FolderDetailsState();
}

class _FolderDetailsState extends State<FolderDetails> {
  final FolderAndDocsController _folderAndDocsController =
      Get.put(FolderAndDocsController());

  TextEditingController fileNameTextCtrl = TextEditingController();
  File? imageFile;
  @override
  void initState() {
    _folderAndDocsController.getDocs(widget.userId, widget.folderType,true);

    super.initState();
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
        title: Text(widget.folderName),
      ),
      body: Obx(() => _folderAndDocsController.loading.value
          ? const Center(child: CustomPageLoading())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                      if (_downloading)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: LinearProgressIndicator(
                        value: _progress,
                        backgroundColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  _folderAndDocsController.docsList.isEmpty
                      ? Center(
                          child: Text("no_data_available".tr),
                        )
                      : ListView.separated(
                          itemCount: _folderAndDocsController.docsList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = _folderAndDocsController.docsList[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.r)),
                                  side: BorderSide(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.3))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 15.h),
                                child: Column(
                                  children: [
                                    _textTile(
                                        "name",
                                        data.filename ?? "",
                                        
                                        TextStyle(
                                            color: AppColors.primaryColor),

                                            (){
                                        downloadFile(
                                      "https://api.optly.de/api/v1/files/${data.id}",
                                      data.filename!);        }

                                    
                                            
                                            ),
                                    _textTile(
                                        "created_by",
                                        data.creator ??
                                            "automatically_generated".tr,
                                        const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    _textTile(
                                        "created_on",
                                        data.createdAt ?? "",
                                        TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6))),
                                    _textTile(
                                      "action",
                                      "",
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                        ),
                  SizedBox(
                    height: 16.h,
                  ),
                  if (widget.folderType == "document")
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
                                labelText:
                                    "Hier klicken um Dokumente hochzuladen",
                                hintText:
                                    "Hier klicken um Dokumente hochzuladen",
                                focusedBorder: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder()),
                            onTap: () {
                              _pickFile();
                            },
                          ),
                        ),
                      ],
                    ),
                  if (widget.folderType == "document")
                    SizedBox(
                      height: 20.h,
                    ),
                  if (widget.folderType == "document")
                    CustomButton(
                        color: imageFile == null
                            ? Colors.grey
                            : AppColors.primaryColor,
                        onTap: () {
                          if (imageFile != null) {
                            _folderAndDocsController.uploadDocs(
                                imageFile,
                                widget.userId,
                                "employee",
                                widget.folderType,
                                true);
                          }
                        },
                        text: "Dokument Hochladen")
                ],
              ),
            )),
    );
  }

  _textTile(String title, subTitle, [TextStyle? subTitleStyle,Function()? onTap]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.tr,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 50.w,
          ),
          Expanded(
              child: GestureDetector(
                 onTap: onTap,
                child: Text(
                            subTitle,
                            textAlign: TextAlign.right,
                            style: subTitleStyle,
                          ),
              )),
        ],
      ),
    );
  }
}
