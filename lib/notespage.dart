import 'package:flutter/cupertino.dart';
import 'package:flutter/Material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/notes.dart';
import 'package:hive/hive.dart';

class NotesPageState extends State<NotesPage>{
  final int intMaxValue = 9223372036854775807;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:Text('Notes'),
        backgroundColor: Colors.orange,
      ),
      body:Column(
        children: <Widget>[
          Expanded(child:_buildListView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addnote',arguments: {'mynote':Note('',''), 'index':this.intMaxValue});
        },
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
          child:Column(
            children: <Widget>[
              AppBar(
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Colors.orange,
              ),
              ListTile(
                title:Text('Add Security'),
                onTap:(){
                  Navigator.pushNamed(context, '/secureform',arguments: {});
                },
              ),
              ListTile(
                title:Text('Check Password'),
                onTap:(){
                  Navigator.pushNamed(context, '/enterpassword', arguments: {});
                },
              ),
            ],
          ),
        ),

    );
  }

  Widget _buildListView(){
    return WatchBoxBuilder(box:Hive.box('notes') , builder: (context,notesBox){
      return ListView.builder(
        itemCount: notesBox.length,
        itemBuilder: (context,index){
          final _note = notesBox.getAt(index) as Note;

          return ListTile(
            title:Text(_note.title),
            subtitle: Text(_note.note),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon:Icon(Icons.delete),
                  onPressed: (){
                    //ToDo
                    //Deleting the data
                    notesBox.deleteAt(index);
                  },

                )
              ],
            ),
            onTap: (){
              Navigator.pushNamed(context,'/notepage',arguments: {'mynote':_note,'index':index});
            },
          );
        },
      );
     },
    );
  }
}

class NotesPage extends StatefulWidget{
  @override
  NotesPageState createState()=>NotesPageState();
}

