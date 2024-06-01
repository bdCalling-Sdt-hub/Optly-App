class AppConstants{

  static String bearerToken="BearerToken";
  static String userId="UserId";
  static String isLogged="IsLogged";
  static String isOnboard="IsOnboard";
  static String subscription="Subscription";
  static String signInType ="SignInType";
  static String isFutureDate ="isFutureDate";


  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator = RegExp(
    // r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
      r'^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$'
  );




  ///===================payment=======================>
  String _merchant_key="sshi091ovn1fa";
  // String _merchant_key="q1cd2rdny4a53";
  String _merchant_id="24319614";
  // String _merchant_id="10004002";
  static String return_url="https://www.example.com/success";
  static String cancel_url="https://www.example.com/cancel";
  static String notify_url="https://www.example.com/notify";


  get getMerchantKey{
    return _merchant_key;
  }

  get getMerchantId{
    return _merchant_id;
  }

}

enum Status { loading, completed, error, internetError }
enum SubscriptionStatus { free, standard, premium, expire }