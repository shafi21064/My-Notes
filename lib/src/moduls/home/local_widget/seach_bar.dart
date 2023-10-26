import 'package:flutter/material.dart';
import 'package:notes/src/controller/home_controller.dart';
import 'package:provider/provider.dart';

class SearchBarPart extends StatelessWidget {

  const SearchBarPart({super.key,});

  @override
  Widget build(BuildContext context) {
    var homeController = Provider.of<HomeController>(context);
    return TextField(
      onChanged: (value){
        homeController.onSearch(value);
      } ,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          hintText: "Search notes ",
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          fillColor: Colors.grey.shade800,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.transparent))),
    );
  }
}
