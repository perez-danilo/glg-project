import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String email = "";
  String name = "";
  String password = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File image;

  Future<FirebaseUser> _handleCreateAccount() async {
    final AuthResult auth = await _auth.createUserWithEmailAndPassword(
      email: this.email,
      password: this.password,
    );
    var user = auth.user;

    String fileName = this.email + '.jpg';
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/' + fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    UserUpdateInfo info = new UserUpdateInfo();
    info.displayName = this.name;
    info.photoUrl = downloadUrl;
    await user.updateProfile(info);
    await user.reload();

    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception catch (e) {
      print(e);
      currentLocation = null;
    }

    final databaseReference = Firestore.instance;
    await databaseReference.collection("usuarios").document(this.email).setData({
      'nome': this.name,
      'email': this.email,
      'foto': downloadUrl,
      'latitude' : currentLocation.latitude,
      'longitude': currentLocation.longitude
    });

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
                child: InkWell(
                  child: image == null
                      ? Image.network(
                          'https://www.fourjay.org/myphoto/f/14/143147_avatar-png.jpg',
                          width: 100,
                          height: 100,
                        )
                      : Image.file(
                          image,
                          width: 100,
                          height: 100,
                        ),
                  onTap: () async {
                    this.image =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    setState(() {
                      this.image = this.image;
                    });
                  },
                ),
              ),
              flex: 2,
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    //Image.file(file),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          name = value;
                        },
                        style: TextStyle(fontSize: 15),
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "nome",
                            fillColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          email = value;
                        },
                        style: TextStyle(fontSize: 15),
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "E-Mail",
                            fillColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                        style: TextStyle(fontSize: 15),
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "senha",
                            fillColor: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      width: double.infinity,
                      child: OutlineButton(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        shape: StadiumBorder(),
                        textColor: Colors.white,
                        child: Text(
                          'CREATE',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        borderSide: BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1),
                        onPressed: () async {
                          try {
                            var user = await _handleCreateAccount();
                            print(user);
                            if (user != null) {
                              Navigator.pop(context);
                            }
                            //var snackBar =
                            //    SnackBar(content: Text('Usuário ' + user.displayName + ' logado!'));
                            //Scaffold.of(context).showSnackBar(snackBar);
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                //decoration: BoxDecoration(color: Colors.green),
              ),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
