import 'package:flutter/material.dart';

class LeafCategory extends StatefulWidget {
  const LeafCategory({Key? key, required this.thirdCtg}) : super(key: key);
  final String thirdCtg;

  @override
  State<LeafCategory> createState() => _LeafCategoryState();
}

class _LeafCategoryState extends State<LeafCategory> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.pushNamedAndRemoveUntil(context, '/schedule', (route) => false);},
      child: Container(
        //width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(75, 10, 18, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.thirdCtg, style: TextStyle(fontSize: 15, color: Colors.black45,),),
                const Icon(Icons.remove, color: Colors.black45,),
              ],
            ),
            Divider(thickness: 1,)
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