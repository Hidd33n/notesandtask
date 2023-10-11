import 'package:hive_flutter/adapters.dart';
import 'package:notes/models/notes.dart';

class HiveDatabase {
  final _myBox = Hive.box('note_database');


  //Cargar Notas
  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];
  if (_myBox.get('ALL_NOTES') != null) {
    List<dynamic> savedNotes = _myBox.get('ALL_NOTES');
  for (int i=0; i < savedNotes.length; i++) {
    //Crear nota individual 
    Note individualNote = Note(id: savedNotes[i][0], text: savedNotes[i][1]);
  //Agregar a la lista
  savedNotesFormatted.add(individualNote);
  }
  }



return savedNotesFormatted;

  }



  //Notas Guardar
  void savedNotes (List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [
      /*
      [ 0 , "First Note"]
      [ 0 , "Second Note"]


      */

    ];
          for (var note in allNotes) {
        int id = note.id;
        String text = note.text;
        allNotesFormatted.add([id, text]);
      }
      _myBox.put('ALL_NOTES', allNotesFormatted);
  }

  //Fin hive notes db
  // start task hive db
  
}