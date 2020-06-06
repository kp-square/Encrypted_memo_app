import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'models/notes.dart';
import 'notespage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ///this is an asynchronous call
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(NoteAdapter(),0);
  runApp(MyApp());
}

///Main stateless widget
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Startup Name Generator',
      home:NotesApp(),
    );
  }
}

class NotesAppState extends State<NotesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Notes App',
      home: FutureBuilder(
        future: Hive.openBox('notes',compactionStrategy: (int total,int deleted){
          return deleted > 40;
        },
        ),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            if(snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return NotesPage();
          }
          else
            return Scaffold(
              body: Center(
                child:CircularProgressIndicator(
                  backgroundColor: Colors.orange,
                )
              ),
            );
        },
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.box('notes').compact();
    Hive.close();
    super.dispose();
  }
}


///create state
class NotesApp extends StatefulWidget{
  @override
  NotesAppState createState()=>NotesAppState();
}