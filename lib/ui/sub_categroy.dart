import 'package:flutter/material.dart';
import 'package:ajin2/ui/leaf_category.dart';

class SubCategory extends StatefulWidget {
  const SubCategory({Key? key, required this.secondCtg}) : super(key: key);
  final String secondCtg;

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.secondCtg, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
      leading: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        child: Image.asset('assets/image_animal.jpg',),
      ),
      children: [
        LeafCategory(thirdCtg:'Leaf Menu1'),
        LeafCategory(thirdCtg:'Leaf Menu2'),
        LeafCategory(thirdCtg:'Leaf Menu3'),
        LeafCategory(thirdCtg:'Leaf Menu4'),
      ],
    );
  }
}
