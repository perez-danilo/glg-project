import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listar();
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
