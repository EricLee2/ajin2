import 'package:flutter/material.dart';
import 'package:ajin2/contact.dart';
import 'package:ajin2/schedule.dart';
import 'package:ajin2/mainpage.dart';
import 'package:ajin2/arcodion.dart';
import 'package:ajin2/accordion.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';
  // static const int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/" : (context) => MyStatefulWidget(title: "Ajin's Diary"),
        "/schedule" : (context) => MySchedule(title: "My Schedule"),
        "/contact" : (context) => MyContact(title: "My Contact"),
        "/arcodion" : (context) => MyArcodion(title: "My Menu"),
        "/xxx" : (context) => MyAccordion(title: "My Accordion"),
      },
      title: _title,
    );
  }
}


