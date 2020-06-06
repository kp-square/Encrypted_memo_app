import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class EnterPasswordState extends State<EnterPassword>{
  String _password;

  _confirmPassword(){
    print(_password);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Identity'),
        backgroundColor: Colors.orange,
      ),
      body:Column(
        children: <Widget>[
          Text('Enter password'),
          TextFormField(
            onChanged: (value)=>_password=value,
          ),

          FlatButton(
            onPressed: _confirmPassword,
            child: Text('confirm'),
            color: Colors.orange,
          )
        ],
      ),
    );
  }
}

class EnterPassword extends StatefulWidget{
  @override
  EnterPasswordState createState()=>EnterPasswordState();
}