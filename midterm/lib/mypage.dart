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
  List<Hotel> products = List<Hotel>();
  int index = 0;
  int max_i = 0;

  @override
  void initState() {
    super.initState();
    products = List.from(widget.saved);
    max_i = widget.saved.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Container(
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        _buildParallaxBackground(context, 0),
                        _buildTitleAndSubtitle(0),
                        _buildParallaxBackground(context, 1),
                        _buildTitleAndSubtitle(1),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildParallaxBackground(BuildContext context, int index) {
    return Image.asset(
      products[index].assetName,
      fit: BoxFit.cover,
    );
  }

  Widget _buildTitleAndSubtitle(int index) {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            products[index].name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            products[index].location,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
