import 'package:flutter/material.dart';
import 'package:ajin2/bottomnavigationbar.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1,
      ),
      body: Center(
        child: Text('Main Pageaaaa'), //_widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavi(),
    );
  }
}