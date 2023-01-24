import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _pwFocusNode = FocusNode();

  String id = "";
  String pw = "";

  bool _isAutoSave = false;
  bool _isAutoLogin = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(child: Text(widget.title)),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _userIdWidget(),
                  SizedBox(height: 16,),
                  _passwordWidget(),
                  SizedBox(height: 16,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _isAutoSave,
                          onChanged: (value) {
                            setState(() {
                              if(value != null)
                                _isAutoSave = value;
                            });
                          },
                        ),
                        Text('아이디 저장'),
                        SizedBox(width: 20),
                        Checkbox(
                          value: _isAutoLogin,
                          onChanged: (value) {
                            setState(() {
                              if(value != null)
                                _isAutoLogin = value;
                            });
                          },
                        ),
                        Text('자동 로그인'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(	//모서리를 둥글게
                        borderRadius: BorderRadius.circular(1)),
                      minimumSize: Size(MediaQuery.of(context).size.width-16, 50),	//width, height
                      alignment: Alignment.center,
                      textStyle: const TextStyle(fontSize: 20)
                    ),
                    child: Text('로그인'),
                  ),
                  SizedBox(height: 16,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('아이디 찾기'),
                        SizedBox(width: 16,),
                        VerticalDivider(thickness:3, width:1, color: Colors.red),
                        SizedBox(width: 16,),
                        Text('비밀번호 찾기'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(	//모서리를 둥글게
                        borderRadius: BorderRadius.circular(1)),
                        primary: Colors.amber,
                      minimumSize: Size(MediaQuery.of(context).size.width-16, 50),	//width, height
                      alignment: Alignment.center,
                      textStyle: const TextStyle(fontSize: 20)
                    ),
                    child: Text('회원가입'),
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }

  Widget _userIdWidget(){
    return TextFormField(
      controller: _idController,
      focusNode: _idFocusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '이메일',
      ),
      validator: (String? value){
        if (value!.isEmpty) {// == null or isEmpty
          return '아이디(이메일)를 입력해주세요.';
        }
        return null;
      },
      onSaved: (value) => id = value as String,
    );
  }

  Widget _passwordWidget(){
    return TextFormField(
      controller: _pwController,
      focusNode: _pwFocusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '비밀번호',
      ),
      validator: (String? value){
        if (value!.isEmpty) {// == null or isEmpty
          return '비밀번호를 입력해주세요.';
        }
        return null;
      },
      onSaved: (value) => pw = value as String,
    );
  }

}
