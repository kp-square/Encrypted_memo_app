import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/notes.dart';
import 'package:hive/hive.dart';

class AddNotesState extends State<AddNotes>{
  final int intMaxValue = 9223372036854775807;
  String _title;
  String _note;


  _saveNote(){
    //Get the hive box
    if(this._title==null)
      this._title=widget.myNote.title;
    if(this._note==null)
      this._note = widget.myNote.note;
    var newNote = Note(this._title,this._note);
    final noteBox = Hive.box('notes');
    //Add data to the database
    if(widget.index!=this.intMaxValue){
      noteBox.putAt(widget.index, newNote);
    }else{
      noteBox.add(newNote);
    }
    Navigator.pushNamed(context, '/notespage', arguments: {});
  }

  _cancelNote(){
    //return to the previous route
    Navigator.pushNamed(context, '/notespage', arguments: {});
  }

  ///Implements a custom form to read the title and corresponding note
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body:Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:<Widget>[
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
                    child:FlatButton(
                      onPressed: _cancelNote,
                      color:Colors.white,
                      child:Text('cancel'),
                      textColor: Colors.black45,
                    ),
                  ),

                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
                    child:FlatButton(
                      onPressed: _saveNote,
                      color:Colors.white,
                      child:Text('save'),
                      textColor: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width:MediaQuery.of(context).size.width,
              padding:EdgeInsets.symmetric(horizontal: 16.0),
              child:TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                initialValue: widget.myNote.title,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Title',
                ),
                onChanged: (value)=>this._title=value,
              ),
            ),
            Container(
              width:MediaQuery.of(context).size.width,
              padding:EdgeInsets.symmetric(horizontal: 16.0),
              child:TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                initialValue: widget.myNote.note,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add Note',
                ),
                onChanged: (value)=>this._note=value,
              ),
            ),
          ],
        )
    );
  }
}

class AddNotes extends StatefulWidget{
  final Note myNote;
  final int index;

  AddNotes({Key key, @required this.myNote, @required this.index}):super(key:key);

  @override
  AddNotesState createState() => AddNotesState();
}