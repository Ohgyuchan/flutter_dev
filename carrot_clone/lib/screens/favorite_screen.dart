import 'package:carrot_clone/repositories/contents_repository.dart';
import 'package:carrot_clone/screens/detail_screen.dart';
import 'package:carrot_clone/utils/data_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({Key? key}) : super(key: key);

  @override
  _MyFavoriteScreenState createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  late ContentsRepository contentsRepository;

  @override
  void initState() {
    contentsRepository = ContentsRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      elevation: 1,
      title: Text(
        "관심목록",
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadMyFavoriteContentsList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          if (snapshot.error.toString() == "Exception: Data is Null") {
            return Center(
              child: Text('해당 데이터가 없습니다.'),
            );
          }
          return Center(
            child: Text('데이터 오류'),
          );
        } else if (snapshot.hasData) {
          return snapshot.data.toString() == '[]'
              ? Center(child: Text('해당 데이터가 없습니다.'))
              : _makeDataList(snapshot.data as List<dynamic>);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<dynamic> _loadMyFavoriteContentsList() async {
    return await contentsRepository.loadMyFavoriteContents();
  }

  _makeDataList(List<dynamic> data) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext _context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                          docId: 'docId',
                          dong: 'dong',
                          cid: "${data[index]['cid']}",
                          image: "${data[index]['image']}",
                          title: "${data[index]['title']}",
                          location: "${data[index]['location']}",
                          price: "${data[index]['price']}",
                          likes: "${data[index]['likes']}",
                        )));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: 100,
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
