import 'package:get/get.dart';
import 'package:optly/views/screens/dashboard/dashboard_screen.dart';
import 'package:optly/views/screens/logInScreen/log_in_screen.dart';
import 'package:optly/views/screens/splash/splash_screen.dart';

import '../views/screens/profile/profile_screen.dart';



class AppRoutes {
  static const String logInScreen = "/log_in_screen.dart";
  static const String dashboardScreen = "/dashboard_screen.dart";
  static const String splashScreen = "/splash_screen.dart";
  static const String profileScreen = "/profile_screen.dart";

  static List<GetPage> get routes => [
        GetPage(name: splashScreen, page: () => SplashScreen()),
        GetPage(name: logInScreen, page: () => LogInScreen(),transition:Transition.cupertino,transitionDuration:const Duration(seconds: 1)),
        GetPage(name: dashboardScreen, page: () => DashboardScreen(),transition: Transition.fadeIn),
        GetPage(name: profileScreen, page: () => const ProfileScreen(),transition: Transition.fadeIn),
      ];
}
