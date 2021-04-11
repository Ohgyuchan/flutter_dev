import 'package:flutter/foundation.dart';

enum Star {
  all,
  one,
  two,
  three,
  four,
  five,
}

class Hotel {
  const Hotel({
    @required this.star,
    @required this.stars,
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.location,
    @required this.desc,
  })  : assert(star != null),
        assert(stars != null),
        assert(id != null),
        assert(name != null),
        assert(phone != null),
        assert(location != null),
        assert(desc != null);

  final Star star;
  final int stars;
  final int id;
  final String name;
  final String phone;
  final String location;
  final String desc;

  String get assetName => 'assets/hotel_images/$id-0.png';

  @override
  String toString() => "$name (id=$id)";


  //String toString() => "$location (id=$id)";
}
