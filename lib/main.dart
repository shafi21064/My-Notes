import 'package:flutter/material.dart';
import 'package:notes/src/controller/home_controller.dart';
import 'package:notes/src/moduls/home/view/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_)=> HomeController())
    ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen()),
    );
      
  }
}
