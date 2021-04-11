import 'package:flutter/material.dart';
import 'model/model_hotel.dart';
import 'dart:ui';

class DetailPage extends StatefulWidget {
  final Hotel hotel;
  List<Hotel>saved = List<Hotel>();

  DetailPage({this.hotel, this.saved});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool like = false;
  @override
  void initState() {
    super.initState();
    for(int i = 0; i < widget.saved.length; i++)
      if(widget.hotel == widget.saved.elementAt(i))
        like = true;
  }

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < widget.hotel.stars; i++)
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15.0,
                      ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.hotel.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blue, size: 15.0),
                    Container(
                      width: 250,
                      child: Text(
                        widget.hotel.location,
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.blue, size: 15.0),
                    Container(
                      width: 250,
                      child: Text(
                        widget.hotel.phone,
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    Color color = Colors.black;

    Widget textSection = Container(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Text(
          widget.hotel.desc,
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
              Stack(
                children: [
                  InkWell(
                    child: Hero(
                      tag: 'imageHero',
                      child: Image.asset(
                        widget.hotel.assetName,
                        width: 600,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return new HeroPage(widget.hotel.assetName);
                      }));
                    },
                    onDoubleTap: () {
                      setState(() {
                        like = !like;
                        like ? widget.saved.add(widget.hotel) : widget.saved.remove(widget.hotel);
                      });
                    },
                  ),
                  Positioned(right: 0, top: 0, child: Icon(like ? Icons.favorite : Icons.favorite_border, size: 40, color: Colors.red,)),
                ],
              ),
              titleSection,
              Divider(height: 1.0, color: Colors.black),
              textSection,
            ],
          ),
        ),
      ),
    );
  }
}

class HeroPage extends StatelessWidget {
  final String asset_link;

  HeroPage(this.asset_link);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.asset(asset_link),
          ),
        ),
      ),
    );
  }
}
