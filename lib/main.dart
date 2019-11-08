import 'package:flutter/material.dart';
import 'package:gdg_flutter/pages/lista/lista.page.dart';

import 'pages/home/home.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaPage(),
    );
  }
}