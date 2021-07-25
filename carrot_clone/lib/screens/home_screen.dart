import 'package:carrot_clone/repositories/firebase_repository.dart';
import 'package:carrot_clone/screens/add_screen.dart';
import 'package:carrot_clone/screens/detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carrot_clone/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _currentLocation;
  late FirebaseRepository _firebaseRepository;
  final Map<String, String> locationTypeToString = {
    'ara': '아라동',
    'ora': '오라동',
    'donam': '도남동',
  };

  @override
  void initState() {
    super.initState();
    _currentLocation = 'ara';
    _firebaseRepository = FirebaseRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _makeFAB(),
    );
  }

  FloatingActionButton _makeFAB() {
    return FloatingActionButton(
      backgroundColor: Color(0xfff08f4f),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddScreen(
              firebaseRepository: _firebaseRepository,
              dong: locationTypeToString[_currentLocation].toString(),
            ),
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      elevation: 1,
      title: PopupMenuButton<String>(
        offset: Offset(0, 30),
        shape: ShapeBorder.lerp(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            1),
        onSelected: (String where) {
          print(where);
          setState(() {
            _currentLocation = where;
          });
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: "ara",
              child: Text('아라동'),
            ),
            PopupMenuDivider(
              height: 1.0,
            ),
            PopupMenuItem(
              value: "ora",
              child: Text('오라동'),
            ),
            PopupMenuDivider(
              height: 1.0,
            ),
            PopupMenuItem(
              value: "donam",
              child: Text('도남동'),
            ),
          ];
        },
        child: Row(
          children: [
            Text(
              "${locationTypeToString[_currentLocation]}",
            ),
            Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.tune),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/svg/bell.svg',
            width: 22,
          ),
        ),
      ],
    );
  }

  Widget _bodyWidget() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseRepository.itemCollection
          .doc('${locationTypeToString[_currentLocation]}')
          .collection('${locationTypeToString[_currentLocation]}')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _bodyBuilder(snapshot.data!.docs);
      },
    );
  }

  Widget _bodyBuilder(List<DocumentSnapshot> snapshot) {
    return FutureBuilder(
      future:
          _firebaseRepository.readDocFromLocation(_currentLocation, snapshot),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          if (snapshot.error.toString() == "Exception: Data is Empty") {
            return Center(
              child: Text('해당 지역에 데이터가 없습니다.'),
            );
          }
          return Center(
            child: Text('데이터 오류'),
          );
        } else if (snapshot.hasData) {
          return _makeDataList(snapshot.data as List<Map<String, String>>);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _makeDataList(List<Map<String, String>> data) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext _context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  docId: data[index]['docId'].toString(),
                  dong: locationTypeToString[_currentLocation].toString(),
                  cid: "${data[index]['cid']}",
                  image: "${data[index]['image']}",
                  title: "${data[index]['title']}",
                  location: "${data[index]['location']}",
                  price: "${data[index]['price']}",
                  likes: "${data[index]['likes']}",
                ),
              ),
            );
            print('title: ' + '${data[index]['title']}');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.transparent,
            height: 110,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular((10)),
                  ),
                  child: Hero(
                    tag: "${data[index]["cid"]}",
                    child: Image.asset(
                      "${data[index]["image"]}",
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data[index]["title"]}",
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${data[index]["location"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          DataUtils.calcStringToWon(
                              data[index]["price"].toString()),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/heart_off.svg",
                                height: 13,
                                width: 13,
                              ),
                              SizedBox(width: 5),
                              Text("${data[index]["likes"]}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext _context, int index) {
        return Container(
          height: 1,
          color: Colors.black.withOpacity(0.4),
        );
      },
      itemCount: data.length,
    );
  }
}
