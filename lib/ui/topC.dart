import 'package:flutter/material.dart';
import 'package:ajin2/ui/subC.dart';

class TopCategory extends StatefulWidget {
  const TopCategory({Key? key, required this.firstCtg, required this.index}) : super(key: key);
  final String firstCtg;
  final int index;

  @override
  State<TopCategory> createState() => _TopCategoryState();
}

class _TopCategoryState extends State<TopCategory> {
  bool _customTileExpanded = false;

  final List<Entry> data = <Entry>[
    Entry('Woman Sub1.0.1'),
    Entry('Woman Sub2.0.1'),
    Entry('Woman Sub3.0.0'),
    Entry('Man Sub1.1.1'),
    Entry('Man Sub2.1.1'),
    Entry('Man Sub3.1.0'),
  ];

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.amber,
      title: Container(
          height: 130,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(widget.firstCtg, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Icon(_customTileExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down
                          , size: 35,),
                      ],
                    ),
                    Text('Index is ${widget.index}', style: const TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis),),
                  ],
                ),
              ),
              const SizedBox(width:25),
              Image.asset('assets/image_animal.jpg', ),
            ],
          )),
      trailing: const SizedBox.shrink(), // tailing을 표시하고 싶지 않은 경우
      children: [
        SubCategory(secondCtg:widget.index),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => _customTileExpanded = expanded );
      },
    );
  }
}