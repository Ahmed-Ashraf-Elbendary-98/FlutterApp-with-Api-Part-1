import 'package:flutter/material.dart';
import 'package:main_app_api/Tasks/Modal/Tasks.dart';
import 'package:main_app_api/allTabs.dart';

class AddTask extends StatefulWidget {
  final String addtask = "/task";
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _textTask;
  String _dateTask="3/31/2021";
  int _compeleteTask;

  DateTime date;



  @override
  void initState() {

    date=DateTime.now();
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
                MyField(hint: "Enter The Task",lable: "Task to do",type: TextInputType.text,
                  onChangedFunc:(newVal){setState(() {
                    setState(() {
                      _textTask=newVal;
                    });
                  });},),

                ListTile(
                  leading: Text ("Date : ${date.month}/${date.day}/${date.year}",style: TextStyle(fontSize: 15),), trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: (){
                    _DatePick();
                    setState(() {
                      _dateTask="${date.month}/${date.day}/${date.year}";
                    });
                  },
                ),

                RaisedButton.icon(onPressed: ()async{
                 TasksModal task = TasksModal(textTask: _textTask ,dateTask: _dateTask ,compeleteTask:0);
      
                  // print("my $_name , phone:$_phone  img:$_imgUrl ");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AllTabs(
                            selectedPage: 3,
                          )));

                }, icon: Icon(Icons.add), label: Text("Save"))
              ],
            ),
          )) ,
    );
  }

  _DatePick()async{
    var newDate =await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(DateTime.now().year-5),
        lastDate: DateTime(DateTime.now().year+5)
    );
    if(newDate != null){
      setState(() {
        date = newDate;
      });
    }
  }
}


class MyField extends StatefulWidget {

  String hint;
  String lable;
  bool enabled;
  String initVal;
  TextInputType type;
  Function onChangedFunc;

  MyField({this.hint,this.lable,this.type,this.onChangedFunc,this.enabled,this.initVal});

  @override
  _MyFieldState createState() => _MyFieldState();
}

class _MyFieldState extends State<MyField> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
          initialValue: widget.initVal,
          enabled: widget.enabled,
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
