class ApiConstant {

  static String baseUrl="https://api.optly.de/api/v1";
  static String signIn(String email,String pass)=>"/login?email=$email&password=$pass";
  static String getProfile(String userId)=>"/users/$userId";
  static String getDashboard="/dashboard";
  static String getBookedWorking(String id, String month, String year)=>"/booktime/$id/$month/$year";
  static String getDocs(String userId,String type)=>"/docs/$userId/employee/$type";
  static String getTimeAccount(String userId)=>"/timeaccount/$userId";





}