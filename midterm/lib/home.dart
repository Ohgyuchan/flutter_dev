import 'package:Shrine/detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'model/hotels_repository.dart';
import 'model/model_hotel.dart';

const _url = 'https://www.handong.edu';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _isGridView = <bool>[false, true];
  final List<Hotel> products = HotelRepository.loadHotels(Star.all);

  List<Card> _buildGridCards(BuildContext context) {
    if (products == null || products.isEmpty) {
      return const <Card>[];
    }
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.asMap().entries.map((product) {
      int index = product.key;
      Hotel hotel = product.value;
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(hotel.assetName, fit: BoxFit.fitWidth),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        for (int i = 0; i < hotel.stars; i++)
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15.0,
                          ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      hotel.name,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.blue, size: 12.0),
                        Flexible(
                          child: Container(
                            child: Text(
                              hotel.location,
                              style: TextStyle(
                                fontSize: 7.0,
                              ),
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          print(index);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  hotel: hotel,
                                )),
                          );
                        },
                        child: Text(
                          'more',
                          style: TextStyle(
                              color: Colors.lightBlueAccent, fontSize: 10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Card> _buildListCards(BuildContext context) {
    if (products == null || products.isEmpty) {
      return const <Card>[];
    }
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.asMap().entries.map((product) {
      int index = product.key;
      Hotel hotel = product.value;
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.asset(hotel.assetName, fit: BoxFit.scaleDown),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        for (int i = 0; i < hotel.stars; i++)
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15.0,
                          ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      hotel.name,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.blue, size: 15.0),
                        Flexible(
                          child: Container(
                            child: Text(
                              hotel.location,
                              style: TextStyle(
                                fontSize: 7.0,
                              ),
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          print(index);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      hotel: hotel,
                                    )),
                          );
                        },
                        child: Text(
                          'more',
                          style: TextStyle(
                              color: Colors.lightBlueAccent, fontSize: 10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          //padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.fromLTRB(30, 100, 100, 20),
              child: Text('Pages',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.normal)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              title: Text('Search'),
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.location_city,
                color: Colors.blue,
              ),
              title: Text('Favorite Hotel'),
              onTap: () {
                Navigator.pushNamed(context, '/favorite');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.blue,
              ),
              title: Text('My Page'),
              onTap: () {
                Navigator.pushNamed(context, '/mypage');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Main'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              semanticLabel: 'language',
            ),
            onPressed: _launchURL,
          ),
        ],
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.fromLTRB(0.0, 8.0, 16.0, 0.0),
            child: ToggleButtons(
              children: <Widget>[
                Icon(Icons.list),
                Icon(Icons.grid_view),
              ],
              isSelected: _isGridView,
              onPressed: (int index) {
                setState(() {
                  index == 0 ? _isGridView[1] = false : _isGridView[0] = false;
                  _isGridView[index] = true;
                });
              },
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              crossAxisCount: _isGridView[0]
                  ? 1
                  : (orientation == Orientation.portrait ? 2 : 3),
              childAspectRatio: _isGridView[0] ? 3.0 / 1.0 : 8.0 / 9.0,
              children: _isGridView[1] == true
                  ? _buildGridCards(context)
                  : _buildListCards(context),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
/*
GridView.count(
crossAxisCount: 2,
padding: EdgeInsets.all(16.0),
childAspectRatio: 8.0 / 9.0,
// TODO: Build a grid of cards (102)
children: _buildGridCards(context)
),
// TODO: Set resizeToAvoidBottomInset (101)
resizeToAvoidBottomInset: false,

ToggleButtons(
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.cake),
                ],
                isSelected: _isGridView,
                onPressed: (int index) {
                  setState(() {
                    index == 0 ? _isGridView[1] = false : _isGridView[0] = false;
                    _isGridView[index] = true;
                  }
                  );
                },
              ),
 */
