import 'package:ajin2/ui/drawer.dart';
import 'package:flutter/material.dart';
import 'package:ajin2/bottomnavigationbar.dart';
import 'package:ajin2/ui/topC.dart';

class MyAccordion extends StatefulWidget {
  const MyAccordion({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyAccordion> createState() => _MyAccordionState();
}

class _MyAccordionState extends State<MyAccordion> {

  final List<Entry> data = <Entry>[
    Entry('Woman'),
    Entry('Man'),
    Entry('Kids'),
    Entry('Beauty'),
    Entry('Homeware'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [IconButton(icon: Icon(Icons.settings, color: Colors.white,), onPressed: null)],
        elevation: 1,
      ),
      drawer: ShowDrawer(),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return TopCategory(firstCtg:data[index].subject, index: index);
        },
        itemCount: data.length,
      ),
      bottomNavigationBar: const BottomNavi(),
    );
  }
}

class Entry {
  final String subject;

  Entry(this.subject);
}

// The entire multilevel list displayed by this app.

