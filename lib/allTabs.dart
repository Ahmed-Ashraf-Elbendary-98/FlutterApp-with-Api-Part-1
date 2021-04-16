import 'package:flutter/material.dart';
import 'package:main_app_api/Appointment/appointment.dart';
import 'package:main_app_api/Contacts/AddContact.dart';
import 'package:main_app_api/Contacts/contacts.dart';
import 'package:main_app_api/Notes/AddNotes.dart';
import 'package:main_app_api/Notes/notes.dart';
import 'package:main_app_api/Tasks/AddTask.dart';
import 'package:main_app_api/Tasks/tasks.dart';

class AllTabs extends StatefulWidget {
  final String tabsHome = "/home";
  int selectedPage;
  AllTabs({this.selectedPage});

  @override
  _AllTabsState createState() => _AllTabsState();
}

class _AllTabsState extends State<AllTabs>  with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.selectedPage); //? initialIndex:0
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: widget.selectedPage,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Book"),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab( // Tab 0
                  text: "Appointment",
                  icon: Icon(Icons.date_range),
                ),
                Tab(// Tab 1
                  text: "Contacts",
                  icon: Icon(Icons.portrait),
                ),
                Tab( // Tab 2
                  text: "Notes",
                  icon: Icon(Icons.insert_drive_file),
                ),
                Tab( // Tab 3
                  text: "Tasks",
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Appointment(),
              Contacts(),
              Notes(),
              Tasks(),
            ],
          ),
          floatingActionButton: _bottomButtons(),
        )

    );
  }
  Widget _bottomButtons() {
    if(_tabController.index==1){
      return  FloatingActionButton(
          shape: StadiumBorder(),
          onPressed: (){
            Navigator.pushNamed(context, AddContact().addcontact);
          }, // add new contact
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            size: 20.0,
          ));
    }
    else if(_tabController.index==2){
      return FloatingActionButton(
        shape: StadiumBorder(),
        onPressed: (){
          Navigator.pushNamed(context, AddNote().addnote);
        }, // add new note
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 20.0,
        ),
      );
    }
    else if(_tabController.index==3){
      return FloatingActionButton(
        shape: StadiumBorder(),
        onPressed: (){
          Navigator.pushNamed(context, AddTask().addtask);
        }, // add new task
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 20.0,
        ),
      );
    }



  }


}



