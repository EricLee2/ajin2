import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key, required this.title, this.mode}) : super(key: key);
  final String title ;
  final String? mode;

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String? _mode;

  @override
  void initState() {
    // TODO: implement initState
    _mode = widget.mode!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1,
      ),
      body: MainPage(), //_widgetOptions.elementAt(_selectedIndex),
    );
  }
}


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  String _mobile = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: '이름입력',
                labelText: 'Name',
              ),
              onSaved: (value) {
                setState(() {
                  _name = value as String;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이름을 입력해 주세요.';
                }
                if (value.toString().length < 2) {
                  return '2자 이상 입력';
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: "'-'없이 숫자만 입력",
                labelText: 'Mobile',
              ),
              onSaved: (value) {
                setState(() {
                  _mobile = value as String;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '연락처를 입력해 주세요.';
                }
                if (!RegExp('[0-9]').hasMatch(value)) {
                  return '숫자만 입력해 주세요.';
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              //obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.local_post_office),
/*                prefixIcon: Icon(Icons.phone),
                suffixIcon: Icon(Icons.star),*/
                hintText: '이메일 입력',
                labelText: 'Email',
              ),
              onSaved: (value) {
                setState(() {
                  _email = value as String;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이메일을 입력해 주세요.';
                }
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                if (!regExp.hasMatch(value)) {
                  return '이메일을 올바르게 주세요.';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('취소'),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    child: Text('저장'),
                    onPressed: () {
                      //await _historyback(context);
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('정상적으로 입력되었습니다.'),
                              duration: Duration(seconds: 10),
                              action: SnackBarAction(
                                label: '확인', //버튼이름
                                onPressed: (){
                                  _historyback(context);
                                },
                              ),
                            )
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_historyback(BuildContext context){
  Navigator.pop(context);
}

/*    ScaffoldMessenger.of(context).showSnackBar(
    //SnackBar 구현하는법 context는 위에 BuildContext에 있는 객체를 그대로 가져오면 됨.
    SnackBar(
    content: Text('Like a new Snack bar!'), //snack bar의 내용. icon, button같은것도 가능하다.
    duration: Duration(seconds: 5), //올라와있는 시간
    action: SnackBarAction( //추가로 작업을 넣기. 버튼넣기라 생각하면 편하다.
    label: 'Undo', //버튼이름
    onPressed: (){}, //버튼 눌렀을때.
    ),
    )
    );*/
