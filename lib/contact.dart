import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ajin2/addcontact.dart';
import 'package:ajin2/bottomnavigationbar.dart';

class MyContact extends StatefulWidget {
  const MyContact({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyContact> createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1,
      ),
      body: Center(
        child: FutureBuilder<List<Contact>>(
          future: DatabaseHelper.instance.getContacts(),
          builder:(BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                //child: Text('Loading'),
                child: SizedBox(
                  child:
                    new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation(Colors.blue),
                      strokeWidth: 5.0
                    ),
                    height: 50.0,
                    width: 50.0,
                ),
              );
            }
            return snapshot.data!.isEmpty
                ? Center(child: Text('No Contacts in List'))
                : ListView(
              children: snapshot.data!.map((contact) {
                return Center(
                  child: Dismissible(
                    onDismissed: (direction) {
                      setState(() {
                        if(direction== DismissDirection.endToStart){
                          DatabaseHelper.instance.remove(contact.id!);
                        }
                      });
                    },
                    direction: DismissDirection.endToStart,
                    //key: ValueKey(contact.id),
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.grey[100],
                      alignment: Alignment.center,
                      child: Text('삭제중입니다.'),
                    ),
                    child: Card(
                      elevation: 1,
/*                    color: selectedId == contact.id
                          ? Colors.white70
                          : Colors.white,*/
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddContact(title: 'Update Contact', mode: 'update', contactId: contact.id)));
                        },
                        title: Container(
                          padding: const EdgeInsets.fromLTRB(0,10,0,10),
                          height: 100,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 12,
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(width: 10,),
                                      Text(contact.name),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.phone),
                                      SizedBox(width: 10,),
                                      Text(contact.mobile),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.local_post_office),
                                      SizedBox(width: 10,),
                                      Text(contact.email),
                                    ],
                                  ),
                                ],
                              ),),
                              Expanded(child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    DatabaseHelper.instance.remove(contact.id!);
                                  });
                                },
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddContact(title: 'Add Contact', mode: 'add')));
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

class Contact {
  final int? id;
  final String name;
  final String mobile;
  final String email;

  Contact({this.id, required this.name, required this.mobile, required this.email});

  factory Contact.fromMap(Map<String, dynamic> json) => new Contact(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
      email: json['email']
  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
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
    String path = join(documentsDirectory.path, 'contacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE contacts(
      id INTEGER PRIMARY KEY,
      name TEXT,
      mobile TEXT,
      email TEXT
    )
    ''');
  }
  Future<List<Contact>> getContacts() async {
    Database db = await instance.database;
    var contact = await db.query('contacts', orderBy: 'name asc');
    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((c) => Contact.fromMap(c)).toList()
        : [];
    return contactList;
  }
  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}