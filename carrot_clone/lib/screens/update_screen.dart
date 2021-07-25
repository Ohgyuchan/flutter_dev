import 'package:carrot_clone/repositories/firebase_repository.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final String dong;
  final String title;
  final String price;
  final String docId;
  const UpdateScreen(
      {Key? key,
      required this.title,
      required this.price,
      required this.dong,
      required this.docId})
      : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();

  late FirebaseRepository _firebaseRepository;

  @override
  void initState() {
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
                hintText: '제목',
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
        GestureDetector(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              _firebaseRepository.updateDoc(
                  widget.dong, widget.docId, widget.title, widget.price);
              Navigator.pop(context);
            }
          },
          child: Container(
            width: 100,
            child: Center(
              child: Text(
                '완료',
                style: TextStyle(
                  color: Color(0xfff08f4f),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
