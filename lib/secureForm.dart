import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pbkdf2_dart/pbkdf2_dart.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class SecureFormState extends State<SecureForm>{
  String _password1;
  String _password2;


  String keyToString(List<int> key){
    return key.map((i)=>i.toString()).join(',');
  }

  List<int> stringToKey(String str){
    List<int> key=[];
    var foo = str.split(',');
    for(var x in foo){
      key.add(int.parse(x));
    }
    return key;
  }

  _encryptDatabase() async{
    var gen = new PBKDF2(hash: sha256);
    var securekey = gen.generateKey(_password1, "salt", 1000, 32);
    print(securekey);
    String str = keyToString(securekey);

    ///TODO
    ///create secure storage in keystore to store the securekey
    ///delete hivebox and create new one with encryption. Store
    ///a key on the database to observe if encryption in on or off
    ///Also implement the routegenerator.

//    var storage = FlutterSecureStorage();
//    await storage.write(key: 'hivepassword', value: String.fromCharCodes(securekey));
//    print(securekey);
//    var box = Hive.box('notes');
//    Hive.deleteBoxFromDisk('notes');
  }

  _confirmPassword(){
    if(_password1==null || _password2==null){
      print('invalid password');
    }
    else if(_password1!=_password2){
      print("passwords don't match");
    }else{
      _encryptDatabase();
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Security'),
        backgroundColor: Colors.orange,
      ),
      body:Column(
        children: <Widget>[
          Text('Enter password'),
          TextFormField(
            onChanged: (value)=>_password1=value,
          ),
          Text('Confirm password'),
          TextFormField(
            onChanged: (value)=>_password2=value,
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

class SecureForm extends StatefulWidget{
  @override
  SecureFormState createState()=>SecureFormState();
}