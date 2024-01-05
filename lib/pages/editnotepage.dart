import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:notes/models/notes.dart';
import 'package:notes/models/notesdata.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditNotePage extends StatefulWidget {
  Note note;
  bool IsNewNote;
  EditNotePage({
    super.key,
    required this.note,
    required this.IsNewNote,
  });

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  quill.QuillController _controller = quill.QuillController.basic();

  void initState() {
    super.initState();
    loadExistingNote();
  }

  // Cargar nota existente
  void loadExistingNote() {
    final doc = quill.Document()..insert(0, widget.note.text);
    setState(() {
      _controller = quill.QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  // Agregar nota
  void addNewNote() {
    // Cargar ids
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    // cargar texto del editor
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false)
        .addNewNote(Note(id: id, text: text));
    // Guardar en Hive (cambios añadidos)
    Provider.of<NoteData>(context, listen: false).db.savedNotes(
        Provider.of<NoteData>(context, listen: false).getAllNotes());
  }

  // Actualizar nota existente
  void updateNote() {
    // cargar texto del editor
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
    // Guardar en Hive (cambios añadidos)
    Provider.of<NoteData>(context, listen: false).db.savedNotes(
        Provider.of<NoteData>(context, listen: false).getAllNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Si es una nueva nota
              if (widget.IsNewNote && !_controller.document.isEmpty()) {
                addNewNote();
              }

              //Si se esta actualizando una nota
              else {
                updateNote();
              }
              Navigator.pop(context);
            },
          ),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0.00,
          backgroundColor: Colors.black87,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Si es una nueva nota
            if (widget.IsNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            }
            // Si se está actualizando una nota
            else {
              updateNote();
            }
            Navigator.pop(context);
          },
          elevation: 0,
          backgroundColor: Colors.black87,
          icon: const Icon(Icons.save_sharp),
          label: const Text('Save'),
        ),
        body: Column(
          children: [
            //Herramientas
            quill.QuillToolbar.basic(
              controller: _controller,
              showAlignmentButtons: false,
              showBackgroundColorButton: false,
              showBoldButton: false,
              showCenterAlignment: false,
              showCodeBlock: false,
              showClearFormat: false,
              showColorButton: false,
              showDirection: false,
              showDividers: false,
              showFontFamily: false,
              showFontSize: false,
              showHeaderStyle: false,
              showIndent: false,
              showInlineCode: false,
              showItalicButton: false,
              showJustifyAlignment: false,
              showLeftAlignment: false,
              showLink: false,
              showListBullets: false,
              showListCheck: false,
              showListNumbers: false,
              showQuote: false,
              showRedo: true,
              showRightAlignment: false,
              showSearchButton: false,
              showSmallButton: false,
              showStrikeThrough: false,
              showSubscript: false,
              showSuperscript: false,
              showUnderLineButton: false,
              showUndo: true,
            ),

            //editor
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(25),
              child: quill.QuillEditor.basic(
                  controller: _controller, readOnly: false),
            ))
          ],
        ));
  }
}
