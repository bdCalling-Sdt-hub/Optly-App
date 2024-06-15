import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/controller/folder_and_docs_controller.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';

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
  @override
  void initState() {
    _folderAndDocsController.getDocs(widget.userId, widget.folderType);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderName),
      ),
      body: Obx(
        () => _folderAndDocsController.loading.value
            ? const Center(child: CustomPageLoading())
            : _folderAndDocsController.docsList.isEmpty
                ? Center(
                    child: Text("no_data_available".tr),
                  )
                : ListView.separated(
            itemCount: _folderAndDocsController.docsList.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    itemBuilder: (context, index) {
              var data= _folderAndDocsController.docsList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.r)),
                            side: BorderSide(
                                color:
                                    AppColors.primaryColor.withOpacity(0.3))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          child: Column(
                            children: [
                              _textTile("name", data.filename??"",
                                  TextStyle(color: AppColors.primaryColor)),
                              _textTile("created_by", data.creator??"automatically_generated".tr,
                                  const TextStyle(fontWeight: FontWeight.w500)),
                              _textTile(
                                  "created_on",
                                  data.createdAt??"",
                                  TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
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
      ),
    );
  }

  _textTile(String title, subTitle, [TextStyle? subTitleStyle]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.tr,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 50.w,),
          Expanded(
              child: Text(
            subTitle,
            textAlign: TextAlign.right,
            style: subTitleStyle,
          )),
        ],
      ),
    );
  }
}
