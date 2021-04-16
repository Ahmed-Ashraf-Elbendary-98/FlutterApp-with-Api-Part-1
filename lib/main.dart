import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_app_api/Appointment/appointment.dart';
import 'package:main_app_api/Appointment/newEvent.dart';
import 'package:main_app_api/Appointment/updateEvent.dart';
import 'package:main_app_api/Contacts/AddContact.dart';
import 'package:main_app_api/Contacts/updateContact.dart';
import 'package:main_app_api/Notes/AddNotes.dart';
import 'package:main_app_api/Notes/updateNote.dart';
import 'package:main_app_api/Tasks/AddTask.dart';
import 'package:main_app_api/Tasks/updateTask.dart';
import 'package:main_app_api/allTabs.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AllTabs().tabsHome,

      routes: {
        AllTabs().tabsHome:(_)=>AllTabs(selectedPage: 0,),
        Appointment().appoint:(_)=> Appointment(),

        //?  Adds Section
        NewEvent().newEvent:(_)=>NewEvent(),
        AddContact().addcontact:(_)=> AddContact(),
        AddNote().addnote:(_)=>AddNote(),
        AddTask().addtask:(_)=>AddTask(),

        //?  Update Section
        UpdateEvent().updateEvent:(_)=>UpdateEvent(),
        UpdateContact().updateCont:(_)=>UpdateContact(),
        UpdateNotes().updateNote:(_)=>UpdateNotes(),
        UpdateTask().updateTask:(_)=>UpdateTask()


      },
      
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =(X509Certificate cert, String host, int port) => true;
  }
}