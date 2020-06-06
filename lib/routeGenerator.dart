////Hasn't been properly implemented yet
////To be implemented
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'notespage.dart';
//import 'notepage.dart';
//import 'secureForm.dart';
//import 'addNote.dart';
//
//
//class RouteGenerator{
//  static Route<dynamic> generateRoute(RouteSettings setting){
//    final args = setting.arguments;
//
//    switch(setting.name){
//      case '/':
//        return MaterialPageRoute(
////          builder:(_)=>(
////            data:args
////          ),
//        );
//
//      case '/notespage':
//        return MaterialPageRoute(
//          builder: (_)=>NotesPage(),
//        );
//
//      case '/addnote':
//        return MaterialPageRoute(
//          builder:(_)=>AddNotes(myNote: null, index: null)
//        );
//
//      case '/notepage':
//        return MaterialPageRoute(
//          builder: (_)=>NotePage(myNote:null,index:null)
//        );
//
//      case '/secureform':
//        return MaterialPageRoute(
//          builder:(_)=>SecureForm()
//        );
//
//
//      default:
//        return _errorRoute();
//    }
//
//
//  }
//
//  static Route<dynamic> _errorRoute(){
//    return MaterialPageRoute(
//      builder: (_){
//        return Scaffold(
//          body:Center(
//            child: Column(
//              children: <Widget>[
//                Text('Wrong Route'),
//                Text('Go Back'),
//                RaisedButton(
//                  child:Text('Go Back'),
//                  onPressed: ()=>Navigator.pop(context),
//                )
//
//              ],
//            ),
//          )
//        );
//      }
//    );
//  }
//}