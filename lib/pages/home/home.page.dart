import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: double.infinity,
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Text(
                          "LOG IN WITH FACEBOOK",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        color: Color(0xff006caa),
                        onPressed: () {},
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
                          'LOG IN WITH PHONE NUMBER',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        borderSide: BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1),
                        onPressed: () async {
                          LocationData currentLocation;
                          var location = new Location();
                          try {
                            currentLocation = await location.getLocation();
                            print(currentLocation.latitude);
                            print(currentLocation.longitude);
                          } on Exception catch (e) {
                            print(e);
                            currentLocation = null;
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
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Terms',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
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
