import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'routeGenerator.dart';
import 'utils.dart';


class NotesAppState extends State<NotesApp> with WidgetsBindingObserver {
  AppLifecycleState _appState;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    Hive.box('notes').compact();
    Hive.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    setState(() {
      _appState = state;
      if(_appState.toString()=='AppLifecycleState.paused'){
        //TODO
        ///need to clear the app from memory
        SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title:'Notes App',
        home: FutureBuilder(
        //an immediate anonymous function to include the logic
        future: (() async{
          var box = Hive.box('security');
          var encryption = box.get('encryption', defaultValue: false);
          if(encryption){
            var _storage = FlutterSecureStorage();
            String value = await _storage.read(key: 'hivepassword');
            var key = Utils.stringToKey(value);
            return Hive.openBox('notes',encryptionKey: key, compactionStrategy: (int total,int deleted){
            return deleted > 40;
            });
          }
          else{
            return Hive.openBox('notes',compactionStrategy: (int total,int deleted){
            return deleted > 40;
            });
          }
        }()
          ),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.done){
              if(snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return MaterialApp(
                  initialRoute:'/',
                  onGenerateRoute: RouteGenerator.generateRoute,
                );
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
}


///create state
class NotesApp extends StatefulWidget{
  @override
  NotesAppState createState()=>NotesAppState();
}