import 'package:flutter/material.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({Key? key}) : super(key: key);

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  int _selectedIndex = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    if (Uri.base.toString().contains('schedule')) {
      _selectedIndex = 1;
    } else if(Uri.base.toString().contains('contact')) {
      _selectedIndex = 2;
    } else if (Uri.base.toString().contains('')){
      _selectedIndex = 0;
    }
    _currentIndex = _selectedIndex;
    super.initState();
  //  print('app');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    String routeName='';
    if (index == 0){routeName ='/';}
    else if (index == 1){routeName ='/schedule';}
    else if (index == 2){routeName ='/contact';}

    if (_currentIndex != _selectedIndex) {
      Navigator.pushReplacementNamed(context, '$routeName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: 'Contact',
          ),
        ],
        currentIndex: _selectedIndex,
        //currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped
    );
  }
}


