import 'dart:math';
import 'package:flutter/material.dart';
import 'package:notes/src/data/constants/colors.dart';
import 'package:notes/src/data/models/note_model.dart';
import 'package:notes/src/data/utils/database_helper.dart';

class HomeController extends ChangeNotifier {

  List<Note> _data = [];
  List<Note> _filteredData = [];
  DBHelper _dbHelper = DBHelper();
  bool _sorted = false;



  List get data => _data;
  List<Note> get filteredData => _filteredData;
  DBHelper get dbHelper => _dbHelper;
  bool get sorted => _sorted;


   getData() async {
    _data = await _dbHelper.getCartData();
    _filteredData = _data;
    debugPrint(_filteredData.length.toString());
    //_filteredData = sortedByModifiedTIme(_filteredData);
  }

  Color getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }


  void onSearch(String searchText) {
    _filteredData = _data
        .where((note) =>
            note.subtitle!.toLowerCase().contains(searchText.toLowerCase()) ||
            note.title!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    notifyListeners();
  }

  List<Note> sortedByModifiedTIme(List<Note> notes) {
    if (_sorted) {
      notes.sort((a, b) => a.date.compareTo(b.date));
    } else {
      notes.sort((a, b) => b.date.compareTo(a.date));
    }
    _sorted = !_sorted;
    notifyListeners();
    return notes;
  }

  void deleteNote(int index) {
    _dbHelper.delete(_filteredData[index].id);
    _filteredData.removeAt(index);
    debugPrint(data.length.toString());
    notifyListeners();
  }
}
