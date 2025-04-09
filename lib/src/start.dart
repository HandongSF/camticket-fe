import 'package:flutter/material.dart';
import 'home.dart';
import 'performance.dart';
class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  int selectedPage = 0;
  final _pageOptions = [
    Home(),
    Performance(),
    Text('test'),
    Text('test2')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Image.asset(
              'assets/images/navi logo.png',
              width: 110,
              height: 28,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              thickness: 1.0,
              color: Colors.white, // Divider 색상
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed:(){

              },
              icon: Icon(
                Icons.search,
                size: 24,
              ),
            )
          ],
          toolbarHeight: 64,
        ),
        body: _pageOptions[selectedPage],
        bottomNavigationBar: Container(
          height: 82,
          child: BottomNavigationBar(
            iconSize: 24,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedPage,
            onTap: (index){
              setState(() {
                selectedPage = index;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),  // 홈 아이콘
                label: '홈',  // 텍스트 (필요에 따라 변경)
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.festival),  // 공연 아이콘
                label: '공연',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),  // 아티스트 아이콘
                label: '아티스트',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),  // 마이페이지 아이콘
                label: '마이',
              ),
            ],
          ),
        )
    );
  }
}
