import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAppPage();
  }

  // 3초 후에 FixBar 페이지로 이동
  Future<void> _navigateToAppPage() async {
    await Future.delayed(const Duration(seconds: 3));
    // 3초 후 FixBar 페이지로 이동
    Navigator.pushReplacementNamed(context, '/start');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B), // 배경색 설정
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo + text.png', // 로딩 화면에 표시할 이미지
              width: 75, // 이미지 크기
              height: 89,
            ),
          ],
        ),
      ),
    );
  }
}