import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _theme() {
    return ThemeData(
      appBarTheme: _appBarTheme(),
      primaryColor: Colors.white,
      buttonColor: Colors.grey,
      accentColor: Colors.black,
      backgroundColor: Colors.white,
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        subtitle1: TextStyle(
          fontSize: 15,
          color: Colors.black.withOpacity(0.4),
        ),
        subtitle2: TextStyle(
          fontSize: 13,
          color: Colors.black.withOpacity(0.4),
        ),
      ),
    );
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 22,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          fontSize: 15,
          color: Colors.grey,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  ButtonStyle _elevatedButtonForm() {
    return ElevatedButton.styleFrom(
      primary: Colors.white,
      elevation: 0,
      side: BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _theme(),
      home: Scaffold(
        appBar: _makeAppBar(),
        body: _makeBody(context),
      ),
    );
  }

  Widget _makeBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.0),
          Text(
            '나의 키워드',
            style: _theme().textTheme.headline5,
          ),
          SizedBox(height: 10),
          Text(
            '키워드를 추가할 수록 더 정확하게\n루틴을 추천해 드릴 수 있어요.',
            style: _theme().textTheme.subtitle1,
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            '아침형 인간',
                            style: _theme().textTheme.headline5,
                          ),
                          style: _elevatedButtonForm(),
                        ),
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            '독서',
                            style: _theme().textTheme.headline5,
                          ),
                          style: _elevatedButtonForm(),
                        ),
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            '운동',
                            style: _theme().textTheme.headline5,
                          ),
                          style: _elevatedButtonForm(),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('키워드 추가 클릭!');
                  },
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                    color: _theme().buttonColor,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            margin: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              children: [
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '나의 예정 루틴',
                        style: _theme().textTheme.headline6,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('더보기 클릭!');
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                '더보기',
                                style: _theme().textTheme.subtitle1,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: _theme().buttonColor,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 5.0 / 4.0,
                        ),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    minRadius: 45,
                                    backgroundColor: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '김종국',
                                    style: _theme().textTheme.headline6,
                                  ),
                                  Text(
                                    '#운동 #0000',
                                    style: _theme().textTheme.subtitle2,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '19시 ~ 21시',
                                    style: _theme().textTheme.headline6,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _makeAppBar() {
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "7월 12일 월요일",
              style: _appBarTheme().textTheme!.headline5,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "2일차도 ㅇㅇㅇ과 함께해요",
            style: _appBarTheme().textTheme!.headline6,
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            print('캘린더 클릭!');
          },
          icon: Icon(
            Icons.calendar_today_outlined,
            color: _theme().buttonColor,
          ),
        )
      ],
    );
  }
}
