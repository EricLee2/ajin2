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
  ];

  String getMenu(){

    data.forEach((el) {
      String subject = el.subject;
      String menuName = subject.split('.')[0];
      String upLevel = subject.split('.')[1];
      String downLevel = subject.split('.')[2];

      print(menuName + '/' + upLevel + '/' + downLevel) ;


/*      String fromDate = el.date;
      DateTime dt = DateTime.parse(fromDate).toUtc();

      Map<DateTime, List<Event>> oneEvent = { dt : [Event(el.name)] };
      events.addAll(oneEvent);*/
    });
    return showItem();
  }

  showItem(){
    data.forEach((el) {
      String subject = el.subject;
      String menuName = subject.split('.')[0];
      String upLevel = subject.split('.')[1];
      String downLevel = subject.split('.')[2];

      print(menuName + '/' + upLevel + '/' + downLevel);
    });

      return ExpansionTile(
      title: Text( 'menuName' + '/' + widget.secondCtg.toString(),  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
      leading: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        child: Image.asset('assets/image_animal.jpg',),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(data.length);
  }

  @override
  Widget build(BuildContext context) {
    return showItem();
/*    return ExpansionTile(
      title: Text(getMenu().toString() + '/' + widget.secondCtg.toString(),  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
      leading: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        child: Image.asset('assets/image_animal.jpg',),
      ),
    );*/
    //return showSubMenu();
  }


}






class Entry {
  final String subject;

  Entry(this.subject);
}