import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:main_app_api/Notes/Modal/Notes.dart';
import 'package:main_app_api/Notes/updateNote.dart';
import 'package:http/http.dart' as http;
import "package:main_app_api/app_constants.dart" as myCons;

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  Map<String, String> headers = {'Content-Type': 'application/json'};



  String endpoint =myCons.myEndpoint;
  String api = myCons.myApi;
  Future<List<NotesModal>> getData() async {
// Uri.https("10.0.2.2:45456", "api/TestApi")
    //Uri.https("reqres.in", "api/users")
    // try {

    List<NotesModal> notesList = [];

    await http
        .get(Uri.https(endpoint, api), headers: headers)
        .then((result) {
      if (result.statusCode == 200) {
        print("Allthings are true");
        var allData = jsonDecode(result.body);
        var myData = allData[0]["noteTable"];
        print("my Dattaaa -->>> ${myData}");
        for (var cont in myData) {
          NotesModal note = NotesModal(
              id: cont["noteId"],
              noteTitle: cont["noteTitle"],
              noteText: cont["noteText"]);
          notesList.add(note);
        }
        ;
      } else {
        throw Exception('Failed to load api');
      }
    });

    print(notesList.length);

    return notesList;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getData(),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
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
            child: Text(
              "No notes yet 📝",
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                print(snapshot.data[index]);
                var data = snapshot.data[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(2, 4),
                          color: Colors.teal,
                          blurRadius: 6,
                          spreadRadius: 1),
                    ], color: Colors.teal),
                    child: ListTile(
                      title: Text(
                        data.noteTitle,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(data.noteText,
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              });
        }
      },
    );
  }

}
