import 'package:flutter/material.dart';
import 'model/model_hotel.dart';

class FavoritePage extends StatefulWidget {
  List<Hotel> saved = List<Hotel>();
  FavoritePage({this.saved});
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Hotels'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.saved.length,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.saved[index].name;
          return Dismissible(
            key: Key(item),
            onDismissed: (direction) {
              setState(() {
                widget.saved.removeAt(index);
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
            },
            child: ListTile(
              title: Text(widget.saved[index].name),
            ),
          );
        },
      ),
    );
  }
}
