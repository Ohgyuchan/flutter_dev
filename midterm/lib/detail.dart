import 'package:flutter/material.dart';
import 'model/model_hotel.dart';
import 'dart:ui';

class DetailPage extends StatefulWidget {
  final Hotel hotel;

  const DetailPage({this.hotel});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
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
              Image.asset(
                widget.hotel.assetName,
                width: 600,
                height: 240,
                fit: BoxFit.cover,
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
