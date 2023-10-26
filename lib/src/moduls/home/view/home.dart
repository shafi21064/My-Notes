import 'package:flutter/material.dart';
import 'package:notes/src/controller/home_controller.dart';
import 'package:notes/src/data/utils/database_helper.dart';
import 'package:notes/src/moduls/add/view/add_task_screen.dart';
import 'package:notes/src/moduls/edit/view/edit.dart';
import 'package:notes/src/moduls/home/local_widget/header_part.dart';
import 'package:notes/src/moduls/home/local_widget/note_design.dart';
import 'package:notes/src/moduls/home/local_widget/notes_list.dart';
import 'package:notes/src/moduls/home/local_widget/seach_bar.dart';
import 'package:provider/provider.dart';
import '../../../data/models/note_model.dart';


class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   // DBHelper dbHelper = DBHelper();



   @override
  void initState() {
     var homeController = Provider.of<HomeController>(context, listen: false);
     homeController.getData();
     homeController.sortedByModifiedTIme(homeController.filteredData);
     print(homeController.filteredData.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              HeaderPart(),
              SizedBox(
                height: 20,
              ),
              SearchBarPart(),
              Expanded(
                  child: NotesList()
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen()));
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }

  // Future<dynamic> confirmDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           backgroundColor: Colors.grey.shade900,
  //           icon: const Icon(
  //             Icons.info,
  //             color: Colors.grey,
  //           ),
  //           title: const Text(
  //             "Are you sure you want to delete?",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           content: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 style:
  //                 ElevatedButton.styleFrom(backgroundColor: Colors.green),
  //                 child: const SizedBox(
  //                     width: 60,
  //                     child: Text(
  //                       "Yes",
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(color: Colors.white),
  //                     )),
  //               ),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.pop(context, false);
  //                 },
  //                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
  //                 child: const SizedBox(
  //                     width: 60,
  //                     child: Text(
  //                       "no",
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(color: Colors.white),
  //                     )),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
}
