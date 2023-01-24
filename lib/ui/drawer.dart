import 'package:flutter/material.dart';

class ShowDrawer extends StatelessWidget {
  const ShowDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Ajin's Diary"),
            accountEmail: Text('ajin@test.com'),
            onDetailsPressed: (){},
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('/assets/image_animal.jpg'),
              //backgroundColor: Colors.transparent,
            ),
            decoration: BoxDecoration(
              color: Colors.amber[600],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
              ),
            ),
            otherAccountsPictures: [CircleAvatar(
              backgroundImage: AssetImage('/assets/image_animal.jpg'),
              //backgroundColor: Colors.transparent,
            ),
            ],
          ),
          /*Container(
            height: 50,
            padding: EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Login'),
                SizedBox(width:5),
                IconButton(onPressed: null, icon: Icon(Icons.login)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.schedule, color: Colors.grey),
            title: Text('Schedule'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/schedule');
            },
            trailing: Icon(Icons.add),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Divider(thickness: 1, height: 1, color: Colors.grey),
          ),
          ListTile(
            leading: Icon(Icons.contact_phone, color: Colors.grey),
            title: Text('Contact'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/contact');
            },
            trailing: Icon(Icons.add),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Divider(thickness: 1, height: 1, color: Colors.grey),
          ),*/
          ListTile(
            leading: Icon(Icons.contact_phone, color: Colors.grey),
            title: Text('Arcodion Page'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/arcodion');
            },
            trailing: Icon(Icons.add),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
          ListTile(
            leading: Icon(Icons.contact_phone, color: Colors.grey),
            title: Text('Bottom Sheet'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/bottomsheet');
            },
            trailing: Icon(Icons.add),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Divider(thickness: 1, height: 1, color: Colors.grey),
          ),
          ListTile(
            leading: Icon(Icons.contact_phone, color: Colors.grey),
            title: Text('Camera'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/camera');
            },
            trailing: Icon(Icons.add),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Divider(thickness: 1, height: 1, color: Colors.grey),
          ),
          ListTile(
            leading: Icon(Icons.contact_phone, color: Colors.grey),
            title: Text('Dropdown'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/dropdown');
            },
            trailing: Icon(Icons.add),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Divider(thickness: 1, height: 1, color: Colors.grey),
          ),
          ListTile(
            leading: Icon(Icons.contact_phone, color: Colors.grey),
            title: Text('Input Component'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/component');
            },
            trailing: Icon(Icons.add),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Divider(thickness: 1, height: 1, color: Colors.grey),
          ),
          ListTile(
            leading: Icon(Icons.contact_phone, color: Colors.grey),
            title: Text('BottomAppBar'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/bottombar');
            },
            trailing: Icon(Icons.add),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Divider(thickness: 1, height: 1, color: Colors.grey),
          ),
          ListTile(
            leading: Icon(Icons.contact_phone, color: Colors.grey),
            title: Text('Tooltip'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/tooltip');
            },
            trailing: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}


