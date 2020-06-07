import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'models/notes.dart';
import 'notesapp.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ///this is an asynchronous call
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(NoteAdapter(),0);
  await Hive.openBox('security');
  runApp(NotesApp());
}