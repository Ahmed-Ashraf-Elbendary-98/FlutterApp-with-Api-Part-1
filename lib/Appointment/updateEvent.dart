import 'package:flutter/material.dart';
import 'package:main_app_api/Appointment/Modal/Event.dart';

class UpdateEvent extends StatefulWidget {
  final String updateEvent ="/upevent";
  @override
  _UpdateEventState createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  TextEditingController teText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Events myData = ModalRoute.of(context).settings.arguments;
    teText.text=myData.text;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              MyField(controller: teText,), // name

              ElevatedButton(onPressed: (){}, child: Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}

class MyField extends StatelessWidget {

  TextEditingController controller ;
  MyField({this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))
      ),

    );
  }
}

