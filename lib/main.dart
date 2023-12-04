import 'package:flutter/material.dart';
import 'package:notes_app/notes_list.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
      home:  NotesListPage(),
    );
  }
}