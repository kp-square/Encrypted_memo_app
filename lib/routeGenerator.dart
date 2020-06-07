import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'notespage.dart';
import 'notepage.dart';
import 'secureForm.dart';
import 'addNote.dart';
import 'enterPassword.dart';

class RouteGenerator{

  ///main routing routine
  static Route<dynamic> generateRoute(RouteSettings setting){
    final Map arguments = setting.arguments as Map;

    switch(setting.name){
      case '/':
        var box = Hive.box('security');
        var encryption = box.get('encryption', defaultValue: false);
        if(encryption){
          return MaterialPageRoute(
            builder: (_)=>EnterPassword(),
          );
        }
        return MaterialPageRoute(
          builder:(_)=>NotesPage(),
        );

      case '/notespage':
        return MaterialPageRoute(
          builder: (_)=>NotesPage(),
        );

      case '/addnote':
        return MaterialPageRoute(
          builder:(_)=>AddNotes(myNote: arguments['mynote'], index: arguments['index'])
        );

      case '/notepage':
        return MaterialPageRoute(
          builder: (_)=>NotePage(myNote: arguments['mynote'], index: arguments['index'])
        );

      case '/secureform':
        return MaterialPageRoute(
          builder:(_)=>SecureForm()
        );

      case '/enterpassword':
        return MaterialPageRoute(
          builder: (_)=>EnterPassword()
        );

      default:
        return _errorRoute();
    }


  }

  ///function that runs when encountering error in routing
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(
      builder: (_){
        return Scaffold(
          body:Center(
            child: Column(
              children: <Widget>[
                Text('Wrong Route'),
                Text('Go Back'),
              ],
            ),
          )
        );
      }
    );
  }
}