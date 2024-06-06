import '../models/language_models.dart';

class AppConstants {

  static String bearerToken="bearerToken";

  static String APP_NAME = "Optly";
  static String THEME = "theme";

  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';

  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
  static List<LanguageModel> languages = [
    LanguageModel(
        languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(
        languageName: 'German', countryCode: 'GR', languageCode: 'gr'),
  ];

  static String userId="UserId";
  static String firstname="firstname";
  static String lastname="lastname";
  static String name="name";
  static String email="email";
  static String username="username";
  static String phone="phone";
  static String role="role";
  static String imageurl="imageurl";
  static String gender="gender";


}
