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
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Ajin's Diary"),
              accountEmail: const Text('ajin@test.com'),
              onDetailsPressed: (){},
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('/assets/image_animal.jpg'),
                //backgroundColor: Colors.transparent,
              ),
              decoration: BoxDecoration(
                color: Colors.amber[600],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                ),
              ),
              otherAccountsPictures: [
                CircleAvatar(
                  backgroundImage: AssetImage('/assets/image_animal.jpg'),
                  //backgroundColor: Colors.transparent,
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.schedule, color: Colors.grey),
              title: const Text('Schedule'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/schedule');
              },
              trailing: Icon(Icons.add),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(thickness: 1, height: 1, color: Colors.grey),
            ),
            ListTile(
              leading: const Icon(Icons.contact_phone, color: Colors.grey),
              title: const Text('Contact'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/contact');
              },
              trailing: Icon(Icons.add),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(thickness: 1, height: 1, color: Colors.grey),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book, color: Colors.grey),
              title: const Text('Arcodion Page'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/arcodion');
              },
              trailing: const Icon(Icons.add),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(thickness: 1, height: 1, color: Colors.grey),
            ),
            ListTile(
              leading: Icon(Icons.contact_phone, color: Colors.grey),
              title: Text('Accorodion 예제2'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/xxx');
              },
              trailing: Icon(Icons.add),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(thickness: 1, height: 1, color: Colors.grey),
            ),
          ],
        ),
      ),
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

