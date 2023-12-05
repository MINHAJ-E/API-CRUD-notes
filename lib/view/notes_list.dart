import 'package:flutter/material.dart';
import 'package:notes_app/controller/notes_provider.dart';
import 'package:notes_app/view/edit_page.dart';
import 'package:notes_app/model/model.dart';
import 'package:notes_app/services/api_services.dart';
import 'package:provider/provider.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Center(child: Text("Notes")),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () => ApiService().fetchApi(),
          child: Consumer<NoteProvider>(
            builder: (context, noteProvider, child) => FutureBuilder(
              future: ApiService().fetchApi(),
              builder: (context, AsyncSnapshot<List<Model>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Model> notesData = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: notesData.length,
                    itemBuilder: (context, index) {
                      final noteData = notesData[index];
                      final note = noteData.title;
                      final description = noteData.description;

                      return IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Title:  ${note}" ?? "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Description:  ${description}" ?? "",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            color: Colors.blueGrey,
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (ctx) => EtidPage(
                                                    title: noteData.title,
                                                    description: noteData.description,
                                                    id: noteData.id,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            color: Colors.red,
                                            onPressed: () {
                                             
                                                // ApiService().deleteNotes(id: noteData.id);
                                                noteProvider.deleteNote(id: noteData.id);
                                            
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
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
    final noteProvider = Provider.of<NoteProvider>(context);
    return AlertDialog(
      title: Text('ADD NOTES'),
      content: Container(
        height: 230,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: noteProvider.notescontroller,
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
                controller: noteProvider.notesdescriptioncontroller,
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
         
             noteProvider.save();
              noteProvider.notescontroller.clear();
              noteProvider.notesdescriptioncontroller.clear();
          
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
