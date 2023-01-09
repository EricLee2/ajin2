import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key, required this.title, this.mode, this.scheduleId}) : super(key: key);
  final String title ;
  final String? mode;
  final int? scheduleId;

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  int? _scheduleId;
  String? _mode;
  String? _selectedDate;

  FocusNode nameFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode memoFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mode = widget.mode!;

    if (_mode == 'update') {
      _scheduleId = widget.scheduleId;
    } else {
      _scheduleId = 0;
    }

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _showDialog(BuildContext context, String title, String message){
    showDialog(
        context: context,
        barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부, false : 버튼만, true : 바깥 영역도
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            ),
            title: Text(title),
            content: SizedBox(
              width: 300,
              child: SingleChildScrollView(
                child: Text(message),
              ),
            ),
            insetPadding: const  EdgeInsets.fromLTRB(0,0,0,0),
            actions: [
              Center(
                child: TextButton(
                  child: const Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        }
    );
  }

  Future _pickDateDialog(BuildContext context, TextEditingController? dateName) async {
    final initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //캘린더 테마
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;

    setState(() {
      dateName!.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      _selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 60,
            color: Colors.lightGreen,
            child: Row(
              children: [
                const SizedBox(width: 20,),
                Expanded(
                  child: Text(widget.title,
                      style: const TextStyle(color: Colors.black, fontSize: 20,) ),),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.black,
                      onPressed: (){Navigator.of(context).pop();}
                    ),
                  )
                )
              ]
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: FutureBuilder<List<Schedule>>(
                future: DatabaseHelper.instance.getSchedule(_scheduleId),
                builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
                  if (snapshot.data!.isEmpty) {
                    return Column(
                      children: [
                        nameInput(),
                        dateInput(context),
                        memoInput(),
                      ],
                    );
                  }
                  else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: snapshot.data!.map((contact) {
                      if (snapshot.hasData) {
                        nameController = TextEditingController(text:contact.name);
                        dateController = TextEditingController(text:contact.date);
                        if (_selectedDate !=null && _selectedDate !=contact.date){
                          dateController = TextEditingController(text:_selectedDate);
                        }
                        memoController = TextEditingController(text:contact.memo);
                      }
                      return Center(
                          child: Column(
                            children: [
                              nameInput(),
                              dateInput(context),
                              memoInput(),
                            ],
                          )
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          Column(
            children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: const Text('취소'),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                  ),
                  const SizedBox(width: 10,),
                  ElevatedButton(
                    child: const Text('저장'),
                    onPressed: () {
                      if(nameController.text.isEmpty){
                        _showDialog(context, 'Schedule','Name required. \nPlease enter Name.');}
                      else if(dateController.text.isEmpty){
                        _showDialog(context, 'Schedule','Date required. \nPlease enter Date.');}
                      else if(memoController.text.isEmpty){
                        _showDialog(context, 'Schedule','Memo required. \nPlease enter memo.');}
                      else {
                        if (_mode == 'add'){
                          DatabaseHelper.instance.add(Schedule(
                              name: nameController.text,
                              date: dateController.text,
                              memo: memoController.text),);
                        } else {
                          DatabaseHelper.instance.update(Schedule(
                              id: _scheduleId,
                              name: nameController.text,
                              date: dateController.text,
                              memo: memoController.text),);
                        }
                        setState(() {
                          nameController.clear();
                          dateController.clear();
                          memoController.clear();
                          _scheduleId = null;
                          _returnUrl(context);});
                       }
                     },
                   ),
                 ],
               ),
             ],
            ),
          ],
        ),
     )
    );//_widgetOptions.elementAt(_selectedIndex);
  }

  Widget nameInput() {
    return TextField(
      controller: nameController,
      focusNode: nameFocusNode,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
//        icon: Icon(Icons.person),
        hintText: '일정명 입력',
        labelText: '일정명',
      ),
    );
  }

  Widget dateInput(BuildContext context) {
    return TextField(
      controller: dateController,
      //focusNode: dateFocusNode,
      keyboardType: TextInputType.datetime,
      readOnly: true,
      decoration: const InputDecoration(
        //hintText: "날짜 입력",
        labelText: '날짜', suffixIcon: Icon(Icons.date_range_rounded,color: Colors.blueAccent,)
      ),
      onTap: () => _pickDateDialog(context,dateController),
    );
  }

  Widget memoInput() {
    return TextField(
      controller: memoController,
      focusNode: memoFocusNode,
      keyboardType: TextInputType.multiline,
     // maxLines: null,
      //      expands: true,
      minLines: 1,
      maxLines: 5,
      //textAlign: TextAlign.center, // focus시 hint text가 중앙으로 정렬
      //obscureText: true,
      decoration: const InputDecoration(
//        icon: Icon(Icons.local_post_office),
        hintText: '일정 입력',
        labelText: '일정',
      ),
    );
  }
}

_returnUrl(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(context, '/schedule', (route) => false);
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

  Future<int> add(Schedule schedule) async {
    Database db = await instance.database;
    return await db.insert('schedules', schedule.toMap());
  }

  Future<List<Schedule>> getSchedules() async {
    Database db = await instance.database;
    var schedule = await db.query('schedules', orderBy: 'id');
    List<Schedule> scheduleList = schedule.isNotEmpty
        ? schedule.map((c) => Schedule.fromMap(c)).toList()
        : [];
    return scheduleList;
  }

  Future<List<Schedule>> getSchedule(scheduleId) async {
    Database db = await instance.database;
    var schedule = await db.query('schedules', where: 'id = ?', whereArgs: [scheduleId]);
    List<Schedule> scheduleList = schedule.isNotEmpty
        ? schedule.map((c) => Schedule.fromMap(c)).toList()
        : [];
    return scheduleList;
  }

  Future<int> update(Schedule schedule) async {
    Database db = await instance.database;
    return await db.update('schedules', schedule.toMap(),
        where: 'id = ?', whereArgs: [schedule.id]);
  }
}
