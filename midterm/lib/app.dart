import 'package:flutter/material.dart';
import 'model/model_hotel.dart';
import 'home.dart';
import 'login.dart';
import 'favorite.dart';
import 'search.dart';
import 'mypage.dart';

class ShrineApp extends StatelessWidget {
  List<Hotel> saved = List<Hotel>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      home: HomePage(saved: saved,),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(saved: saved),
        '/favorite': (context) => FavoritePage(saved: saved),
        '/search': (context) => SearchPage(),
        '/mypage': (context) => MyPage(saved: saved),
      },
      // TODO: Add a theme (103)
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}
