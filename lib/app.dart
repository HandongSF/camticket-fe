import 'package:camticket/provider/navigation_provider.dart';
import 'package:camticket/provider/pc_provider.dart';
import 'package:camticket/src/pages/performance_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/pages/home_page.dart';
import 'src/splash.dart';
import 'src/nav_page.dart';

class CamTicket extends StatelessWidget {
  const CamTicket({Key? key}) : super(key: key);

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
      ],
      child: MaterialApp(
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
        initialRoute: '/home',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/home': (context) => const HomePage(),
          '/performance': (context) => const PerformancePage(),
          '/start': (context) => const Start(),
        },
      ),
    );
  }
}
