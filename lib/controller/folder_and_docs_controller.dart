import 'package:get/get.dart';
import 'package:optly/models/doc_model.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';

class FolderAndDocsController extends GetxController {
  RxList<DocsModel> docsList = <DocsModel>[].obs;
  var loading= false.obs;

  getDocs(String userId, String type) async {
    loading(true);
    var response = await ApiClient.getData(ApiConstant.getDocs(userId, type));
    if (response.body['success'] == true) {
      docsList.value = List<DocsModel>.from(
          response.body['data'].map((x) => DocsModel.fromJson(x)));

      loading(false);
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
