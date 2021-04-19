import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'detail.dart';
import 'model/model_hotel.dart';

class MyPage extends StatefulWidget {
  List<Hotel> saved = List<Hotel>();
  MyPage({this.saved});
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/diamond.png'),
                    ),
                  ),
                  Container(
                    child: Text('Gyuchan Oh',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Container(
                    child: Text('21700443',
                        style: TextStyle(fontSize: 15, color: Colors.grey)),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('My Favorite Hotel List',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
