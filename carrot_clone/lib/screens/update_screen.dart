import 'package:carrot_clone/repositories/firebase_repository.dart';
import 'package:carrot_clone/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final String docId;
  final String dong;
  final String cid;
  final String image;
  final String title;
  final String location;
  final String price;
  final String likes;
  const UpdateScreen({
    Key? key,
    required this.cid,
    required this.image,
    required this.title,
    required this.location,
    required this.price,
    required this.likes,
    required this.dong,
    required this.docId,
  }) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String price;
  late TextEditingController _titleController;
  late TextEditingController _priceController;

  late FirebaseRepository _firebaseRepository;

  @override
  void initState() {
    title = widget.title;
    price = widget.price;
    _titleController = new TextEditingController(text: title.toString());
    _priceController = new TextEditingController(text: price.toString());
    _firebaseRepository = FirebaseRepository();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _makeAppBar(),
      body: _makeBody(),
    );
  }

  Widget _makeBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              validator: (value) {
                // trim은 앞뒤 공백을 제거해주는 함수
                if (value!.trim().isEmpty) {
                  return '제목을 입력하세요.';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _priceController,
              validator: (value) {
                // trim은 앞뒤 공백을 제거해주는 함수
                if (value!.trim().isEmpty) {
                  return '가격 설정 안함';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '가격 (선택사항)',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _makeAppBar() {
    return AppBar(
      title: Text(
        '중고거래 글쓰기',
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await _firebaseRepository.updateDoc(
                  widget.dong,
                  widget.docId,
                  _titleController.text.toString(),
                  _priceController.text.toString());

              var count = 0;
              Navigator.popUntil(context, (route) {
                return count++ == 2;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    docId: widget.docId.toString(),
                    dong: widget.dong.toString(),
                    cid: widget.cid.toString(),
                    image: widget.image.toString(),
                    title: _titleController.text.toString(),
                    location: widget.location.toString(),
                    price: _priceController.text.toString(),
                    likes: widget.likes.toString(),
                  ),
                ),
              );
            }
          },
          child: Text(
            '완료',
            style: TextStyle(
              color: Color(0xfff08f4f),
            ),
          ),
        ),
      ],
    );
  }
}
