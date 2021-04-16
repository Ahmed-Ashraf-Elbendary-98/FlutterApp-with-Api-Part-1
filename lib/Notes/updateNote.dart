import 'package:flutter/material.dart';
import 'package:main_app_api/Notes/Modal/Notes.dart';

class UpdateNotes extends StatefulWidget {
  final String updateNote="/upnote";
  @override
  _UpdateNotesState createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  TextEditingController teTitle = TextEditingController();
  TextEditingController teText = TextEditingController();



  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NotesModal myData = ModalRoute.of(context).settings.arguments;
    teTitle.text=myData.noteTitle;
    teText.text=myData.noteText;


    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              MyField(controller: teTitle,), // name
              MyField(controller: teText,), // name

              ElevatedButton(onPressed: ()async{
                NotesModal note =NotesModal(id: myData.id,noteTitle: teTitle.text,noteText: teText.text);
          
                Navigator.pop(context);
              }, child: Text("Save"))
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: null,
        controller:controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))
        ),

      ),
    );
  }
}

