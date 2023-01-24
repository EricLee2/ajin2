import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BottomUI extends StatefulWidget {
  const BottomUI({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<BottomUI> createState() => _BottomUIState();
}

enum Gender {MAN, WOMEN}
enum Nationality {DOMESTIC, FOREIGN}

class _BottomUIState extends State<BottomUI> {
  Gender? _gender = Gender.WOMEN;
  Nationality? _nationality= Nationality.DOMESTIC;
  bool isSwitched = false;
  bool isChecked = false;

  late FToast fToast;

  showCustomToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.pinkAccent,
      ),
      child: Text("This is a Custom Toast", style: TextStyle(color: Colors.white),),
    );

    fToast.showToast(
      child: toast,
      //gravity: ToastGravity.TOP,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          //color: Colors.green,
          width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('남자')
                ),
                leading: Radio( // title 앞에 radio button을 넣고 싶으면 leading으로
                    value: Gender.MAN,
                    groupValue: _gender,
                    onChanged: (Gender? value){
                      setState(() {
                        _gender = value;
                      });
                    }
                ),
              ),
              ListTile(
                title: Align(
                    alignment: Alignment.centerRight,
                    child: Text('여자')
                ),
                trailing: Radio(
                    value: Gender.WOMEN,
                    groupValue: _gender, // 현재 선택된 값
                    onChanged: (Gender? value){ // groupValue 값을 변경
                      setState(() {
                        _gender = value;
                      });
                    }
                ),
              ),
              SizedBox(height:30),
              RadioListTile(
                  title: Text('남자'),
                  value: Gender.MAN,
                  groupValue: _gender,
                  onChanged: (Gender? value){
                    setState(() {
                      _gender = value;
                    });
                  }
              ),
              RadioListTile(
                  title: Text('여자'),
                  value: Gender.WOMEN,
                  groupValue: _gender,
                  onChanged: (Gender? value){
                    setState(() {
                      _gender = value;
                    });
                  }
              ),
              SizedBox(height:30),
              Container(
                child: Row(
                  children: [
                    Text('Gender'),
                    SizedBox(width: 20),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    Text('Gender'),
                    SizedBox(width: 20),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height:30,),
              Container(
                child: Row(
                  children: [
                    Text('Gender'),
                    SizedBox(width: 20),
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          if(value != null)
                            isChecked = value;
                        }
                        );
                      },
                    ),
                    Text('Gender'),
                    SizedBox(width: 20),
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          if(value != null)
                            isChecked = value;
                        }
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height:30,),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: (){
                        showCustomToast(); // 토스트는 함수 호출로 구현하면 됨
                        print('Text button is clicked');
                      },
                      child: Text('TOAST',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red[400],
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: Text('Home으로',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red[400],
                      ),
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
}