import 'package:camticket/auth/login.dart';
import 'package:camticket/provider/jwt_provider.dart';
import 'package:camticket/provider/navigation_provider.dart';
import 'package:camticket/provider/pc_provider.dart';
import 'package:camticket/provider/performance_provider.dart';
import 'package:camticket/provider/performance_upload_provider.dart';
import 'package:camticket/provider/seat_provider.dart';
import 'package:camticket/provider/selected_performance_provider.dart';
import 'package:camticket/src/pages/performance_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'src/pages/home_page.dart';
import 'src/splash.dart';
import 'src/nav_page.dart';

class CamTicket extends StatelessWidget {
  const CamTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PerformanceCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => JwtProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PerformanceProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SeatProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SelectedPerformanceProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PerformanceUploadProvider(),
        ),
      ],
      child: MaterialApp(
        locale: const Locale('ko'),
        supportedLocales: const [
          Locale('en'), // 영어
          Locale('ko'), // 한국어
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
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
        initialRoute: '/login',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/home': (context) => const HomePage(),
          '/performance': (context) => const PerformancePage(),
          '/start': (context) => const Start(),
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
