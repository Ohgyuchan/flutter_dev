import 'package:carrot_clone/repositories/firebase_repository.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  final String dong;
  final FirebaseRepository firebaseRepository;
  const AddScreen(
      {Key? key, required this.dong, required this.firebaseRepository})
      : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();

  late FirebaseRepository _firebaseRepository;

  @override
  void initState() {
    _firebaseRepository = widget.firebaseRepository;
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
                hintText: '가격',
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
            print(_firebaseRepository.getDataLengthPlus());
            if (_formKey.currentState!.validate()) {
              _firebaseRepository.createDoc(
                  widget.dong,
                  '${_firebaseRepository.getDataLengthPlus()}',
                  'assets/images/carrot.jpg',
                  _titleController.text.toString(),
                  '제주 제주시 ${widget.dong}',
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
