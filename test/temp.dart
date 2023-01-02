import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dog Database'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Dog> dogs = [
    Dog(name: '푸들이'),
    Dog(name: '삽살이'),
    Dog(name: '말티말티'),
    Dog(name: '강돌이'),
    Dog(name: '진져'),
    Dog(name: '백구'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<Dog>>(
          future: DBHelper.instance.getAllDogs(),
          builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index){
                  return Text('content number ${index}')
                },
                /*             itemBuilder: (BuildContext context, int index) {
                  Dog item = snapshot.data[index];
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      //DBHelper().deleteDog(item.id);
                      setState(() {});
                    },
                    child: Center(child: Text(item.name)),
                  );
                },*/
              );
            }
            else
            {
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.refresh),
              onPressed: () {
                //모두 삭제 버튼
                DBHelper().deleteAllDogs();
                setState(() {});
              },
            ),
            SizedBox(height: 8.0),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                //추가 버튼
                Dog dog = dogs[Random().nextInt(dogs.length)];
                DBHelper().addDog(dog);
                setState(() {});
              },
            ),
          ],
        )

    );
  }
}

class Dog{
  final int? id;
  final String name;

  Dog({this.id, required this.name});
}

class DBHelper{

  //final String TableName = 'Dog';

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  factory DBHelper() => instance;

  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'MyDogsDB.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE Dog(
            id INTEGER PRIMARY KEY,
            name TEXT,
          )
        ''');
        },
        onUpgrade: (db, oldVersion, newVersion){}
    );
  }

  //Create
  addDog(Dog dog) async {
    final db = await instance.database;
    var res = await db.rawInsert('INSERT INTO Dog VALUES(?)', [dog.name]);
    return res;
  }

  //Read
  getDog(int id) async {
    final db = await instance.database;
    var res = await db.rawQuery('SELECT * FROM Dog WHERE id = ?', [id]);
    return res.isNotEmpty ? Dog(id: res.first['id'], name: res.first['name']) : Null;
  }

  //Read All
  Future<List<Dog>> getAllDogs() async {
    Database db = await instance.database;
    var res = await db.rawQuery('SELECT * FROM Dog');
    List<Dog> list = res.isNotEmpty
        ? res.map((c) => Dog(id:c['id'], name:c['name'])).toList()
        : [];
    return list;
  }

  //Delete
  deleteDog(int id) async {
    final db = await instance.database;
    return await db.rawDelete('DELETE FROM Dog WHERE id = ?', [id]);
  }

  //Delete All
  deleteAllDogs() async {
    final db = await instance.database;
    return await db.rawDelete('DELETE FROM Dog');
  }
}




//https://www.youtube.com/watch?v=noi6aYsP7Go
//https://pythonkim.tistory.com/128
//https://dev-nam.tistory.com/40 : 간단한 기능별 flutter  사용 방법