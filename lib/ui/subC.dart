import 'package:flutter/material.dart';
import 'package:ajin2/ui/leafC.dart';

class SubCategory extends StatefulWidget {
  const SubCategory({Key? key, required this.secondCtg}) : super(key: key);
  final int secondCtg;

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  final List<Entry> data = <Entry>[
    Entry('Woman Sub1.0.1'),
    Entry('Woman Sub2.0.1'),
    Entry('Woman Sub3.0.0'),
    Entry('Man Sub1.1.1'),
    Entry('Man Sub2.1.1'),
    Entry('Man Sub3.1.0'),
    Entry('Kids Sub1.2.1'),
    Entry('Kids Sub2.2.0'),
    Entry('Beauty Sub1.3.1'),
    Entry('Beauty Sub2.3.0'),
    Entry('Homeware Sub1.4.1'),
    Entry('Homeware Sub2.4.0'),
  ];

  showItem(int index, int clickMenu){
    String subject = data[index].subject;
    String menuName = subject.split('.')[0];
    String upLevel = subject.split('.')[1];
    String downLevel = subject.split('.')[2];
    String? temp;

    if(clickMenu.toString() == upLevel) {
      temp = menuName + '.' + downLevel + '.' + upLevel;
    } else {
      temp = '';
    }
    return temp;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < data.length; index++)
          if (showItem(index, widget.secondCtg) != '')
            showItem(index, widget.secondCtg).toString().split('.')[1] != '0'
              ? ExpansionTile(
                title: Text(showItem(index, widget.secondCtg).toString().split('.')[0], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                leading: Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                  child: Image.asset('assets/image_animal.jpg',),
                ),
                children: [
                  LeafCategory(thirdCtg:index, topCtg: showItem(index, widget.secondCtg).toString().split('.')[2]),
                ],
              )
            : Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                child:Row(
                  children: [
                    Image.asset('assets/image_animal.jpg', width:35, height: 35),
                    const SizedBox(width:25),
                    Text(showItem(index, widget.secondCtg).toString().split('.')[0] + '/' + showItem(index, widget.secondCtg).toString().split('.')[2],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                  ],
                ),
              )
      ],
    );
  }
}






class Entry {
  final String subject;

  Entry(this.subject);
}