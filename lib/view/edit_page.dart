import 'package:flutter/material.dart';
import 'package:notes_app/controller/notes_provider.dart';
import 'package:notes_app/model/model.dart';
import 'package:notes_app/services/api_services.dart';
import 'package:provider/provider.dart';

class EtidPage extends StatefulWidget {
  final title;
  final description;
  final id;
  const EtidPage({Key? key,required this.title, required this.description,required this.id}) : super(key: key);

  @override
  State<EtidPage> createState() => _EtidPageState();
}

class _EtidPageState extends State<EtidPage> {
  TextEditingController notescontroller = TextEditingController();
  TextEditingController notesdescriptioncontroller = TextEditingController();

  // void save() {
  //   // Add your save logic here
  //   print('Save button pressed');
  // }
@override
  void initState() {
   notescontroller=TextEditingController(text: widget.title);
   notesdescriptioncontroller=TextEditingController(text: widget.description);
    super.initState();
  }
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: YourAlertDialog(),
    );
  }

  AlertDialog YourAlertDialog() {
    final notepro=Provider.of<NoteProvider>(context);
    return AlertDialog(
      title: Text('ADD NOTES'),
      content: Container(
        height: 230,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: notescontroller,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                minLines: 5,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                controller: notesdescriptioncontroller,
                decoration: InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
       TextButton(
  onPressed: () {
    notepro.edit(
      id: widget.id,
      title: notescontroller.text,
      description: notesdescriptioncontroller.text,
    );
    Navigator.of(context).pop();
  },
  child: Text('EDIT'),
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
  // edit({required id})async{
  //   var editnote=notescontroller.text;
  //   var editnotedescription=notesdescriptioncontroller.text;

  // final toModel= Model(title: editnote, description: editnotedescription, id: id);

  // ApiService().editNotes(value:toModel , id: id);

  // }
}