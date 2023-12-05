import 'package:flutter/material.dart';
import 'package:notes_app/model/model.dart';
import 'package:notes_app/services/api_services.dart';

class NoteProvider extends ChangeNotifier{

 List<Map<String, String>> notes = [];
  TextEditingController notescontroller = TextEditingController();
  TextEditingController notesdescriptioncontroller = TextEditingController();


 edit({required id, required String title, required String description}) async {
    final toModel = Model(title: title, description: description, id: id);
    await ApiService().editNotes(value: toModel, id: id);
    notifyListeners();
  }


    save() {
    // final noteProvider = Provider.of<NoteProvider>(context);
    var notes =notescontroller.text.trim();
    var notesdescription = notesdescriptioncontroller.text.trim();

    final toModel = Model(title: notes, description: notesdescription, id: "");

    ApiService().createNotes(toModel);
    notifyListeners();
  }
   deleteNote({required id}) async {
    await ApiService().deleteNotes(id: id);
    notifyListeners();
   }
}