import 'package:flutter/material.dart';
import 'package:notes_app/controller/notes_provider.dart';
import 'package:notes_app/view/notes_list.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context)=> NoteProvider()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
        home:  NotesListPage(),
      ),
    );
  }
}