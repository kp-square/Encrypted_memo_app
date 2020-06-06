import 'package:flutter/cupertino.dart';
import 'package:flutter/Material.dart';
import 'models/notes.dart';
import 'addNote.dart';



class NotePage extends StatelessWidget {
  final Note myNote;
  final int index;
  NotePage({Key key,@required this.myNote,@required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return(
        GestureDetector(
            child:Scaffold(
              body:Column(
                children: <Widget>[
                  Padding(
                    child:Text(
                      myNote.title,
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.4,
                    ),
                    padding: EdgeInsets.symmetric(vertical:16.0, horizontal: 8.0),
                  ),

                  Padding(
                    child:Text(
                      myNote.note,
                      textAlign: TextAlign.left,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),

            ),
            onTap: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder:(context)=>AddNotes(myNote:this.myNote,index:this.index)),
              );
            },
        )
    );
  }
}