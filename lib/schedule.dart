import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
//        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20,20,20,20),
        child: FutureBuilder<List<Schedule>>(
          future: DatabaseHelper.instance.getSchedules(),
          builder:(BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                //child: Text('Loading'),
                child: SizedBox(
                  child:
                  new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation(Colors.blue),
                      strokeWidth: 5.0
                  ),
                  height: 50.0,
                  width: 50.0,
                ),
              );
            }
            return snapshot.data!.isEmpty
                ? const Center(child: Text('No Schedule in List'))
                : GridView.builder(
                    itemCount: snapshot.data!.length, //item 개수
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                      childAspectRatio: 1 / 1.5, //item 의 가로 1, 세로 2 의 비율
                      mainAxisSpacing: 10, //수평 Padding
                      crossAxisSpacing: 10, //수직 Padding
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 5,right: 5),
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(snapshot.data![index].name),
                                    flex:5, ),
                                  Expanded(
                                      child: IconButton(
                                        icon: Icon(Icons.delete, size: 15,),
                                        color: Colors.black,
                                        onPressed: (){
                                          setState(() {
                                            int? _index = snapshot.data![index].id ;
                                            DatabaseHelper.instance.remove(_index!);
                                          });
                                        },
                                      )
                                  )
                                ],
                              )
                            ),
                            const Divider(color: Colors.black, height: 1,),
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              alignment: Alignment.topLeft,
                              child: Text('['+snapshot.data![index].date+']')),
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSchedule(title: 'Update Contact', mode: 'update', scheduleId: snapshot.data![index].id)));
                                  },
                                  child: Text(snapshot.data![index].memo),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                );
            },
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSchedule(title: 'Add schedule', mode: 'add')));
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

class Schedule {
  final int? id;
  final String name;
  final String date;
  final String memo;

  Schedule({this.id, required this.name, required this.date, required this.memo});

  factory Schedule.fromMap(Map<String, dynamic> json) => Schedule(
    id: json['id'],
    name: json['name'],
    date: json['date'],
    memo: json['memo'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'memo': memo,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'schedules.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE schedules(
      id INTEGER PRIMARY KEY,
      name TEXT,
      date TEXT,
      memo TEXT
    )
    ''');
  }

  Future<List<Schedule>> getSchedules() async {
    Database db = await instance.database;
    var schedule = await db.query('schedules', orderBy: 'date desc');
    List<Schedule> scheduleList = schedule.isNotEmpty
        ? schedule.map((c) => Schedule.fromMap(c)).toList()
        : [];
    return scheduleList;
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('schedules', where: 'id = ?', whereArgs: [id]);
  }
}
