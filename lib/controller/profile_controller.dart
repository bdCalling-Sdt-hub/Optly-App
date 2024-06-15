import 'package:get/get.dart';
import 'package:optly/helpers/prefs_helpers.dart';
import 'package:optly/models/profile_model.dart';
import 'package:optly/services/api_constant.dart';
import 'package:optly/services/api_services.dart';
import 'package:optly/utils/app_constants.dart';

class ProfileController extends GetxController{

  var loading=false.obs;

  Rx<ProfileModel> profileData=ProfileModel().obs;

  getProfile()async{
    loading(true);
    var userId= await PrefsHelper.getInt(AppConstants.userId);
    var response= await ApiClient.getData(ApiConstant.getProfile(userId.toString()));

    if(response.body['success']){
      profileData.value=ProfileModel.fromJson(response.body);
      loading(false);
    }

  }




  logOut()async{

  }




}