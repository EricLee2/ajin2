import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key, required this.title, this.mode, this.contactId}) : super(key: key);
  final String title ;
  final String? mode;
  final int? contactId;

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  int? _contactId;
  String? _mode;

  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController emailController;
  FocusNode? nameFocusNode;
  FocusNode? mobileFocusNode;
  FocusNode? emailFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    _mode = widget.mode;
    if (_mode == 'update') {
      _contactId = widget.contactId;
    } else {
      _contactId = 0;
    }

    nameController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    nameFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    emailFocusNode = FocusNode();

    super.initState();
  }

  void _showDialog(BuildContext context, String title, String message){
    showDialog(
        context: context,
        barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부, false : 버튼만, true : 바깥 영역도
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            ),
            title: Text(title),
            content: SizedBox(
              width: 300,
              child: SingleChildScrollView(
                child: Text(message),
              ),
            ),
            insetPadding: const  EdgeInsets.fromLTRB(0,0,0,0),
            actions: [
              Center(
                child: TextButton(
                  child: const Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: FutureBuilder<List<Contact>>(
                  future: DatabaseHelper.instance.getContact(_contactId),
                  builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
                    if (snapshot.data!.isEmpty) {
                      return Column(
                        children: [
                          nameInput(),
                          mobileInput(),
                          emailInput(),
                        ],
                      );
                    }
                    else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: snapshot.data!.map((contact) {
                          if (snapshot.hasData) {
                            nameController = TextEditingController(text:contact.name);
                            mobileController = TextEditingController(text:contact.mobile);
                            emailController = TextEditingController(text:contact.email);
                          }
                          return Center(child:
                            Column(
                              children: [
                                nameInput(),
                                mobileInput(),
                                emailInput(),
                              ],
                            )
                          );
                        }).toList(),
                    );
                  },
                ),
              ),
              Center(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              child: const Text('취소'),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                          const SizedBox(width: 10,),
                          ElevatedButton(
                            child: const Text('저장'),
                            onPressed: () {
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regExp = RegExp(pattern);
                              if(nameController.value.text.isEmpty){
                                _showDialog(context, 'Contact','Name required. \nPlease enter Name.');}
                              else if(mobileController.value.text.isEmpty){
                                _showDialog(context, 'Contact','Mobile required. \nPlease enter Mobile.');}
                              else if(!RegExp(r"^[0-9]*$").hasMatch(mobileController.value.text)){
                                _showDialog(context, 'Contact','Wrong Mobile. \nPlease check Mobile.');}
                              else if(emailController.value.text.isEmpty){
                                _showDialog(context, 'Contact','Email required. \nPlease enter Email.');}
                              else if(!regExp.hasMatch(emailController.value.text)){
                                _showDialog(context, 'Contact','Wrong Email. \nPlease check Email.');}
                              else {
                                if (_mode == 'add'){
                                  DatabaseHelper.instance.add(Contact(
                                      name: nameController.text,
                                      mobile: mobileController.text,
                                      email: emailController.text),);
                                } else {
                                  DatabaseHelper.instance.update(Contact(
                                      id: _contactId,
                                      name: nameController.text,
                                      mobile: mobileController.text,
                                      email: emailController.text),);
                                }
                                setState(() {
                                  nameController.clear();
                                  mobileController.clear();
                                  emailController.clear();
                                  _contactId = null;
                                  _returnUrl(context);});
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameInput() {
    return TextField(
      controller: nameController,
      focusNode: nameFocusNode,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: '이름입력',
        labelText: 'Name',
      ),
    );
  }

  Widget mobileInput() {
    return TextField(
      controller: mobileController,
      focusNode: mobileFocusNode,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        icon: Icon(Icons.phone),
        hintText: "'-'없이 숫자만 입력",
        labelText: 'Mobile',
      ),
    );
  }

  Widget emailInput() {
    return TextField(
      controller: emailController,
      focusNode: emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      //obscureText: true,
      decoration: const InputDecoration(
        icon: Icon(Icons.local_post_office),
        hintText: '이메일 입력',
        labelText: 'Email',
      ),
    );
  }
}

_returnUrl(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(context, '/contact', (route) => false);
}

class Contact {
  final int? id;
  final String name;
  final String mobile;
  final String email;

  Contact({this.id, required this.name, required this.mobile, required this.email});

  factory Contact.fromMap(Map<String, dynamic> json) => Contact(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
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

  Future<int> add(Contact contact) async {
    Database db = await instance.database;
    return await db.insert('contacts', contact.toMap());
  }

  Future<List<Contact>> getContacts() async {
    Database db = await instance.database;
    var contact = await db.query('contacts', orderBy: 'id');
    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((c) => Contact.fromMap(c)).toList()
        : [];
    return contactList;
  }

  Future<List<Contact>> getContact(contactId) async {
    Database db = await instance.database;
    var contact = await db.query('contacts', where: 'id = ?', whereArgs: [contactId]);
    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((c) => Contact.fromMap(c)).toList()
        : [];
    return contactList;
  }

  Future<int> update(Contact contact) async {
    Database db = await instance.database;
    return await db.update('contacts', contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }
}