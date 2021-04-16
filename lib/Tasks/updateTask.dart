import 'package:flutter/material.dart';
import 'package:main_app_api/Tasks/Modal/Tasks.dart';

class UpdateTask extends StatefulWidget {
  final String updateTask="/uptask";
  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController teText = TextEditingController();
  String dateOfTas;

  DateTime date;
  bool changed=false;

  @override
  void initState() {
    date=DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TasksModal myData = ModalRoute.of(context).settings.arguments;

    teText.text=myData.textTask;
    dateOfTas=myData.dateTask;


    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              MyField(controller: teText,), // name

              ListTile(
                leading: Text ("Date : ${dateOfTas}",style: TextStyle(fontSize: 15),), trailing: Icon(Icons.keyboard_arrow_down),
                onTap: (){
                  _DatePick();
                  setState(() {

                    dateOfTas= changed==true?"${date.month}/${date.day}/${date.year}":dateOfTas;
                  });
                },
              ),

              ElevatedButton(
                  onPressed: ()async{
                    TasksModal task = TasksModal(id:myData.id,textTask:teText.text,dateTask:dateOfTas,compeleteTask:myData.compeleteTask);
                    Navigator.pop(context);
              },
                  child: Text("Save"))
            ],
          ),
        ),
      ),
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
        changed=true;
      });
    }
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
        controller:controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))
        ),

      ),
    );
  }
}

