import 'package:flutter/material.dart';
import 'package:ajin2/bottomnavigationbar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ajin2/addS.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late String strToday;

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  Map events = Map<DateTime, List<Event>>();
  /*  Map<DateTime, List<Event>> events = {
    DateTime.utc(2023, 1, 4): [Event('title3')],
  };*/

  List<Event> _getEventsForDay(DateTime day) {
    bool? y = events[day]?.isEmpty;
    if ( y != null ) {
      int x = 1;
    }
    return events[day] ?? [];
  }

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    strToday = formatter.format(now);
    return strToday;
  }

  changeScheduleToEvents(AsyncSnapshot<List<Schedule>> snapshot) {
    List<Schedule>? messages = snapshot.data;
    messages?.forEach((el) {
      String fromDate = el.date;
      DateTime dt = DateTime.parse(fromDate).toUtc().add(const Duration(hours:9));

      if ( events[dt] != null ) { // 키값 날짜로 검색해서 값이 있는 경우, 존재하는 키값 - value값 배열의 뒤에 추가
        List<Event>? event = events[dt]; // 날짜를 사용하여 이벤트 목록(배열)을 가져옴
        event?.add(Event(el.name));
      } else {  // 이벤트 목록에 없는 날짜라면 이벤트를 생성하여 넣는다
        Map<DateTime, List<Event>> oneEvent = { dt: [Event(el.name)]};
        events.addAll(oneEvent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              child: Align(
                child: Text(
                  getToday()+'\n Welcome to Diary of Ajin.',
                  style: const TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),),
                alignment: Alignment.center,
              ),
              decoration : BoxDecoration(
                shape: BoxShape.rectangle,
                //border : Border.all(color : Colors.grey),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.yellow.withOpacity(0.9), BlendMode.dstATop),
                  image: const NetworkImage("https://mblogthumb-phinf.pstatic.net/20160411_195/fotolia_korea_1460366094204KtUfl_JPEG/%BA%BD%B2%C9%C0%CC%B9%CC%C1%F6_1.jpg?type=w800"),//Image.asset('/assets/image_animal.jpg'),
                  fit: BoxFit.cover,
                ),
              )//
            ),
            SizedBox(height: 5.0,),
            Container(
              width: double.infinity,
              child: FutureBuilder<List<Schedule>>(
              future: DatabaseHelper.instance.getSchedules(),
              builder:(BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                          strokeWidth: 5.0
                      ),
                      height: 50.0,
                      width: 50.0
                    ),
                  );
                } else {changeScheduleToEvents(snapshot);}
                return snapshot.data!.isEmpty
                    ? const Center(child: Text('No Schedule in List'))
                    : GestureDetector(
                        child: TableCalendar(
                          locale: 'ko_KR',
                          firstDay:DateTime.utc(2021, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: focusedDay,
                          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                            // 선택된 날짜의 상태를 갱신합니다.
                            setState((){
                                this.selectedDay = selectedDay;
                                this.focusedDay = focusedDay;
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSchedule1(title: 'Add schedule', mode: 'add', memoD: selectedDay.toString(),)));
                          },
                          selectedDayPredicate: (DateTime day) {
                            // selectedDay와 동일한 날짜의 모양을 바꿔줍니다.
                            return isSameDay(selectedDay, day);
                          },
                          headerStyle: HeaderStyle(
                            titleCentered: true,
                            titleTextFormatter: (date, locale) =>
                                  DateFormat.yMMMMd(locale).format(date),
                            formatButtonVisible: false,
                            titleTextStyle: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.blue,
                            ),
                            headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
                            leftChevronIcon: const Icon(
                                Icons.arrow_left,
                                size: 35.0,
                                color: Colors.black45,
                            ),
                            rightChevronIcon: const Icon(
                                Icons.arrow_right,
                                size: 35.0,
                                color: Colors.black45,
                            ),
                          ),
                          calendarStyle: const CalendarStyle(
                            isTodayHighlighted : true, // today 표시 여부
                            // today 글자 조정
                            todayTextStyle : TextStyle(
                                color: Color(0xFFFAFAFA),
                                fontSize: 16.0,
                            ),
                            // today 모양 조정
                            todayDecoration : BoxDecoration(
                                //color: const Color(0xFF9FA8DA),
                                color: Colors.grey,
                                shape: BoxShape.circle,
                            ),
                            weekendTextStyle : TextStyle(color: Colors.red),// weekend 글자 조정
                            //weekendDecoration : const BoxDecoration(shape: BoxShape.circle),// weekend 모양 조정
                            // selectedDay 글자 조정
                            selectedTextStyle : TextStyle(
                                color: Color(0xFFFAFAFA),
                                fontSize: 16.0,
                            ),
                            // selectedDay 모양 조정
                            selectedDecoration : BoxDecoration(
                                //color: const Color(0xFF5C6BC0),
                                color: Colors.pink,
                                shape: BoxShape.circle,
                            ),
                          ),
                          eventLoader: _getEventsForDay,
                        ),
                    );
              }
            ),
            )
          ],
        ), //_widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSchedule1(title: 'Add schedule', mode: 'add', memoD: '',)));
              },
              label: const Text('일정등록'),
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavi(),
    );
  }
}

class Event {
  String name;

  Event(this.name);
}

class Schedule {
  final int? id;
  final String name;
  final String date;
  final String memo;

  Schedule(
      {this.id, required this.name, required this.date, required this.memo});

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
    var schedule = await db.query('schedules', orderBy: 'date');
//    var schedule = await db.execute("select date, LISTAGG(name,',') WITHIN GROUP(ORDER BY date) AS name FORM schedules GROUB BY date");
    List<Schedule> scheduleList = schedule.isNotEmpty
        ? schedule.map((c) => Schedule.fromMap(c)).toList()
        : [];
 //   print(schedule);
    return scheduleList;
  }
}