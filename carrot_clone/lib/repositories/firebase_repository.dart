import 'package:carrot_clone/repositories/contents_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseRepository {
  List<Map<String, String>> data = [];
  ContentsRepository contentsRepository = new ContentsRepository();
  CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

// 문서 생성 (Create)
  Future<void> createDoc(String dong, String cid, String image, String title,
      String location, String price) async {
    itemCollection.doc(dong).collection(dong).add({
      "cid": cid,
      "image": image,
      "title": title,
      "location": location,
      "price": price,
      "likes": 0,
    });
  }

// 문서 조회 (Read)
  Future<List<Map<String, String>>> readDocFromLocation(
      String dong, List<DocumentSnapshot> snapshot) async {
    data = [];
    for (int i = 0; i < snapshot.length; i++) {
      Map<String, String> _data = {
        "docId": '${snapshot[i].id}',
        "cid": "${snapshot[i]['cid']}",
        "image": "${snapshot[i]['image']}",
        "title": "${snapshot[i]['title']}",
        "location": "${snapshot[i]['location']}",
        "price": "${snapshot[i]['price']}",
        "likes": "${snapshot[i]['likes']}"
      };
      data.add(_data);
    }
    if (data.isEmpty) {
      throw Exception("Data is Empty");
    }
    return data;
  }

// 문서 갱신 (Update)
  Future<void> updateDoc(
      String dong, String docId, String title, String price) async {
    itemCollection.doc(dong).collection(dong).doc(docId).update({
      'title': title,
      'price': price,
    });
  }

// 문서 삭제 (Delete)
  Future<void> deleteDoc(String dong, String docId) async {
    itemCollection.doc(dong).collection(dong).doc(docId).delete();
  }

  int getDataLength() => data.length;
}
