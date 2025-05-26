import 'package:camticket/components/buttons.dart';
import 'package:camticket/components/dividers.dart';
import 'package:camticket/src/pages/artist/reservation_detail2_page.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';

import '../searchpage.dart';

class ReservationDetailPage extends StatefulWidget {
  const ReservationDetailPage({super.key});

  @override
  State<ReservationDetailPage> createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  int selectedHall = 1;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 12),
              white28('🎼 The Gospel : Who we are'),
              SizedBox(height: 20),
              Row(
                children: [
                  _buildHallButton(1, '1공'),
                  const SizedBox(width: 10),
                  _buildHallButton(2, '2공'),
                ],
              ),
              const SizedBox(height: 16),
              _dropdownField('관람객 전체'),
              const SizedBox(height: 8),
              _buildSearchField(),
              const SizedBox(height: 32),
              dividerGray2(),
              const SizedBox(height: 32),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // 공연 예약 관리 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReservationDetail2Page()),
                      );
                    },
                    child: _buildTicketCard(
                      status: '예매 진행중',
                      name: '임승범',
                      seats: 'H10, H11',
                      count: 2,
                      timeAgo: '30분 전',
                      isConfirmed: false,
                      isRefunded: false,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // 공연 예약 관리 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReservationDetail2Page()),
                      );
                    },
                    child: _buildTicketCard(
                      status: '환불 요청',
                      name: '오세훈',
                      seats: 'E1',
                      count: 1,
                      timeAgo: '5시간 전',
                      isConfirmed: false,
                      isRefunded: true,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // 공연 예약 관리 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReservationDetail2Page()),
                      );
                    },
                    child: _buildTicketCard(
                      status: '예매 진행중',
                      name: '박조이',
                      seats: 'F8, F9, F10',
                      count: 3,
                      timeAgo: '1일 전',
                      isConfirmed: false,
                      isRefunded: false,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // 공연 예약 관리 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReservationDetail2Page()),
                      );
                    },
                    child: _buildTicketCard(
                      status: '예매 확정',
                      name: '이동은',
                      seats: 'J3',
                      count: 1,
                      timeAgo: '2일 전',
                      isConfirmed: true,
                      isRefunded: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildHallButton(int hall, String label) {
    final isSelected = selectedHall == hall;
    return GestureDetector(
      onTap: () => setState(() => selectedHall = hall),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.subPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.gray3),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.mainPurple : AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropdownField(String hint) => DropdownButtonFormField<String>(
        dropdownColor: const Color(0xFF3D3D3D),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.gray1,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.gray2,
              )),
        ),
        hint: Text(hint, style: const TextStyle(color: AppColors.gray5)),
        items: ['관람객 전체', '예매 진행중', '예매 확정', '환불 요청', '취소 완료']
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: const TextStyle(color: Colors.white))))
            .toList(),
        onChanged: (_) {},
      );

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: '관람객 이름을 검색하세요.',
        hintStyle: const TextStyle(color: AppColors.gray3),
        suffixIcon: const Icon(Icons.search, color: AppColors.gray3),
        filled: true,
        fillColor: AppColors.gray1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.gray2,
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard({
    required String status,
    required String name,
    required String seats,
    required int count,
    required String timeAgo,
    required bool isConfirmed,
    required bool isRefunded,
  }) {
    Color statusColor =
        status.contains('환불') ? Color(0xFFCE3939) : AppColors.subPurple;

    return Card(
      color: AppColors.gray1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: statusColor),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      const Text('예매 상세정보 →',
                          style: TextStyle(
                            color: AppColors.gray4,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.24,
                          )),
                      Divider(color: AppColors.gray4),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$name ',
                    style: TextStyle(
                      color: AppColors.gray5,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.40,
                    ),
                  ),
                  TextSpan(
                    text: '님',
                    style: TextStyle(
                      color: AppColors.gray5,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.40,
                    ),
                  ),
                ],
              ),
            ),
            Text('$seats (총 $count좌석)',
                style: const TextStyle(
                  color: AppColors.gray5,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.28,
                )),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(timeAgo,
                    style: const TextStyle(
                      color: AppColors.gray4,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.24,
                    )),
                if (isRefunded)
                  const Text('환불 완료',
                      style: TextStyle(color: Color(0xFFCE3939)))
                else if (isConfirmed)
                  const Text('예매 확정',
                      style: TextStyle(color: Color(0xFF3774F7)))
                else
                  Row(
                    children: const [
                      Text('예매 확정', style: TextStyle(color: Color(0xFF3774F7))),
                      SizedBox(width: 16),
                      Text('예매 취소', style: TextStyle(color: Color(0xFFCE3939))),
                    ],
                  )
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
