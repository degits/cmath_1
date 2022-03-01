
import 'package:cmath_1/paper_provider.dart';
import 'package:cmath_1/parser/parser.dart';
import 'package:cmath_1/question/question_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //!--------------------------------------------------------------------------------------------------
    List questionLineList = Parser.getQuestionAsDataStructure();


    return Scaffold(
      backgroundColor: Colors.grey[100],
      //appBar: AppBar(),
      body: ListView(
        //!question body (must be a callable function)
        children: [
          ListView(
            shrinkWrap: true,
            children: Question.getWidget(questionLineList),
          ),
          const Divider(thickness: 5.0,), 
          Text("${context.watch<Paper>().paper}"),

          const Divider(thickness: 5.0,), 
          Text("${context.watch<Paper>().status}"),
        ]
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.outbond),
            label: 'Export',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.black,
        onTap: (int item) {
          _onNavTapped(context, item);
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box),
        onPressed: () {
           _onItemTapped(context, questionLineList);
        },
      ),
    );
  }

  void _onNavTapped(BuildContext context, int item) {
    context.read<Paper>().export();
  }
  void _onItemTapped(BuildContext context, List questionList) {
    context.read<Paper>().add(questionList);
  }
}
