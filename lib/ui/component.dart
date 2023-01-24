import 'package:flutter/material.dart';
import 'package:ajin2/ui/drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter/widgets.dart';

class MyComponent extends StatefulWidget {
  const MyComponent({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyComponent> createState() => _MyComponentState();
}

enum Gender {MAN, WOMEN}
enum Nationality {DOMESTIC, FOREIGN}

class _MyComponentState extends State<MyComponent> {
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: ShowDrawer(),
/*      body: Row(
        children: [
          Column(
            children: [
              Row( // 가로로 진행 (버튼 + 이름)
                children: <Widget>[
                  const Text('Gender',
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 40, width: 70,
                    child: Radio<Gender>(
                      value: Gender.MAN,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                          print('라디오 테스트 : $value');
                        });
                      },
                    ),
                  ),
                  Text('남자'),
                  SizedBox(height: 40, width: 70,
                    child: Radio<Gender>(
                      value: Gender.WOMEN,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                          print('라디오 테스트 : $value');
                        });
                      },
                    ),
                  ),
                  Text('여자')
                ],
              ),
              Row( // 가로로 진행 (버튼 + 이름)
                children: <Widget>[
                  const Text('Nationality',
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 40, width: 70,
                    child: Radio<Nationality>(
                      value: Nationality.DOMESTIC,
                      groupValue: _nationality,
                      onChanged: (Nationality? value) {
                        setState(() {
                          _nationality = value;
                          print('라디오 테스트 : $value');
                        });
                      },
                    ),
                  ),
                  Text('내국인'),
                  SizedBox(height: 40, width: 70,
                    child: Radio<Nationality>(
                      value: Nationality.FOREIGN,
                      groupValue: _nationality,
                      onChanged: (Nationality? value) {
                        setState(() {
                          _nationality = value;
                          print('라디오 테스트 : $value');
                        });
                      },
                    ),
                  ),
                  Text('외국인')
                ],
              ),
            ],
          ),
        ],
      ),*/
/*      body: Padding(
        padding: const EdgeInsets.all(18.0),
          child: Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex:1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Gender1')
                        ),
                      ),
                      Divider(thickness: 1, height: 1, color: Colors.black45,),
                      ListTile(
                        title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Gender2')
                        ),
                      )
                    ],
                  )),
                Expanded(
                  flex: 2,
                  child: Column(
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
                      Divider(thickness: 1, height: 1, color: Colors.black45,),
                      ListTile(
                        title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('남자1')
                        ),
                        leading: Radio( // title 앞에 radio button을 넣고 싶으면 leading으로
                            value: Gender.WOMEN,
                            groupValue: _gender,
                            onChanged: (Gender? value){
                              setState(() {
                                _gender = value;
                              });
                            }
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ListTile(
                        title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('여자')
                        ),
                        leading: Radio( // title 앞에 radio button을 넣고 싶으면 leading으로
                            value: Gender.WOMEN,
                            groupValue: _gender,
                            onChanged: (Gender? value){
                              setState(() {
                                _gender = value;
                              });
                            }
                        ),
                      ),
                      Divider(thickness: 1, height: 1, color: Colors.black45,),
                      ListTile(
                        title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('여자1')
                        ),
                        leading: Radio( // title 앞에 radio button을 넣고 싶으면 leading으로
                            value: Gender.WOMEN,
                            groupValue: _gender,
                            onChanged: (Gender? value){
                              setState(() {
                                _gender = value;
                              });
                            }
                        ),
                      ),
                     ],
                  ),
                ),
              ],
            ),
          )
      ),*/
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
