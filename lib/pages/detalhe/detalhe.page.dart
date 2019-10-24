import 'package:flutter/material.dart';
import 'package:gdg_flutter/shared/posts.dart';

class DetalhePage extends StatefulWidget {
  final Posts post;

  const DetalhePage({Key key, this.post}) : super(key: key);

  @override
  _DetalhePageState createState() => _DetalhePageState();
}

class _DetalhePageState extends State<DetalhePage> {
  @override
  Widget build(BuildContext context) {
    // widget.post
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.id.toString()),
      ),
      body: Column(
        children: <Widget>[
          Image.network(
              "https://t.i.uol.com.br/tecnologia/2011/03/25/wallpaper-bliss-do-windows-xp-imagem-foi-tirada-em-napa-valley-na-california-1301097208253_615x300.jpg",
              fit: BoxFit.cover),
          SizedBox(height: 50,),
          Text(widget.post.title),
          SizedBox(height: 50,),
          Text(widget.post.body),
        ],
      ),
    );
  }
}
