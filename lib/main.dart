import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final ImagePicker imagePicker = ImagePicker();
  var _image;

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
              onPressed: () async{
                /* int? aNullableInt=null;
                */ /*print(aNullableInt);
                aNullableInt=6;
                print(aNullableInt);
                aNullableInt=null;
                int value=aNullableInt ?? 0;
                print(value);*/ /*
                aNullableInt=6;
                if(aNullableInt !=null){
                  print(aNullableInt);
                }*/
                XFile? image = await imagePicker.pickImage(
                    source: ImageSource.gallery);
                setState(() {
                  _image = File(image!.path);
                });

                FirebaseStorage storage=FirebaseStorage.instance;
                Reference ref=storage.ref().child('user').child('Galeri').child('profil.png');
                UploadTask uploadTask=ref.putFile(_image);
                print('xxx'+ uploadTask.snapshot.state.toString());
                uploadTask.whenComplete(() => print('yuklendi'));
                var uri=(await uploadTask.whenComplete(() => ref.getDownloadURL()));
                print(uri);
                //print(image!.path);
                print('Galeri');
               // print(_image);
              },
              child: Text('Galeriden resim yukleme'),
            ),
            ElevatedButton(
              onPressed: () async {
                XFile? image = await imagePicker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 50,
                    preferredCameraDevice: CameraDevice.front);
                setState(() {
                  _image = File(image!.path);
                });
                FirebaseStorage storage=FirebaseStorage.instance;
                Reference ref=storage.ref().child('user').child('Kamera').child('profil.png');
                UploadTask uploadTask=ref.putFile(_image);
                var uri=(await uploadTask.whenComplete(() => ref.getDownloadURL()));
                print(uri);
                print('Kamera');
              },
              child: Text('Kameradan resim yukleme'),
            ),
            Text('Container'),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(color: Colors.red[200]),
              child: _image != null
                  ? Image.file(
                      _image,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      decoration: BoxDecoration(color: Colors.red[200]),
                      width: 200,
                      height: 200,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
            ElevatedButton(
                onPressed: (){
                  print('Cameras');
                },
                child: Text('Cameras'),
            ),
          ],
        ),
      ),
    );
  }
}
