import 'package:carrot_clone/repositories/contents_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseRepository {
  List<Map<String, String>> data = [];
  ContentsRepository contentsRepository = new ContentsRepository();
  CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

// 문서 생성 (Create)
  Future<void> createDoc(String dong, String cid, String image, String title,
      String location, String price) async {
    await Firebase.initializeApp();
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
  Future<List<Map<String, String>>> readDoc(
      String dong, List<DocumentSnapshot> snapshot) async {
    print('readDoc');
    for (int i = 0; i < snapshot.length; i++) {
      itemCollection
          .doc(dong)
          .collection(dong)
          .doc(snapshot[i].id)
          .get()
          .then((doc) {
        Map<String, String> _data = {
          "cid": "${doc['cid']}",
          "image": "${doc['image']}",
          "title": "${doc['title']}",
          "location": "${doc['location']}",
          "price": "${doc['price']}",
          "likes": "${doc['likes']}"
        };
        data.add(_data);

        // contentsRepository.addDataList(data);

        print("cid: ${doc['cid']}");
        print("cid: ${doc['image']}");
        print("title: ${doc['title']}");
        print("location: ${doc['location']}");
        print("price: ${doc['price']}");
        print("likes: ${doc['likes']}");
        print('doc');
      });
    }
    if (data.isEmpty) {
      throw Exception("Data is Empty");
    }
    return data;
  }

// 문서 갱신 (Update)
  Future<void> updateDoc(String docId, String title, String image) async {
    itemCollection.doc(docId).update({
      'title': title,
      'image': image,
    });
  }

// 문서 삭제 (Delete)
  Future<void> deleteDoc(String docId) async {
    itemCollection.doc(docId).delete();
  }
}
