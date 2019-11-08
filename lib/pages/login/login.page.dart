import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String parametro;

  const LoginPage({Key key, this.parametro}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String senha = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleLogin() async {
    final AuthResult auth = await _auth.signInWithEmailAndPassword(
      email: this.email,
      password: this.senha,
    );
    return auth.user;
  }

  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    print(widget.parametro);
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
            SizedBox(
              height: 100,
            ),
            AnimatedContainer(
              // Use the properties stored in the State class.
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: _borderRadius,
              ),
              // Define how long the animation should take.
              duration: Duration(seconds: 3),
              // Provide an optional curve to make the animation feel smoother.
              curve: Curves.fastOutSlowIn,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
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
                            hintText: "E-mail",
                            fillColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          senha = value;
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
                            hintText: "Senha",
                            fillColor: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: double.infinity,
                      child: OutlineButton(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        shape: StadiumBorder(),
                        textColor: Colors.white,
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        borderSide: BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1),
                        onPressed: () async {
                          try {
                            setState(() {
                              // Create a random number generator.
                              final random = Random();

                              // Generate a random width and height.
                              _width = random.nextInt(300).toDouble();
                              _height = random.nextInt(300).toDouble();

                              // Generate a random color.
                              _color = Color.fromRGBO(
                                random.nextInt(256),
                                random.nextInt(256),
                                random.nextInt(256),
                                1,
                              );

                              // Generate a random border radius.
                              _borderRadius = BorderRadius.circular(
                                  random.nextInt(100).toDouble());
                            });
                            //var user = await _handleLogin();
                            //print(user);
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
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
