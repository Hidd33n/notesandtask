import 'package:flutter/material.dart';
import 'package:notes/data/notehive_databse.dart';
import 'package:notes/models/notes.dart';

class NoteData extends ChangeNotifier{

  //hive
  final db = HiveDatabase();





//Lista de notas
List<Note> allNotes = [
  //Default note

];


//Inicializar lista
void initializeNotes() {
  allNotes = db.loadNotes();
}




// Cargar lista
List<Note> getAllNotes() {
  return allNotes;
}
//Añadir nota
void addNewNote(Note note) {
  allNotes.add(note);
  notifyListeners();
}
//Actualizar nota
void updateNote(Note note, String text) {
  for (int i=0; i< allNotes.length; i++){
    if (allNotes[i].id == note.id) {
      //Remplazar texto
      allNotes[i].text = text;

    }

  }
          notifyListeners();
}
//Eliminar nota
void deleteNote(Note note) {
  allNotes.remove(note);
  notifyListeners();
}



}