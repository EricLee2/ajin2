import 'package:ajin2/ui/drawer.dart';
import 'package:flutter/material.dart';
import 'package:ajin2/bottomnavigationbar.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class MyArcodion extends StatefulWidget {
  const MyArcodion({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyArcodion> createState() => _MyArcodionState();
}

class _MyArcodionState extends State<MyArcodion> {

  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyleHeader = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  final _loremIpsum =
  '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [IconButton(icon: Icon(Icons.settings, color: Colors.white,), onPressed: null)],
        elevation: 1,
      ),
      drawer: ShowDrawer(),
      body: ArcodionWidget(),
      bottomNavigationBar: const BottomNavi(),
    );
  }

  Widget ArcodionWidget(){
    return Container(
      child: Accordion(
        maxOpenSections: 1, // open되는 최대 아코디언 수, 가장 최근에 오픈된 것 기준
        headerBackgroundColorOpened: Colors.amber,
        //scaleWhenAnimating: true,
        //openAndCloseAnimation: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
        sectionClosingHapticFeedback: SectionHapticFeedback.light,
        children: [
          AccordionSection(
            isOpen: true, // page loading시 open 설정
            leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
            //headerBackgroundColor: Colors.black,
            //headerBackgroundColorOpened: Colors.red,
            header: Text('Introduction', style: _headerStyle),
            content: Text(_loremIpsum, style: _contentStyle),
            contentHorizontalPadding: 20,
            contentBorderWidth: 1,
            // onOpenSection: () => print('onOpenSection ...'),
            //onCloseSection: () => print('onCloseSection ...'),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
            header: Text('Nested Accordion', style: _headerStyle),
            contentBorderColor: const Color(0xffffffff),
            //headerBackgroundColorOpened: Colors.amber,
            content: Accordion(
              maxOpenSections: 1,
              headerBackgroundColorOpened: Colors.black54,
              headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              children: [
                AccordionSection(
                  isOpen: true,
                  leftIcon:
                  const Icon(Icons.insights_rounded, color: Colors.white),
                  headerBackgroundColor: Colors.black38,
                  headerBackgroundColorOpened: Colors.black54,
                  header: Text('Nested Section #1', style: _headerStyle),
                  content: Text(_loremIpsum, style: _contentStyle),
                  contentHorizontalPadding: 20,
                  contentBorderColor: Colors.black54,
                ),
                AccordionSection(
                  isOpen: true,
                  leftIcon:
                  const Icon(Icons.compare_rounded, color: Colors.white),
                  header: Text('Nested Section #2', style: _headerStyle),
                  headerBackgroundColor: Colors.black38,
                  headerBackgroundColorOpened: Colors.black54,
                  contentBorderColor: Colors.black54,
                  content: Row(
                    children: [
                      const Icon(Icons.compare_rounded,
                          size: 120, color: Colors.orangeAccent),
                      Flexible(
                          flex: 1,
                          child: Text(_loremIpsum, style: _contentStyle)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.food_bank, color: Colors.white),
            header: Text('Company Info', style: _headerStyle),
            content: DataTable(
              sortAscending: true,
              sortColumnIndex: 1,
              dataRowHeight: 40,
              showBottomBorder: false,
              columns: [
                DataColumn(
                    label: Text('ID', style: _contentStyleHeader),
                    numeric: true),
                DataColumn(
                    label: Text('Description', style: _contentStyleHeader)),
                DataColumn(
                    label: Text('Price', style: _contentStyleHeader),
                    numeric: true),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text('1',
                        style: _contentStyle, textAlign: TextAlign.right)),
                    DataCell(Text('Fancy Product', style: _contentStyle)),
                    DataCell(Text(r'$ 199.99',
                        style: _contentStyle, textAlign: TextAlign.right))
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('2',
                        style: _contentStyle, textAlign: TextAlign.right)),
                    DataCell(Text('Another Product', style: _contentStyle)),
                    DataCell(Text(r'$ 79.00',
                        style: _contentStyle, textAlign: TextAlign.right))
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('3',
                        style: _contentStyle, textAlign: TextAlign.right)),
                    DataCell(Text('Really Cool Stuff', style: _contentStyle)),
                    DataCell(Text(r'$ 9.99',
                        style: _contentStyle, textAlign: TextAlign.right))
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('4',
                        style: _contentStyle, textAlign: TextAlign.right)),
                    DataCell(
                        Text('Last Product goes here', style: _contentStyle)),
                    DataCell(Text(r'$ 19.99',
                        style: _contentStyle, textAlign: TextAlign.right))
                  ],
                ),
              ],
            ),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.contact_page, color: Colors.white),
            header: Text('Contact', style: _headerStyle),
            content: Wrap(
              children: List.generate(
                  30,
                      (index) => const Icon(Icons.contact_page,
                      size: 30, color: Color(0xff999999))),
            ),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.computer, color: Colors.white),
            header: Text('Jobs', style: _headerStyle),
            content: const Icon(Icons.computer,
                size: 200, color: Color(0xff999999)),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.movie, color: Colors.white),
            header: Text('Culture', style: _headerStyle),
            content:
            const Icon(Icons.movie, size: 200, color: Color(0xff999999)),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.people, color: Colors.white),
            header: Text('Community', style: _headerStyle),
            content:
            const Icon(Icons.people, size: 200, color: Color(0xff999999)),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.map, color: Colors.white),
            header: Text('Map', style: _headerStyle),
            content: const Icon(Icons.map, size: 200, color: Color(0xff999999)),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.menu_book, color: Colors.white),
            header: Text('Sub Menun', style: _headerStyle),
            //contentBorderColor: const Color(0xffffffff),
            contentBorderColor: Colors.grey[400],
            headerBackgroundColorOpened: Colors.amber,
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Submenu #1'),
                    ),
                  ),
                  Divider(thickness: 1, height: 1, color: Colors.grey,),
                  SizedBox(
                    height: 35,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Submenu #1'),
                    ),
                  )
                ],
              ),
            ),
            contentHorizontalPadding: 1,
            contentVerticalPadding: 1,
            contentBorderWidth: 1,
          ),
        ],
      ),
    );
  }
}

/*  return SingleChildScrollView(
  scrollDirection: Axis.vertical,*/

