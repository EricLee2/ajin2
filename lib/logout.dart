import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogOutPage extends StatefulWidget {
  //로그인 정보를 이전 페이지에서 전달 받기 위한 변수
  final String id;
  final String pass;
  final String birth;

  LogOutPage({required this.id, required this.pass, required this.birth});
  @override
  _LogOutPage createState() => _LogOutPage();
}

class _LogOutPage extends State<LogOutPage> {
  static final storage = FlutterSecureStorage();
  //데이터를 이전 페이지에서 전달 받은 정보를 저장하기 위한 변수
  String? id;
  String? pass;
  String? birth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id; //widget.id는 LogOutPage에서 전달받은 id를 의미한다.
    pass = widget.pass; //widget.pass LogOutPage에서 전달받은 pass 의미한다.
    birth = widget.birth ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logout Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("id : " + id!),
            Text("password : " + pass!),
            Text("birth : " + birth!),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                //delete 함수를 통하여 key 이름이 login인것을 완전히 폐기 시켜 버린다.
                //이를 통하여 다음 로그인시에는 로그인 정보가 없어 정보를 불러 올 수가 없게 된다.
                storage.delete(key: "login");
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => MyLoginPage(
                        title: "Login Page",
                      )
                  ),
                );
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}