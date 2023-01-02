import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

// 비동기 처리를 할 때 화면을 동적으로 변화시키기 위해 StatefulWidget를 사용
class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Study"),
        centerTitle: true,
        elevation: 0.0,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
/*            Text(
              '데이터를 불러오는 중입니다.',
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(
              height: 20.0,
            ),*/

            // FutureBuilder 예시 코드
            FutureBuilder(
                future: _future(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                  //해당 부분은 data를 아직 받아 오지 못했을 때 실행되는 부분
                  if (snapshot.hasData == false) {
                    return CircularProgressIndicator(); // CircularProgressIndicator : 로딩 에니메이션
                  }

                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }

                  // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 부분
                  else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data.toString(), // 비동기 처리를 통해 받은 데이터를 텍스트에 뿌려줌
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  // 비동기 처리
  Future _future() async {
    await Future.delayed(Duration(seconds: 10)); // 5초를 강제적으로 딜레이 시킨다.
    return '데이터 가져옴~'; // 5초 후 '짜잔!' 리턴
  }
}