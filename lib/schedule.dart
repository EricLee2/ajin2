import 'package:flutter/material.dart';
import 'package:ajin2/addschedule.dart';
import 'package:ajin2/bottomnavigationbar.dart';
import 'package:table_calendar/table_calendar.dart';

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
      body: TableCalendar(
        firstDay:DateTime.utc(2021, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
      ),
      /*Center(
        child: Text('Schedule list'),
      ),*/
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