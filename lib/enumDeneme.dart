import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:storage/api_response_status.dart';
// @dart=2.9

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

enum  ApiResponseStatus1 {successful,unfound}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: (){
                print('Galeri');
              },
              child: Text('Galeriden resim yukleme'),
            ),
            ElevatedButton(
              onPressed:(){
                //print(ApiResponseStatus1.unfound);
                print('Kamera');
              },
              child: Text('Kameradan resim yukleme'),
            ),
          ],
        ),
      ),
    );
  }

  Future galeriden_yukleme() async {

    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {

    });
    //Reference reference=FirebaseStorage.instance.ref().child('user').child('ali').child('profil.png');
    //UploadTask uploadTask=reference.putFile(_image);
  }
}


