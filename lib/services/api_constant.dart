class ApiConstant {

  static String baseUrl="https://api.optly.de/api/v1";
  static String signIn(String email,String pass)=>"/login?email=$email&password=$pass";
  static String getProfile(String userId)=>"/users/$userId";
  static String getDashboard="/dashboard";
  static String getBookedWorking(String id, String month, String year)=>"/booktime/$id/$month/$year";
  static String getDocs(String userId,String type)=>"/docs/$userId/employee/$type";
  static String getTimeAccount(String userId)=>"/timeaccount/$userId";
  static String logout="/logout";
  static String getMySchedule(String date)=>"/schichtplan/$date";
  static String getAvailability(String date)=>"/schichtplan/availability/$date";
  static String getAbsence(String startDate ,endDate)=>"/absence/info/$startDate/$endDate";
  static String finalize(String userId)=>"/finalize/$userId";
  static String postAbsence="/absence";
  static String deleteAbsence(String id)=>"/absence/$id";






}