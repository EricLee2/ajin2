import 'package:flutter/material.dart';

class ToolTip extends StatefulWidget {
  const ToolTip({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ToolTip> createState() => _ToolTipState();
}

class _ToolTipState extends State<ToolTip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
/*              richMessage: TextSpan(
                text: 'I am a rich tooltip. ',
                style: TextStyle(color: Colors.red),
                children: <InlineSpan>[
                  TextSpan(
                    text: 'I am another span of this rich tooltip',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),*/
              message: 'This is a tooltip. It will be dismissed~~~soon~~',
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(colors: <Color>[Colors.white, Colors.grey]),
              ),
              height: 40,
              padding: const EdgeInsets.all(8.0),
              preferBelow: true,
              verticalOffset: 10,
              textStyle: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w300,
              ),
              showDuration: const Duration(seconds: 2),
              waitDuration: const Duration(seconds: 1),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Long Press',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 0,
            ),
            Chip(
              // onDeleted를 지정하면 삭제 버튼이 생김
              avatar: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: const Text('S'),
              ),
              label: const Text('Sucream'),
              onDeleted: () => print('deleted'),
            ),
            const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 0,
            ),
            const Chip(
              // onDeleted가 없으면 삭제 버튼이 없음
              avatar: CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text('S'),
              ),
              label: Text('Sucream'),
              deleteIcon: Icon(Icons.delete),
              onDeleted: null,
            ),
            const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 0,
            ),
            const Chip(
              // avatar를 지정하지 않을 수도 있음
              label: Text('포챠펭'),
              deleteIcon: Icon(Icons.delete),
              onDeleted: null,
            ),
            SizedBox(height: 50,),
            ElevatedButton(
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
    );
  }
}
