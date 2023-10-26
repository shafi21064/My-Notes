import 'package:flutter/material.dart';
import 'package:notes/src/controller/home_controller.dart';
import 'package:notes/src/data/models/note_model.dart';
import 'package:notes/src/moduls/edit/view/edit.dart';
import 'package:notes/src/moduls/home/local_widget/note_design.dart';
import 'package:provider/provider.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Provider.of<HomeController>(context);
    return FutureBuilder(
        future: homeController.dbHelper.getCartData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child:CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 5,
            ) ,);
          } else {
            if (homeController.filteredData.isEmpty) {
              return const Center(
                  child: Text(
                    'No notes added yet',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ));
            }else {
              return ListView.builder(
                  padding: const EdgeInsets.only(top: 30),
                  itemCount: homeController.filteredData.length,
                  itemBuilder: (context, index) {
                    return NoteDesign(
                        cardColor: homeController
                            .getRandomColor(),
                        cardOnTap: () {
                          Note note = homeController.data[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditScreen(
                                        note: note,
                                      )));
                        },
                        title: homeController.filteredData[index]
                            .title.toString(),
                        subTitle: homeController
                            .filteredData[index].subtitle
                            .toString(),
                        deleteWork: () {
                          homeController.deleteNote(index);
                        },
                        dateAbdTime: homeController
                            .filteredData[index].date
                    );
                  });
            }
          }
        });
  }
}
