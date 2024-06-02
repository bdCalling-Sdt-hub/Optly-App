import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/utils/app_constants.dart';
import 'package:optly/views/screens/logInScreen/log_in_screen.dart';
import 'routes/app_routes.dart';
import 'themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return GetMaterialApp(
              title: AppConstants.APP_NAME,
              debugShowCheckedModeBanner: false,
              navigatorKey: Get.key,
              theme: light(),
              transitionDuration: const Duration(milliseconds: 500),
              getPages: AppRoutes.routes,
              initialRoute: AppRoutes.logInScreen,
              home: LogInScreen(),
            );
          }),
    );
  }
}
