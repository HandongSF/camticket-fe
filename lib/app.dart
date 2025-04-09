import 'package:flutter/material.dart';
import 'src/home.dart'; // 홈 화면을 위한 경로
import 'src/splash.dart';
import 'src/performance.dart';
import 'src/start.dart';

class CamTicket extends StatelessWidget {
  const CamTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // 앱의 전체 테마 설정
        primaryColor: const Color(0xFF9B3BE9),
        scaffoldBackgroundColor: const Color(0xFF1B1B1B),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B1B1B),
          iconTheme: IconThemeData(color: Color(0xFFE5E5EA)),
          titleTextStyle: TextStyle(
            color: Color(0xFFE5E5EA),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF242424),
          selectedItemColor: Color(0xFF9B3BE9),
          unselectedItemColor: Color(0xFF5D5D5D),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const Home(),
        '/performance': (context) => const Performance(),
        '/start': (context) => const Start(),
      },
    );
  }
}