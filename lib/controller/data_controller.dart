import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:optly/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DataController extends GetxController implements GetxService {
  var email = "".obs;
  var image = "".obs;
  var name = "".obs;
  var userId = (-1).obs;
  late SharedPreferences preferences;
  var  firstname="".obs;
  var lastname="".obs;
  var phone="".obs;
  var role="".obs;
  var gender="".obs;

  getData() async {
    preferences = await SharedPreferences.getInstance();

    email.value = preferences.getString(AppConstants.email) ?? "";
    firstname.value = preferences.getString(AppConstants.firstname) ?? "";
    lastname.value = preferences.getString(AppConstants.lastname) ?? "";
    phone.value = preferences.getString(AppConstants.phone) ?? "";
    image.value = preferences.getString(AppConstants.imageurl) ?? "";
    name.value = preferences.getString(AppConstants.name) ?? "";
    role.value = preferences.getString(AppConstants.role) ?? "";
    userId.value = preferences.getInt(AppConstants.userId) ?? 0;
    gender.value = preferences.getString(AppConstants.gender) ?? "";
  }

  setData(
      {required String nameD,
        required String roleD,
        required String emailD,
        required String firstnameD,
        required String lastnameD,
        required String imageD,
        required int userid,
        }) async {
    name.value = nameD;
    role.value =roleD ;
    email.value = emailD;
    firstname.value = firstnameD;
    lastname.value = lastnameD;
    image.value = imageD;
    userId.value = userid;

    preferences = await SharedPreferences.getInstance();
    preferences.setString(AppConstants.username, nameD);
    preferences.setString(AppConstants.role, roleD);
    preferences.setString(AppConstants.email, emailD);
    preferences.setString(AppConstants.firstname, firstnameD);
    preferences.setString(AppConstants.imageurl, imageD);
    preferences.setString(AppConstants.lastname, lastnameD);
    preferences.setInt(AppConstants.userId, userid);
  }

  updateData(
      {required String imageD,
        required String nameD,
        required String bioD,
        required String titleD}) async {
    name.value = nameD;
    image.value = imageD;
    preferences = await SharedPreferences.getInstance();
    preferences.setString(AppConstants.username, nameD);
    preferences.setString(AppConstants.imageurl, imageD);
  }
}