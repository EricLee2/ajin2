import 'package:flutter/material.dart';
import 'package:ajin2/ui/drawer.dart';
import 'package:ajin2/ui/bottonUI.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    String routeName='';
    if (index == 0){routeName ='/';}
    else if (index == 1){routeName ='/schedule';}
    else if (index == 2){routeName ='/contact';}
    else {routeName ='/component';}

    //  if (_currentIndex != _selectedIndex) {
    Navigator.pushReplacementNamed(context, '$routeName');
    //  }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: ShowDrawer(),
        body: TabBarView(
          //physics: NeverScrollableScrollPhysics(), //스와이프가 안되도록 한다.
          children: [
            Container(child: Text('홈 스크린')),
            Container(child: Text('채팅 스크린')),
            Container(child: Text('마이 스크린')),
            Container(child: BottomUI(title: "My Component"))
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.blue,
          height: 55,
          padding: EdgeInsets.only(bottom: 10, top: 5),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.yellow, //colorThemeRed(),
            indicatorWeight: 4,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black38,
            isScrollable: false, // true 시 모든 아이콘이 좌측 정렬이 됨.
            labelStyle: TextStyle(
                fontSize: 17),
            onTap: _onItemTapped,
            tabs: [
              Tab(
                icon: Icon(Icons.home, size: 20,),
                //text: 'home',
              ),
              Tab(
                icon: Icon(Icons.schedule, size: 20,),
                //text: 'xxx',
              ),
              Tab(
                icon: Icon(Icons.contact_mail, size: 20,),
                //text: 'chat',
              ),
              Tab(
                icon: Icon(Icons.settings, size: 20,),
                //text: 'my',
              ),
          ]),
        ),
      ),
    );
  }
}
