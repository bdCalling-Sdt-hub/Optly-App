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
  static String uploadImage="/images";
  static String notesConfirm(String id) => "/notes/confirm/$id";
  static String pause(String id)=>"/booktime/pause/$id";
  static String resume(String id)=>"/booktime/resume/$id";
  static String bookTimeStop(String id)=>"/booktime/stop/$id";
  static String checkIn(String workType,String id)=>"/checkin/$id/$workType";
  static String start(String id)=>"/booktime/start/$id";







}