import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/pages/editnotepage.dart';
import 'package:notes/models/notesdata.dart';
import 'package:provider/provider.dart';

import '../models/notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

//Crear nota
  void createNewNote() {
    //Nuevo ID
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    //Crear nota
    Note newNote = Note(
      id: id,
      text: '',
    );
    //Editar Nota
    goToNotePage(newNote, true);
  }

//Go to note page
  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => EditNotePage(
                  note: note,
                  IsNewNote: isNewNote,
                ))));
  }

//Eliminar Nota
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
        builder: (context, value, child) => Scaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            appBar: AppBar(
              title: const Text(
                'Notes',
                style: TextStyle(color: Colors.black),
              ),
              titleSpacing: 00.0,
              centerTitle: true,
              toolbarHeight: 60.2,
              toolbarOpacity: 0.8,
              elevation: 0.20,
              backgroundColor: Colors.white,
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: createNewNote,
              elevation: 0,
              backgroundColor: Colors.black87,
              label: const Text(
                'Add New Note',
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
            ),
            body: Column(
              children: [
                value.getAllNotes().isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text(
                            'Nothing here.. :c',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      )
                    : CupertinoListSection.insetGrouped(
                        children: List.generate(
                          value.getAllNotes().length,
                          (index) => CupertinoListTile(
                            title: Text(value.getAllNotes()[index].text),
                            onTap: () =>
                                goToNotePage(value.getAllNotes()[index], false),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                size: 30,
                              ),
                              onPressed: () =>
                                  deleteNote(value.getAllNotes()[index]),
                            ),
                          ),
                        ),
                      ),
              ],
            )));
  }
}
