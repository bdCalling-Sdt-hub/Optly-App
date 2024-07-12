import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optly/models/doc_model.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FolderAndDocsController extends GetxController {
  RxList<DocsModel> docsList = <DocsModel>[].obs;
  var loading= false.obs;

  getDocs(String userId, String type,bool isLoading) async {
    
    if(isLoading) {
      loading(true);
    }
    var response = await ApiClient.getData(ApiConstant.getDocs(userId, type));
    if (response.body['success'] == true) {
      docsList.value = List<DocsModel>.from(
          response.body['data'].map((x) => DocsModel.fromJson(x)));

      loading(false);
    } else {
      ApiChecker.checkApi(response);
    }
  }



Future<void> uploadDocs(File? doc, String id, String type, String groupname, bool notify) async {
  if (doc == null) {
    // Display error snackbar
    print("Es ist keine Datei ausgewählt.");
    // Use Flutter's snackbar to show error message
    return;
  }
  var request = http.MultipartRequest('POST', Uri.parse('${ApiConstant.baseUrl}/docs'));
  request.headers['Content-Type'] = 'multipart/form-data';
  request.fields['data'] = jsonEncode({
    'refid': id,
    'type': type,
    'groupname': groupname,
    'notify': notify ? 1 : 0,
  });

  request.files.add(await http.MultipartFile.fromPath('file', doc.path));

  var response = await request.send();
  if (response.statusCode == 200) {
    getDocs(id, groupname, false);
    print('File uploaded successfully.');
   // showSnackbar(Get.context!, "", Colors.green);
  } else {
    print('Failed to upload file.');
  }
}

Future<void> getFile(String id, String filename) async {
  final url = Uri.parse('${ApiConstant.baseUrl}/files/$id');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$filename');

      await file.writeAsBytes(bytes);

      // To open the file, you might need a third-party package like open_file.
      print('File downloaded successfully.');
    } else {
      print('Failed to download file.');
      _handleError(response);
    }
  } catch (e) {
    print('Error: $e');
  }
}

void _handleError(http.Response response) async {
  try {
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    print(jsonData['message']);
    print("Es ist ein Fehler beim Laden der Datei aufgetretten. Bitte versuche es erneut.");
  } catch (e) {
    print('Fehler beim Parsen des JSON-Blobs: $e');
  }
}

void showSnackbar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

}
