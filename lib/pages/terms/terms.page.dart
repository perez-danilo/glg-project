import 'package:flutter/material.dart';

class TermsPage extends StatefulWidget {
  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
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
              child: Text(
                'Este é um projeto aberto de estudo da tecnologia Flutter.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
