import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ajin2/flutter_dropdown_page.dart';
import 'package:ajin2/normal_dropdown_page.dart';
import 'package:ajin2/text_field_dropdown_page.dart';

class DropDown extends StatefulWidget {
  const DropDown({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 기본 드롭 박스.
            CupertinoButton(
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FlutterDropdownPage(),
                  ),
                );
              },
              child: const Text(
                'Flutter 기본 드롭박스',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

            // 여백.
            const SizedBox(height: 20),

            // 커스텀 드롭 박스.
            CupertinoButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomDropdownPage(),
                  ),
                );
              },
              child: const Text(
                '커스텀 드롭박스',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

            // 여백.
            const SizedBox(height: 20),

            // 커스텀 입력창 드롭 박스.
            CupertinoButton(
              color: Colors.amberAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomTextFieldDropdownPage(),
                  ),
                );
              },
              child: const Text(
                '입력창 드롭박스',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 커스텀 입력창 드롭 박스.
            CupertinoButton(
              color: Colors.amberAccent,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'History Back',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}