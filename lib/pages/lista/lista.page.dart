import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gdg_flutter/models/Message.dart';
import 'package:gdg_flutter/pages/detalhe/detalhe.page.dart';
import 'package:gdg_flutter/services/sms.service.dart';
import 'package:gdg_flutter/shared/posts.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  var client = Dio();
  List<Posts> dados = [];

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Message> messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listar();

    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print("######token#######");
      print(token);
      print(token);
      print(token);
      print(token);
      print(token);
      print(token);
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        final notification = message["notification"];
        messages.add(Message(
          title: notification["title"],
          body: notification["body"],
        ));
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void _listar() async {
    try {
      Response response =
          await client.get("https://jsonplaceholder.typicode.com/posts");
      if (response.statusCode == 200) {
        dados = (response.data as List).map((m) => Posts.fromJson(m)).toList();
      } else {
        dados = new List<Posts>();
      }
      setState(() {
        dados = dados;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: dados.length,
          itemBuilder: (context, position) {
            var p = dados[position];
            return Card(
              child: ListTile(
                  title: Text(
                    p.title.substring(0, 5),
                  ),
                  leading: Image.network(
                    "https://www.pinclipart.com/picdir/middle/155-1559316_male-avatar-clipart.png",
                    fit: BoxFit.cover,
                  ),
                  trailing: new Container(
                    child: new Text("10",
                        style: new TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w900)),
                    decoration: new BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(10.0)),
                        color: Colors.green),
                    padding: new EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                  ),
                  subtitle: Text(p.body.substring(0, 10)),
                  onLongPress: () async {
                    SmsService sms = new SmsService();
                    await sms.send("16996078881");
                  },
                  onTap: () async {
                    SmsService sms = new SmsService();
                    // await sms.send("16996078881");
                    await sms.validate("266690");
                  }),
            );
          },
        ),
      ),
    );
  }
}
