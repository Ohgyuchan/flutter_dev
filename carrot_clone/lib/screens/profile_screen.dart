import 'package:carrot_clone/screens/favorite_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          '나의 당근',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        children: [
          _makeMyInfo(context),
          Divider(
            height: 5.0,
            thickness: 5.0,
          ),
          _makeAppSettings(),
          Divider(
            height: 5.0,
            thickness: 5.0,
          ),
          _makeVillageInfo(),
          Divider(
            height: 5.0,
            thickness: 5.0,
          ),
          _makeAdInfo(),
          Divider(
            height: 5.0,
            thickness: 5.0,
          ),
          _makeBoard(),
        ],
      ),
    );
  }

  Widget _makeIconWithText(Icon iconName, String title) {
    return Row(
      children: [
        iconName,
        SizedBox(
          width: 15,
        ),
        Text(title),
      ],
    );
  }

  Widget _makeAppSettings() {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _makeIconWithText(Icon(Icons.room), '내 동네 설정'),
          _makeIconWithText(Icon(Icons.gps_not_fixed), '동네 인증하기'),
          _makeIconWithText(Icon(Icons.local_offer), '키워드 알림'),
          _makeIconWithText(Icon(Icons.grid_view), '모아보기'),
          _makeIconWithText(Icon(Icons.tune), '관심 카테고리 설정'),
        ],
      ),
    );
  }

  Widget _makeVillageInfo() {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _makeIconWithText(Icon(Icons.app_registration_outlined), '동네생활 글'),
          _makeIconWithText(Icon(Icons.maps_ugc_outlined), '동네생활 글'),
          _makeIconWithText(Icon(Icons.star_outlined), '동네생활 주제 목록'),
        ],
      ),
    );
  }

  Widget _makeAdInfo() {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _makeIconWithText(Icon(Icons.storefront_outlined), '비즈프로필 만들기'),
          _makeIconWithText(Icon(Icons.article_outlined), '동네홍보 글'),
          _makeIconWithText(Icon(Icons.campaign_outlined), '지역광고'),
        ],
      ),
    );
  }

  Widget _makeBoard() {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _makeIconWithText(Icon(Icons.mail_outlined), '친구초대'),
          _makeIconWithText(Icon(Icons.share_outlined), '당근마켓 공유'),
          _makeIconWithText(Icon(Icons.mic_none), '공지사항'),
          _makeIconWithText(Icon(Icons.support_agent), '자주 묻는 질문'),
          _makeIconWithText(Icon(Icons.settings_outlined), '앱 설'),
        ],
      ),
    );
  }

  Widget _makeMyInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 10.0,
      ),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _makeProfileCircle(),
              Container(
                padding: const EdgeInsetsDirectional.only(start: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '오규찬',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '양덕동#12345',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      '프로필 보기',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey,
                    ),
                    Text('판매내역'),
                  ],
                ),
              ),
              GestureDetector(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey,
                    ),
                    Text('구매내역'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => MyFavoriteScreen()));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey,
                    ),
                    Text('관심목록'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _makeProfileCircle() {
    return Container(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            decoration: new BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: Image.asset("assets/images/user.png").image,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: new BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
