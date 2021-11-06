import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        storage: Storage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.storage}) : super(key: key);

  final Storage storage;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  String state;
  String deneme='deneme';
  Future<Directory> _appDocDir;

  @override
  void initState() {
    super.initState();
    controller.text='ali';
    widget.storage.readData().then((String value) {
      setState(() {
        state = value;
      });
    });
  }
  Future<File> writeData() async{
    setState(() {
      state=controller.text;
      controller.text='';
    });
    return widget.storage.writeData(state);
  }

  void getAppDirectory(){
    setState(() {
      _appDocDir=getExternalStorageDirectory();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('${state ?? "File is Empty"}'),
            TextField(
              controller: controller,
            ),
            RaisedButton(onPressed: writeData,
              child: Text('Write to File'),
            ),
            RaisedButton(
              child: Text("Get DIR path"),
              onPressed: getAppDirectory,
            ),
            RaisedButton(
              child: Text('Deneme'),
              color: Colors.blue,
              onPressed: (){
                setState(() {
                });
              },
            ),
            Text(
              'Deneme : $deneme',style: TextStyle(fontSize: 30.0),
            ),
            FutureBuilder<Directory>(
              future: _appDocDir,
              builder:(BuildContext context, AsyncSnapshot<Directory> snapshot){
                Text text=Text('');
                if(snapshot.connectionState==ConnectionState.done){
                  if(snapshot.hasError){
                    text=Text('Error:${snapshot.error}');
                  }else if(snapshot.hasData){
                    text=Text('Path:${snapshot.data.path}',style: TextStyle(fontSize: 30.0),);
                  }else{
                    text=Text('unavailable');
                  }
                }
                return new Container(
                  child:text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Storage {

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db1.text');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();
      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}
