import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optly/views/screens/notes/widget/completed_notes.dart';
import 'package:optly/views/screens/notes/widget/open_notes.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('notes'.tr),
          bottom:  TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.orange,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: "open_notes".tr,
              ),  Tab(
                text: "completed_notes".tr,
              ),
            ],
          ),
        ),
        body:  const TabBarView(
          children: <Widget>[
            OpenNotes(),
            CompletedNotes()
          ],
        ),
      ),
    );
  }
}
