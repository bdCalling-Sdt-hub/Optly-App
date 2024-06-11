import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optly/views/screens/tasks/widget/completed_tasks.dart';
import 'package:optly/views/screens/tasks/widget/my_tasks.dart';
import 'package:optly/views/screens/tasks/widget/open_taskes.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('tasks'.tr),
          bottom:  TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.orange,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: "open_Tasks".tr,
              ),  Tab(
                text: "my_tasks".tr,
              ),  Tab(
                text: "completed_tasks".tr,
              ),

            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            OpenTasks(),
            MyTasks(),
            CompletedTasks()
          ],
        ),
      ),
    );
  }
}
