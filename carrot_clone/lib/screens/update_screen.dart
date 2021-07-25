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
          onPressed: () {
            print(widget.dong);
            print(widget.docId);
            print(_titleController.text.toString());
            print(_priceController.text.toString());
            if (_formKey.currentState!.validate()) {
              _firebaseRepository.updateDoc(
                  widget.dong,
                  widget.docId,
                  _titleController.text.toString(),
                  _priceController.text.toString());
              Navigator.pop(context);
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
