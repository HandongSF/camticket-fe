import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // PageController 정의
  final PageController _pageController = PageController();
  int _currentPage = 0; // 현재 페이지 인덱스 초기값

  // PageView 슬라이드가 변경될 때마다 호출되는 메서드

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: 514,
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 16, left: 14, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '홈',
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 360,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 254,
                                height: 360,
                                color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    'Page 1',
                                    style: TextStyle(color: Colors.white, fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 254,
                                height: 360,
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    'Page 2',
                                    style: TextStyle(color: Colors.white, fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}
