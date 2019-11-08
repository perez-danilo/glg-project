import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gdg_flutter/pages/create-account/create-account.page.dart';
import 'package:gdg_flutter/pages/login/login.page.dart';
import 'package:gdg_flutter/pages/terms/terms.page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File file;

  Future<FirebaseUser> _handleCreateUser() async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: 'danilo@casaecafe.com',
      password: '123456',
    ))
        .user;
    return user;
  }

  Future<FirebaseUser> _handleLogin() async {
    final AuthResult auth = await _auth.signInWithEmailAndPassword(
      email: 'danilo@casaecafe.com',
      password: '123456',
    );
    var user = auth.user;

    UserUpdateInfo info = new UserUpdateInfo();
    info.displayName = "Danilo Perez";
    info.photoUrl =
        "http://www.lte-esafety.co.uk/wp-content/uploads/2015/06/avatar.png";
    await user.updateProfile(info);

    await user.reload();

    /*final StorageReference storageRef =
        FirebaseStorage.instance.ref().child(info.displayName + 'jpg');
    final StorageUploadTask uploadTask = storageRef.putFile(
      File(filePath),
      StorageMetadata(
        contentType: type + '/' + extension,
      ),
    );*/

    /*final databaseReference = Firestore.instance;
    await databaseReference.collection("books").document("1").setData({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

    DocumentReference ref = await databaseReference.collection("books").add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.documentID);
    return null;*/
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    String fileName = info.displayName + '.jpg';
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/' + fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      file = image;
      print("Profile Picture uploaded " + downloadUrl);
      //Scaffold.of(context)
      //    .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });

    //UserUpdateInfo().photoUrl = "http://www.lte-esafety.co.uk/wp-content/uploads/2015/06/avatar.png";
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://i.pinimg.com/originals/fe/e5/ea/fee5eab30a698c169dc4fd5752359c2c.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.network(
                  'https://i.pinimg.com/originals/d4/d8/82/d4d882dccd11187b7980ada01a465d48.png',
                  width: 200,
                  height: 200,
                ),
              ),
              flex: 3,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    if (file != null)
                      Image.file(
                        file,
                        width: 100,
                        height: 100,
                      ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: double.infinity,
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Text(
                          "LOG IN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        color: Color(0xff006caa),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage(parametro: "Teste",)));
                          //await _handleLogin();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.transparent)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: double.infinity,
                      child: OutlineButton(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        shape: StadiumBorder(),
                        textColor: Colors.white,
                        child: Text(
                          'DONT HAVE ACCOUNT?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        borderSide: BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1),
                        onPressed: () async {
                          //await _handleLogin();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateAccountPage()));

                          //await _handleCreateUser();
                          /*LocationData currentLocation;
                          var location = new Location();
                          try {
                            currentLocation = await location.getLocation();
                            print(currentLocation.latitude);
                            print(currentLocation.longitude);
                          } on Exception catch (e) {
                            print(e);
                            currentLocation = null;
                          }*/
                        },
                      ),
                    ),
                  ],
                ),
                //decoration: BoxDecoration(color: Colors.green),
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: InkWell(
                  child: Text(
                    'Terms',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TermsPage()));
                  },
                ),
                //decoration: BoxDecoration(color: Colors.blue),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
//https://medium.com/swlh/flutter-login-registration-using-firebase-1bef34007b91
//https://medium.com/@atul.sharma_94062/how-to-use-cloud-firestore-with-flutter-e6f9e8821b27
