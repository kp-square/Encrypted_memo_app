import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbkdf2_dart/pbkdf2_dart.dart';
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'utils.dart';

class SecureFormState extends State<SecureForm>{
  String _password1;
  String _password2;


  _encryptDatabase() async{
    var gen = new PBKDF2(hash: sha256);
    var securekey = gen.generateKey(_password1, "salt", 1000, 32);
    
    ///copy all contents in a list
    var prevBox = Hive.box('notes');
    var boxSize = prevBox.length;
    var data = [];
    for(var i=0;i<boxSize;i++){
      data.add(prevBox.getAt(i));
    }

    ///delete the box from the disk
    await prevBox.deleteFromDisk();

    ///create new secure box with the same name
    var box = await Hive.openBox('notes',encryptionKey: securekey);

    ///transfer the data to the new secure box
    for(var x in data){
      print(x.title);
      box.add(x);
    }

    ///secure key need to be changed to string to store in keystore
    String str = Utils.keyToString(securekey);

    ///open the keystore
    var storage = FlutterSecureStorage();

    ///store the key to the keystore
    await storage.write(key: 'hivepassword', value: str);

    ///set the encryption key on
    var secureBox = Hive.box('security');
    secureBox.put('encryption', true);

    ///go back
    Navigator.pop(context);
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
            obscureText: true,
          ),
          Text('Confirm password'),
          TextFormField(
            onChanged: (value)=>_password2=value,
            obscureText: true,
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