import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optly/helpers/prefs_helpers.dart';
import 'package:optly/models/profile_model.dart';
import 'package:optly/routes/app_routes.dart';
import 'package:optly/services/api_check.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';
import 'package:optly/utils/app_constants.dart';
import 'dashboard_controller.dart';
import 'data_controller.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  final _dashboardController = Get.put(DashboardController());

  Rx<ProfileModel> profileData = ProfileModel().obs;
  final _dataController = Get.put(DataController());

  getProfile() async {
    loading(true);
    var userId = await PrefsHelper.getInt(AppConstants.userId);
    var response =
        await ApiClient.getData(ApiConstant.getProfile(userId.toString()));

    if (response.body['success']) {
      profileData.value = ProfileModel.fromJson(response.body);
      loading(false);
    }
  }

  var uploadImageLoading = false.obs;

  File? _image;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage();
    } else {
      print('No image selected.');
    }
  }

  uploadImage() async {
    uploadImageLoading(true);
    List<MultipartBody> multipartBody = [MultipartBody("file", _image!)];
    var body = {"id": "141", "type": "employee"};

    var response = await ApiClient.postMultipartData(
        ApiConstant.uploadImage, body,
        multipartBody: multipartBody);

    if (response.body['success'] == true) {
      profileData.value.data!.info!.imageurl = response.body['data'];
     await PrefsHelper.setString(AppConstants.imageurl, response.body['data']);
      _dataController.image.value= response.body['data'];
      profileData.refresh();
      uploadImageLoading(false);
      _dashboardController.getDashboard();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  logOut() async {
    var response = await ApiClient.postData(ApiConstant.logout, null);
    if (response.body['success']) {
      Fluttertoast.showToast(msg: response.body['message']);
      await PrefsHelper.remove(AppConstants.bearerToken);
      Get.offAllNamed(AppRoutes.logInScreen);
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
