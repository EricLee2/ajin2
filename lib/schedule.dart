import 'package:flutter/material.dart';
import 'package:ajin2/addschedule.dart';
import 'package:ajin2/bottomnavigationbar.dart';

class MySchedule extends StatefulWidget {
  const MySchedule({Key? key, required this.title}) : super(key: key);
  final String title ;

  @override
  State<MySchedule> createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1,
      ),
      body: Center(
        child: Text('Schedule list'),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSchedule(title: 'Add schedule', mode: 'add mode')));
              },
              label: Text('Add'),
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavi(),
    );
  }
}