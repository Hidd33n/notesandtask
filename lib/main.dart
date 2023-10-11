import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/pages/taskpage.dart';
import 'package:notes/models/notesdata.dart';
import 'package:notes/pages/ui/dotnav.dart';
import 'package:provider/provider.dart';

void main() async {
  //Inicializar hive
  await Hive.initFlutter();
  //Abrir 
  await Hive.openBox('note_database');
  await Hive.openBox('task_db');

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => DotNav(),
        '/task': (context) => TaskPage(),
      },
      initialRoute: '/',
    );
  }
}
