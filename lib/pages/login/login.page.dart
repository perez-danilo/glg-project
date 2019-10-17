import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
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
              flex: 2,
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
                            hintText: "eMail",
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
                            hintText: "senha",
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
                            var user = await _handleLogin();
                            print(user);
                            //var snackBar =
                            //    SnackBar(content: Text('Usuário ' + user.displayName + ' logado!'));
                            //Scaffold.of(context).showSnackBar(snackBar);
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(''),
                      //decoration: BoxDecoration(color: Colors.blue),
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
