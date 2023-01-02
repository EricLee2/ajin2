import 'package:flutter/material.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key, required this.title, this.mode}) : super(key: key);
  final String title ;
  final String? mode;

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  String? _mode;

  @override
  void initState() {
    // TODO: implement initState
    _mode = widget.mode!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1,
      ),
      body: Center(
        child: Text(_mode!), //_widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
