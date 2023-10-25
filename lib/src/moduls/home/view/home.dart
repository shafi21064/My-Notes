import 'dart:math';
import 'package:flutter/material.dart';
import 'package:notes/src/controller/home_controller.dart';
import 'package:notes/src/data/constants/colors.dart';
import 'package:notes/src/data/utils/database_helper.dart';
import 'package:notes/src/moduls/add/view/add_task_screen.dart';
import 'package:notes/src/moduls/edit/view/edit.dart';
import 'package:notes/src/moduls/home/local_widget/header_part.dart';
import 'package:notes/src/moduls/home/local_widget/note_design.dart';
import 'package:notes/src/moduls/home/local_widget/seach_bar.dart';
import 'package:provider/provider.dart';
import '../../../data/models/note_model.dart';


class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   DBHelper dbHelper = DBHelper();



   @override
  void initState() {
     var homeController = Provider.of<HomeController>(context, listen: false);
     homeController.getData();
     print(homeController.filteredData.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var homeController = Provider.of<HomeController>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              HeaderPart(
               sortIconTap: (){
                 homeController.sortedByModifiedTIme(homeController.filteredData);
               },
             ),
              const SizedBox(
                height: 20,
              ),
              SearchBarPart(
                  onChanged: (value){
                    homeController.onSearch(value);
                  }),
              Expanded(
                  child: FutureBuilder(
                      future: dbHelper.getCartData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child:CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 5,
                          ) ,);
                        } else {
                          return ListView.builder(
                              padding: const EdgeInsets.only(top: 30),
                              itemCount: homeController.filteredData.length,
                              itemBuilder: (context, index) {
                                if (homeController.filteredData.isEmpty) {
                                  return Container(
                                    height: 100,
                                      width: 100,
                                      color: Colors.white,
                                      child: const Text('no data here', style: TextStyle(color: Colors.white),));
                                }else {
                                  return NoteDesign(
                                      cardColor: homeController.getRandomColor(),
                                      cardOnTap: (){
                                        Note note = homeController.data[index];
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditScreen(
                                                      note: note,
                                                    )));
                                      },
                                      title: homeController.filteredData[index].title.toString(),
                                      subTitle: homeController.filteredData[index].subtitle.toString(),
                                      deleteWork: (){
                                        homeController.deleteNote(index);
                                      },
                                      dateAbdTime: homeController.filteredData[index].date
                                  );
                                }
                              });
                        }
                      })),
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
