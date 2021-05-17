import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Finalterm/home.dart';

import 'edit.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {Key? key, required User user, required ProductItem productItem})
      : _user = user,
        _productItem = productItem,
        super(key: key);

  final User _user;
  final ProductItem _productItem;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool thumup = false;
  late User _user;
  late ProductItem _productItem;

  @override
  void initState() {
    _user = widget._user;
    _productItem = widget._productItem;
    super.initState();
  }

  late String id;
  @override
  Widget build(BuildContext context) {
    int thumbs = 31;
    Widget titleSection = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        _productItem.productName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        '\$' + '${_productItem.productPrice}',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: (thumup
                      ? Icon(Icons.thumb_up)
                      : Icon(Icons.thumb_up_outlined)),
                  onPressed: () {
                    setState(() {
                      if(thumup == false) {
                        thumbs = thumbs + 1;
                        thumup = !thumup;
                      }
                    });
                  },
                  iconSize: 30,
                  color: Colors.red,
                ),
                Text('${thumbs}',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 30,
                    )),
              ],
            ),
          ),
        ],
      ),
    );

    Widget description = Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.35,
      padding: EdgeInsets.all(20.0),
      child: Container(
        child: Text(
          _productItem.description,
          style: TextStyle(color: Colors.blueGrey, fontSize: 15),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Detail')),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage(user: _user)),
                    (Route<dynamic> route) => false);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.create,
            ),
            onPressed: () {
              print(_productItem.creator);
              print(_user.uid);
              if (_productItem.creator == _user.uid) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) => EditPage(user: _user, productItem: _productItem)),
                        (Route<dynamic> route) => false);
              }
              else {
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () {
              if (_productItem.creator == _user.uid) {
                deleteProduct(_productItem.documentSnapshot);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) => HomePage(user: _user)),
                        (Route<dynamic> route) => false);
              }
              else {
              }
            },
          ),
        ],
      ),
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
                child: Stack(
                  children: [
                    InkWell(
                      child: Image.network(
                        _productItem.imageUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
              titleSection,
              Divider(height: 1.0, color: Colors.black),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  description,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'creator: <' + _productItem.creator + '>',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(_productItem.created.toDate().toString() +
                          ' created',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(_productItem.modified.toDate().toString() +
                          ' modified',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> deleteProduct(DocumentSnapshot doc) async {
  await FirebaseFirestore.instance.collection("products").doc(doc.id).delete();
}
