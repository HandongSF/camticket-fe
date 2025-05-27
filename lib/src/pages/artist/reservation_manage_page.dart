import 'package:camticket/components/buttons.dart';
import 'package:camticket/src/pages/artist/reservation_detail_page.dart';
import 'package:flutter/material.dart';

import '../../../components/texts.dart';
import '../searchpage.dart';

class ReservationManagePage extends StatefulWidget {
  const ReservationManagePage({super.key});

  @override
  State<ReservationManagePage> createState() => _ReservationManagePageState();
}

class _ReservationManagePageState extends State<ReservationManagePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Image.asset(
                      'assets/images/navi logo.png',
                      width: 110,
                      height: 28,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Searchpage()),
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 24,
                      ),
                    )
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(2.0),
                child: Container(
                  height: 1.0,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0x001B1B1B), // 완전 투명한 검정 (왼쪽)
                        Color(0xFF828282), // 중간 회색 (중앙이 밝음)
                        Color(0x001B1B1B), // 완전 투명한 검정 (오른쪽)
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[],
              toolbarHeight: 64,
              backgroundColor: Colors.black,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        white28('관람객 예매 확인 및 관리'),
                        const SizedBox(height: 16),
                        white16('진행중인 공연'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // 공연 예약 관리 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ReservationDetailPage()),
                      );
                    },
                    child: Image.asset(
                      'assets/images/pitch_stage.png',
                      width: MediaQuery.of(context).size.width / 3,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // 여기에 예약 관리 관련 위젯 추가
                ],
              ),
            )));
  }
}
