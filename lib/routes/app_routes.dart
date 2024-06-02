import 'package:get/get.dart';
import 'package:optly/views/screens/logInScreen/log_in_screen.dart';

import '../views/screens/overviewScreen/overview_screen.dart';

class AppRoutes {
  static const String logInScreen = "/log_in_screen.dart";
  static const String overviewScreen = "/overview_screen.dart";

  static List<GetPage> get routes => [
        GetPage(name: logInScreen, page: () => LogInScreen()),
        GetPage(name: overviewScreen, page: () => OverviewScreen()),
      ];
}
