import 'package:get/get.dart';
import 'package:optly/views/screens/dashboard/dashboard_screen.dart';
import 'package:optly/views/screens/logInScreen/log_in_screen.dart';
import 'package:optly/views/screens/notes/notes_screen.dart';
import 'package:optly/views/screens/splash/splash_screen.dart';
import 'package:optly/views/screens/tasks/tasks_screen.dart';
import 'package:optly/views/screens/tasks/widget/completed_tasks.dart';
import 'package:optly/views/screens/tasks/widget/my_tasks.dart';
import 'package:optly/views/screens/tasks/widget/open_taskes.dart';

import '../views/screens/profile/profile_screen.dart';



class AppRoutes {
  static const String logInScreen = "/log_in_screen.dart";
  static const String dashboardScreen = "/dashboard_screen.dart";
  static const String splashScreen = "/splash_screen.dart";
  static const String profileScreen = "/profile_screen.dart";
  static const String tasksScreen="/tasks_screen";
  static const String notesScreen="/notes_screen";
  static const String openTasks = "/open_tasks.dart";
  static const String myTasks = "/my_tasks.dart";
  static const String completedTasks = "/completed_tasks_screen";

  static List<GetPage> get routes => [
        GetPage(name: splashScreen, page: () => SplashScreen()),
        GetPage(name: logInScreen, page: () => LogInScreen(),transition:Transition.cupertino,transitionDuration:const Duration(seconds: 1)),
        GetPage(name: dashboardScreen, page: () => DashboardScreen(),transition: Transition.fadeIn),
        GetPage(name: profileScreen, page: () => const ProfileScreen(),transition: Transition.fadeIn),
        GetPage(name: tasksScreen, page: () => const TasksScreen(),transition: Transition.fadeIn),
        GetPage(name: myTasks, page: () => const MyTasks(),transition: Transition.fadeIn),
        GetPage(name: completedTasks, page: () => const CompletedTasks(),transition: Transition.fadeIn),
        GetPage(name: openTasks, page: () =>  OpenTasks(),transition: Transition.fadeIn),
        GetPage(name: notesScreen, page: () =>  NotesScreen(),transition: Transition.fadeIn),
      ];
}
