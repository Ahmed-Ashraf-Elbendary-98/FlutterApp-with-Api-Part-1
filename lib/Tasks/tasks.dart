import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:main_app_api/Tasks/Modal/Tasks.dart';
import 'package:main_app_api/Tasks/updateTask.dart';
import 'package:http/http.dart' as http;
import "package:main_app_api/app_constants.dart" as myCons;

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool checkedValue = false;

  Map<String, String> headers = {'Content-Type': 'application/json'};
  String endpoint =myCons.myEndpoint;
  String api = myCons.myApi;

  Future<List<TasksModal>> getData() async {
    List<TasksModal> tasksList = [];
    await http
        .get(Uri.https(endpoint, api), headers: headers)
        .then((result) {
      if (result.statusCode == 200) {
        print("Allthings are true");
        var allData = jsonDecode(result.body);
        var myData = allData[0]["taskTable"];
        print("my Dattaaa -->>> ${myData}");
        for (var cont in myData) {
          TasksModal task = TasksModal(
            id: cont["taskId"],
            textTask: cont["textTask"],
            dateTask: cont["dateTask"],
            compeleteTask: cont["completeTask"],
          );

          tasksList.add(task);
        }
        ;
      } else {
        throw Exception('Failed to load api');
      }
    });

    print(tasksList.length);

    return tasksList;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  bool processDone = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done &&
            processDone == false) {
          return Center(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please Wait ...... 🙇‍♂️ ",style: TextStyle(fontSize: 18),),
              SizedBox(height: 20,),
              CircularProgressIndicator(),
            ],
          ));
        }
        if (snapshot.hasError) {
          return Center(child: Text("Ooops...The server is out of service  😔",style: TextStyle(fontSize: 18),));
        }
        if (!snapshot.hasData || snapshot.data.length == 0) {
          return Center(
            child: Text("There is no Tasks 📌", style: TextStyle(fontSize: 20)),
          );
        } else {
          processDone = true;
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                var data = snapshot.data[index];
                String str = data.dateTask;
                var myDate = str.split('T');
                print(myDate[0]);
                return ListTile(
                  title: Text(data.textTask,
                      style: TextStyle(
                          decoration: checkedValue == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                  subtitle: Text(myDate[0],
                      style: TextStyle(
                          decoration: checkedValue == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                  leading: Checkbox(
                    value: checkedValue,
                    onChanged: (newVal) async {
                      setState(() {
                        checkedValue = newVal;
                      });
                    },
                  ),
                );
              });
        }
      },
    );
  }

  void _showMessage() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("How? and Why? 🤯"),
            content: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("How can you Edit things that are already done?"),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text("Back"))
                ],
              ),
            ),
          );
        });
  }
}
