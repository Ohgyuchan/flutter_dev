import 'package:Finalterm/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;
  @override
  _AddPageState createState() => _AddPageState();
}

CollectionReference products = FirebaseFirestore.instance.collection('products');

class _AddPageState extends State<AddPage> {

  late User _user;
  late String id;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Add')),
        leading: TextButton(
          child: Text('Cancel'),
          style: TextButton.styleFrom(
              primary: Colors.black, textStyle: TextStyle(fontSize: 12)),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(
                  user: _user,
                ),
              ),
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Save'),
            style: TextButton.styleFrom(
                primary: Colors.white, textStyle: TextStyle(fontSize: 12)),
            onPressed: () {
              addProduct(_user.uid.toString(), productNameController.text, int.parse(productPriceController.text), descriptionController.text);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    user: _user,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                        color: Colors.blue,
                        width: 2,
                        style: BorderStyle.solid)),
                labelText: "Product Name",
                fillColor: Colors.blue,
                labelStyle: TextStyle(
                  color: Colors.blue,
                )),
            controller: productNameController,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                        color: Colors.blue,
                        width: 2,
                        style: BorderStyle.solid)),
                labelText: "Product Price",
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.blue,
                )),
            controller: productPriceController,
          ),
          TextField(
            decoration: InputDecoration(
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                        color: Colors.blue,
                        width: 2,
                        style: BorderStyle.solid)),
                labelText: "Description",
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.blue,
                )),
            controller: descriptionController,
          ),
        ],
      ),
    );
  }
  Future<void> addProduct(String uid, String productName, int productPrice, String description) {
    return products.add({
      'creator': uid,
      'created': FieldValue.serverTimestamp(),
      'modified': FieldValue.serverTimestamp(),
      'productName': productName,
      'productPrice': productPrice,
      'description': description,
      'imageUrl': 'https://handong.edu/site/handong/res/img/logo.png'
    })
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add Product: $error"));
  }
}
