import 'package:flutter/material.dart';
import 'package:ajin2/addcontact.dart';
import 'package:ajin2/bottomnavigationbar.dart';

class MyContact extends StatefulWidget {
  const MyContact({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyContact> createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1,
      ),
      body: Center(
        child: Text('contact list'),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddContact(title: 'Add contact', mode: 'add mode')));
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