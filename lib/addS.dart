import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class AddSchedule1 extends StatefulWidget {
  const AddSchedule1({Key? key, required this.title, this.mode, this.scheduleId, this.memoD}) : super(key: key);
  final String title ;
  final String? mode;
  final int? scheduleId;
  final String? memoD;

  @override
  State<AddSchedule1> createState() => _AddSchedule1State();
}

class _AddSchedule1State extends State<AddSchedule1> {
  String name = "";
  String date = "";
  String memo = "";
  DateTime? _selectedDate;
  String temp = "";

  final _formKey = GlobalKey<FormState>();

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
    temp = widget.memoD!;
    if(widget.mode == 'add' && temp.isNotEmpty){
      //temp = DateFormat('yyyy-MM-dd').format(widget.memoD!);
      dateController = TextEditingController(text: temp.substring(0, 10));
    }

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.bottom, //하단바만 보이기
        //SystemUiOverlay.top, //상단바만 보이기
      ],
    );
  }
  void _showDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 10, 10),
                child: Align(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Image(
                      image: AssetImage('assets/close_bt.png'),
                      width: 20,
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                ),
              ),
              Expanded(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                  content:Container(
                    padding: const EdgeInsets.all(0),
                    width:  MediaQuery.of(context).size.height * 0.9,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Align(
                      child: Text('Welcome to Diary of Ajin.', style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),),
                      alignment: Alignment.center,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.yellow.withOpacity(0.9), BlendMode.dstATop),
                        image: NetworkImage("https://mblogthumb-phinf.pstatic.net/20160411_195/fotolia_korea_1460366094204KtUfl_JPEG/%BA%BD%B2%C9%C0%CC%B9%CC%C1%F6_1.jpg?type=w800"),//Image.asset('/assets/image_animal.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        //appBar: AppBar(title: Text("로그인"),),
        body: HomePageBody(context),
      ),
    );
  }
  Widget HomePageBody(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 100,
              child: Align(
                child: Text(widget.title,
                  style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),),
                alignment: Alignment.center,
              ),
              decoration : BoxDecoration(
                shape: BoxShape.rectangle,
                //border : Border.all(color : Colors.grey),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.yellow.withOpacity(0.9), BlendMode.dstATop),
                  image: NetworkImage("https://mblogthumb-phinf.pstatic.net/20160411_195/fotolia_korea_1460366094204KtUfl_JPEG/%BA%BD%B2%C9%C0%CC%B9%CC%C1%F6_1.jpg?type=w800"),//Image.asset('/assets/image_animal.jpg'),
                  fit: BoxFit.cover,
                ),
              )//
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white70,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    NameInput(),
                    SizedBox(height: 16,),
                    DateInput(context),
                    SizedBox(height: 16,),
                    MemoInput(),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShowButton(context),
                        SizedBox(width: 10,),
                        CancelButton(context),
                        SizedBox(width: 10,),
                        ResetButton(context),
                        SizedBox(width: 10,),
                        SubmitButton(context),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget NameInput() {
    return TextFormField(
      controller: nameController,
      focusNode: nameFocusNode,
//      autofocus: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "일정명",
      ),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return '일정명을 입력하세요.';
        }
        return null;
      },
      onSaved: (value) => name = value as String,
    );
  }
  Widget DateInput(BuildContext context) {
    return TextFormField(
      controller: dateController,
      focusNode: dateFocusNode,
      keyboardType: TextInputType.text,
      readOnly: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "날짜",
        suffixIcon: Icon(Icons.calendar_today),
      ),
      textInputAction: TextInputAction.done,
      onTap: () {
        _pickDateDialog(context, dateController);
      },

      validator: (value) {
        if (value!.isEmpty) {
          return '날짜를 입력하세요.';
        }
        return null;
      },
      onSaved: (value) => date = value as String,
    );
  }
  Widget MemoInput() {
    return TextFormField(
      controller: memoController,
      focusNode: memoFocusNode,
      keyboardType: TextInputType.multiline,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      minLines: 1,
      maxLines: 5,
      //     initialValue : _initialDate,
      //     obscureText: true,
      decoration: InputDecoration(
        labelText: "일정",
      ),
      textInputAction: TextInputAction.done,

      validator: (value) {
        if (value!.isEmpty) {
          return '일정을 입력하세요.';
        }
        return null;
      },
      onSaved: (value) => memo = value as String,
    );
  }
  ElevatedButton SubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        if(_formKey.currentState!.validate()){
          _formKey.currentState!.save();
          DatabaseHelper.instance.add(Schedule(
              name: name,
              date: date,
              memo: memo),);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(name + '/' + date + '/' + memo)),
          );
        }else{
          return null;
        }
        setState(() {
          _returnUrl(context);
        });
      },
      child: Text("Submit", style: TextStyle(color: Colors.white),),
    );
  }
  ElevatedButton CancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        Navigator.of(context).pop();
      },
      child: Text("Cancel", style: TextStyle(color: Colors.white),),
    );
  }
  ElevatedButton ResetButton(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        nameController.clear();
        dateController.clear();
        memoController.clear();
      },
      child: Text("Reset", style: TextStyle(color: Colors.white),),
    );
  }
  ElevatedButton ShowButton(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        _showDialog(context);
      },
      child: Text("Dialog", style: TextStyle(color: Colors.white),),
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

  Future<List<Schedule>> getSchedules() async {
    Database db = await instance.database;
    var schedule = await db.query('schedules', orderBy: 'id desc');
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

  Future<int> add(Schedule schedule) async {
    Database db = await instance.database;
    return await db.insert('schedules', schedule.toMap());
  }

  Future<int> update(Schedule schedule) async {
    Database db = await instance.database;
    return await db.update('schedules', schedule.toMap(),
        where: 'id = ?', whereArgs: [schedule.id]);
  }
}