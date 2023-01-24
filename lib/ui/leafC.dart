import 'package:flutter/material.dart';

class LeafCategory extends StatefulWidget {
  const LeafCategory({Key? key, required this.thirdCtg, required this.topCtg}) : super(key: key);
  final int thirdCtg;
  final String topCtg;

  @override
  State<LeafCategory> createState() => _LeafCategoryState();
}

class _LeafCategoryState extends State<LeafCategory> {

  final List<Entry> data = <Entry>[
    Entry('Woman Sub1_Sub1.0.1'),
    Entry('Woman Sub2_Sub2.0.1'),
    Entry('Woman Sub3_Sub3.1.1'),
    Entry('Woman Sub3_Sub3.2.0'),
    Entry('Man Sub1_Sub1.3.1'),
    Entry('Man Sub2_Sub2.3.1'),
    Entry('Man Sub3_Sub3.4.1'),
    Entry('Man Sub3_Sub3.5.0'),
    Entry('Kids Sub1_Sub1.6.1'),
    Entry('Kids Sub2_Sub2.6.1'),
    Entry('Kids Sub2_Sub2.7.0'),
    Entry('Beauty Sub1_Sub1.8.1'),
    Entry('Beauty Sub2_Sub2.8.1'),
    Entry('Beauty Sub2_Sub2.9.0'),
    Entry('Homeware Sub1_Sub1.10.1'),
    Entry('Homeware Sub2_Sub2.10.1'),
    Entry('Homeware Sub2_Sub2.11.0'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.pushNamedAndRemoveUntil(context, '/schedule', (route) => false);},
      child: Container(
        //width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(75, 10, 18, 10),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var index = 0; index < data.length; index++)
               if (data[index].subject.split('.')[1] == widget.thirdCtg.toString() && data[index].subject.split('.')[2] != '0')
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    height: 40,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data[index].subject.split('.')[0], style: const TextStyle(fontSize: 15, color: Colors.black45,),),
                            const Icon(Icons.remove, color: Colors.black45,),
                          ],
                        ),
                        const Divider(thickness: 1, height: 1, color: Colors.black45)
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class Entry {
  final String subject;

  Entry(this.subject);
}