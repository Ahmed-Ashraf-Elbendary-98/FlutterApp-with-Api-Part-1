import 'package:flutter/material.dart';
import 'package:main_app_api/Notes/Modal/Notes.dart';
import 'package:main_app_api/Notes/notes.dart';
import 'package:main_app_api/allTabs.dart';

class AddNote extends StatefulWidget {
  final String addnote = "/note";
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String _noteTitle;
  String _textNote;



  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Contact"),),
      body:SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                MyField(hint: "Enter The Person Name",lable: "Name",type: TextInputType.text,
                  onChangedFunc:(newVal){setState(() {
                    setState(() {
                      _noteTitle=newVal;
                    });
                  });},),
                MyField(hint: "Write ....",lable: "body of note",type: TextInputType.text,
                  onChangedFunc:(newVal){setState(() {
                    setState(() {
                      _textNote=newVal;
                    });
                  });},
                ),



                RaisedButton.icon(onPressed: ()async{
                  NotesModal note = NotesModal(noteTitle: _noteTitle ,noteText: _textNote);
    

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AllTabs(
                            selectedPage: 2,
                          )));

                }, icon: Icon(Icons.add), label: Text("Save"))
              ],
            ),
          )) ,
    );
  }
}

class MyField extends StatefulWidget {

  String hint;
  String lable;

  TextInputType type;
  Function onChangedFunc;

  MyField({this.hint,this.lable,this.type,this.onChangedFunc});

  @override
  _MyFieldState createState() => _MyFieldState();
}

class _MyFieldState extends State<MyField> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(

          // enableInteractiveSelection: false,
          focusNode: FocusNode(),
          keyboardType:widget.type,
          decoration: InputDecoration(
              hintText: widget.hint,
              labelText: widget.lable,
              border:OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
              )
          ),
          onChanged:widget.onChangedFunc

      ),
    );
  }
}

