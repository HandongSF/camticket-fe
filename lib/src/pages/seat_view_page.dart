import 'package:camticket/components/seat.dart';
import 'package:camticket/src/pages/searchpage.dart';
import 'package:flutter/material.dart';

import '../../components/buttons.dart';

class SeatViewPage extends StatelessWidget {
  final List<String> selectedSeats;

  SeatViewPage({required this.selectedSeats});
  final Set<String> _disabledSeats = {
    'A1',
    'A2',
    'A3',
    'A4',
    'A5',
    'A6',
    'A7',
    'A8',
    'A9',
    'A10',
    'A11',
    'A12',
    'C3',
    'C4'
  };
  final Set<String> _reservedSeats = {'B3', 'D4', 'E10', 'E11'};
  final int maxSelectableSeats = 4;
  final int alreadySelectedSeats = 2;
  final Set<String> _selectedSeats = {};
  final double seatSize = 26;
  final double seatSpacing = 2;
  final double aisleSpacing = 10;
  Map<String, List<int>> generateSeatMap() {
    Map<String, List<int>> seatMap = {};
    for (int i = 0; i < 12; i++) {
      String row = String.fromCharCode('A'.codeUnitAt(0) + i);
      if (row == 'L') {
        seatMap[row] = List.generate(6, (index) => index + 4); // 4~9
      } else {
        seatMap[row] = List.generate(12, (index) => index + 1); // 1~12
      }
    }
    return seatMap;
  }

  @override
  Widget build(BuildContext context) {
    final seatMap = generateSeatMap();
    return Scaffold(
      backgroundColor: Colors.black,
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
                    MaterialPageRoute(builder: (context) => const Searchpage()),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            white28('좌석위치보기'),
            SizedBox(height: 16),
            SeatStageSection(),
            SizedBox(height: 10),
            SeatMapWidget(
              seatMap: seatMap,
              seatSize: 26,
              seatSpacing: seatSpacing,
              aisleSpacing: aisleSpacing,
              selectedSeats: _selectedSeats,
              disabledSeats: _disabledSeats,
              reservedSeats: _reservedSeats,
              maxSelectableSeats: maxSelectableSeats,
              alreadySelectedSeats: alreadySelectedSeats,
              onSeatTapped: (seatId) {
                // 선택/취소 로직 처리
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    // 예매하기 버튼 클릭 시 처리 로직
                    // 예를 들어, 선택된 좌석 정보를 서버에 전송하거나 다음 페이지로 이동
                    Navigator.pop(context, selectedSeats);
                  },
                  child: mainPurpleBtn(
                    '확인',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
