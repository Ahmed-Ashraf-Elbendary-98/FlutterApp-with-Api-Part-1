import 'package:flutter/material.dart';
import 'package:main_app_api/Contacts/Modal/Contacts.dart';



class UpdateContact extends StatefulWidget {
  final String updateCont="/upcont";
  @override
  _UpdateContactState createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {

  TextEditingController teName = TextEditingController();
  TextEditingController teImg = TextEditingController();
  TextEditingController tePhone = TextEditingController();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ContactsModal myData = ModalRoute.of(context).settings.arguments;
    teName.text=myData.name;
    teImg.text=myData.imgUrl;
    tePhone.text=myData.phone.toString();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              MyField(controller: teName,), // name
              MyField(controller: teImg,), // name
              MyField(controller: tePhone,), // name

              ElevatedButton(onPressed: ()async{
                ContactsModal contact = ContactsModal(id: myData.id,name:teName.text,imgUrl:teImg.text,phone:int.parse(tePhone.text));
      
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
