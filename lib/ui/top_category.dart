import 'package:flutter/material.dart';
import 'package:ajin2/ui/sub_categroy.dart';

class TopCategory extends StatefulWidget {
  const TopCategory({Key? key, required this.firstCtg}) : super(key: key);
  final String firstCtg;

  @override
  State<TopCategory> createState() => _TopCategoryState();
}

class _TopCategoryState extends State<TopCategory> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.teal,
      //initiallyExpanded : true,
      backgroundColor: Colors.white,
      title: Container(
        color: Colors.yellow,
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
                      Text(widget.firstCtg, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Icon(_customTileExpanded
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down
                        , size: 35,),
                    ],
                  ),
                  Text('This is a test. What do you want.', style: TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis),),
                ],
              ),
            ),
            const SizedBox(width:25),
            Image.asset('assets/image_animal.jpg', ),
          ],
        )),
      //subtitle: Text('Subtitle~~~', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), // title이 Text만 인경우 subtitle가 같이 사용
      trailing: SizedBox.shrink(), // tailing을 표시하고 싶지 않은 경우
      //controlAffinity: ListTileControlAffinity.leading, // default=tailing인데 leading으로 이동하고 싶은 경우
      children: [
        SubCategory(secondCtg:'Topware'),
        SubCategory(secondCtg:'Pants'),
        SubCategory(secondCtg:'Accessory'),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => _customTileExpanded = expanded );
      },
    );
  }
}

