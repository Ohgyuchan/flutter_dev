import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Finalterm/home.dart';

class EditPage extends StatefulWidget {
  const EditPage(
      {Key? key, required User user, required ProductItem productItem})
      : _user = user,
        _productItem = productItem,
        super(key: key);

  final User _user;
  final ProductItem _productItem;

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
    Widget titleSection = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.blue,
                                width: 2,
                                style: BorderStyle.solid)),
                        hintText: _productItem.productName,
                        fillColor: Colors.blue,
                        hintStyle: TextStyle(
                          color: Colors.blue,
                        )),
                    controller: productNameController,
                  ),
                ),
                Container(
                  width: 250,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.blue,
                                width: 2,
                                style: BorderStyle.solid)),
                        hintText: '${_productItem.productPrice}',
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                          color: Colors.blue,
                        )),
                    controller: productPriceController,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget description = Container(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
            focusedBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                    color: Colors.blue, width: 2, style: BorderStyle.solid)),
            hintText: _productItem.description,
            fillColor: Colors.white,
            hintStyle: TextStyle(
              color: Colors.blue,
            )),
        controller: descriptionController,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Detail')),
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
              updateProduct(
                  _productItem.id,
                  productNameController.text,
                  int.parse(productPriceController.text),
                  descriptionController.text);
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
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  description,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> updateProduct(
    String id, String productName, int productPrice, String description) async {
  await FirebaseFirestore.instance
      .collection("products")
      .doc(id)
      .update({"productName": productName});
  await FirebaseFirestore.instance
      .collection("products")
      .doc(id)
      .update({"productPrice": productPrice});
  await FirebaseFirestore.instance
      .collection("products")
      .doc(id)
      .update({"description": description});
  await FirebaseFirestore.instance
      .collection("products")
      .doc(id)
      .update({"modified": FieldValue.serverTimestamp()});
}
