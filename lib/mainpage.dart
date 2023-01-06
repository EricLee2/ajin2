import 'package:flutter/material.dart';
import 'package:ajin2/bottomnavigationbar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late String strToday;

  String getToday(){
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    strToday = formatter.format(now);
    return strToday;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              //flex: 1,
              child: Container(
                width: double.infinity,
                child: Align(
                  child: Text(getToday()+'\n Welcome to Diary of Ajin.',
                    style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),),
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
                )
              ),
            ),
            SizedBox(height: 20.0,),
            Expanded(
              flex: 4,
              child: TableCalendar(
                firstDay:DateTime.utc(2021, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),
            ),
          ],
        ), //_widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavi(),
    );
  }
}