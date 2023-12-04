import 'package:flutter/material.dart';
import 'package:notes_app/model/model.dart';

class NotesListPage extends StatefulWidget {
  const NotesListPage({Key? key}) : super(key: key);

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  // List<String> notes = [];
   List<Map<String, String>> notes = [];
  TextEditingController notescontroller=TextEditingController();
  TextEditingController notesdescriptioncontroller=TextEditingController();
  save() {
    String note = notescontroller.text;
    String description = notesdescriptioncontroller.text;
    notes.add({'note': note, 'description': description});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Center(child: Text("Notes")),
      ),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: notes.length,
        itemBuilder: (context, index) {
  final noteData = notes[index];
  final note = noteData['note'];
  final description = noteData['description'];

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
     
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Title:  ${note}"??"",style: 
          TextStyle(color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold),),
          SizedBox(height: 8),
          Text("Description:  ${description}"??"",style:
           TextStyle(color: Colors.black54,
           fontSize: 15,
           fontWeight: FontWeight.bold),),
        ],
      ),
    ),
  );
},
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           showDialog(
                context: context,
                builder: (context) => alert(context),
              );
        },
        label: Text("Add Notes"),
      ),
    );
  }
  AlertDialog alert(BuildContext context) {
    return AlertDialog(
      title: Text('ADD NOTES'),
      content: Container(
        height: 150,
        child: Column(
          children: [
            TextField(
              controller: notescontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: notesdescriptioncontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
          setState(() {
                save();
              notescontroller.clear();
              notesdescriptioncontroller.clear();
          });
            // saved();
            // _taskController.text='';
            Navigator.of(context).pop();
          },
          child: Text('SAVE'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CANCEL'),
        ),
      ],
      elevation: 24.0,
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

}
