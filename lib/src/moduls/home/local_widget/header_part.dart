import 'package:flutter/material.dart';
import 'package:notes/src/controller/home_controller.dart';
import 'package:provider/provider.dart';

class HeaderPart extends StatelessWidget {

  const HeaderPart({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Provider.of<HomeController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Note",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        IconButton(
          onPressed: (){
            homeController.sortedByModifiedTIme(homeController.filteredData);
          },
          padding: const EdgeInsets.all(0),
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.grey.shade800.withOpacity(.8),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.sort, color: Colors.white,)
          ),
        ),
      ],
    );
  }
}
