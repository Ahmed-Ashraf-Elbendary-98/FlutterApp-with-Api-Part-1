import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:main_app_api/Contacts/Modal/Contacts.dart';
import 'package:main_app_api/Contacts/updateContact.dart';
import 'package:http/http.dart' as http;
import "package:main_app_api/app_constants.dart" as myCons;

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  //?     192.168.1.6:45456
  String endpoint =myCons.myEndpoint;
  String api = myCons.myApi;

  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<List<ContactsModal>> getData() async {
// Uri.https("10.0.2.2:45456", "api/TestApi")
    //Uri.https("reqres.in", "api/users")
    // try {
    List<ContactsModal> contactsList = [];
    await http
        .get(Uri.https(endpoint, api), headers: headers)
        .then((result) {
      if (result.statusCode == 200) {
        print("Allthings are true");
        var allData = jsonDecode(result.body);
        print(allData[0]["contactTable"]);
        var myData = allData[0]["contactTable"];
        print("my Dattaaa -->>> ${myData}");
        for (var cont in myData) {
          ContactsModal contact = ContactsModal(
              id: cont["contactId"],
              name: cont["name"],
              imgUrl: cont["imgUrl"],
              phone: cont["phone"]);
          contactsList.add(contact);
        }
        ;

        // return allData[0]["contactTable"];
      } else {
        throw Exception('Failed to load api');
      }
    });
    print(contactsList.length);
    return contactsList;
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
          return Center(child:Text("Ooops...The server is out of service  😔",style: TextStyle(fontSize: 18),));
        }
        if (!snapshot.hasData || snapshot.data.length == 0) {
          print(snapshot.hasData);
          // print(snapshot.data.length);
          return Center(
            child:
                Text("There is no contacts 👥", style: TextStyle(fontSize: 20)),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                print(snapshot.data[index]);
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data.imgUrl),
                    ),
                    title: Text(data.name),
                    subtitle: Text("${data.phone}"),
                    
                  ),
                );
              });
        }
      },
    );
  }
}
