import 'package:camticket/components/buttons.dart';
import 'package:camticket/components/dividers.dart';
import 'package:camticket/provider/reservation_provider.dart';
import 'package:camticket/src/pages/artist/reservation_detail2_page.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../searchpage.dart';

class ReservationDetailPage extends StatefulWidget {
  final int postId;
  const ReservationDetailPage({super.key, required this.postId});

  @override
  State<ReservationDetailPage> createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReservationProvider>(context, listen: false)
          .fetchReservationList(widget.postId);
    });
  }

  String _mapStatus(String status) {
    switch (status) {
      case 'PENDING':
        return '예매 진행중';
      case 'CONFIRMED':
        return '예매 확정';
      case 'REFUND_REQUESTED':
        return '환불 요청';
      case 'REFUNDED':
        return '취소 완료';
      default:
        return status;
    }
  }

  String _timeAgo(DateTime date) {
    final difference = DateTime.now().difference(date);
    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else {
      return '${difference.inMinutes}분 전';
    }
  }

  int selectedHall = 1;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservationProvider>(context, listen: true);
    final reservation = provider.reservationList;
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
                  children: reservation
                      .map((res) => GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ReservationDetail2Page())),
                            child: _buildTicketCard(
                              status: _mapStatus(res.status),
                              name: res.userNickName,
                              seats: res.selectedSeats.join(', '),
                              count: res.count,
                              timeAgo: _timeAgo(res.regDate),
                              isConfirmed: res.status == 'CONFIRMED',
                              isRefunded: res.status == 'REFUNDED',
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
