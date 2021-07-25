import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  static String collectionName = 'items';
  static CollectionReference itemCollection =
      FirebaseFirestore.instance.collection(collectionName);

// 문서 생성 (Create)
  static void createDoc(
      String cid, String image, String title, String location, String price) {
    itemCollection.add({
      "cid": cid,
      "image": image,
      "title": title,
      "location": location,
      "price": price,
      "likes": 0,
    });
  }

// 문서 조회 (Read)
  static void showDocument(String docId) {
    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docId)
        .get()
        .then((doc) {
      print("cid: ${doc['cid']}");
      print("title: ${doc['title']}");
      print("location: ${doc['location']}");
      print("price: ${doc['price']}");
      print("likes: ${doc['likes']}");
    });
  }

// 문서 갱신 (Update)
  static void updateDoc(String docId, String title, String image) {
    itemCollection.doc(docId).update({
      'title': title,
      'image': image,
    });
  }

// 문서 삭제 (Delete)
  static void deleteDoc(String docId) {
    itemCollection.doc(docId).delete();
  }
}
