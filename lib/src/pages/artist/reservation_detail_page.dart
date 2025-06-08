import 'package:camticket/components/buttons.dart';
import 'package:camticket/components/dividers.dart';
import 'package:camticket/provider/reservation_provider.dart';
import 'package:camticket/src/pages/artist/reservation_detail2_page.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/performanceDetail.dart';
import '../../../provider/performance_provider.dart';
import '../../../utility/api_service.dart';
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
      Provider.of<PerformanceProvider>(context, listen: false)
          .fetchPerformanceDetail(widget.postId);
    });
  }

  String _mapStatus(String status) {
    switch (status) {
      case 'PENDING':
        return '예매 진행중';
      case 'APPROVED':
        return '예매 확정';
      case 'REFUND_REQUESTED':
        return '환불 요청';
      case 'REFUNDED':
        return '취소 완료';
      case 'REJECTED':
        return '예매 거절';
      default:
        return status;
    }
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 0) return '${diff.inDays}일 전';
    if (diff.inHours > 0) return '${diff.inHours}시간 전';
    return '${diff.inMinutes}분 전';
  }

  Future<void> showApproveDialog(
      BuildContext context, String userName, int reservationId) async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.gray1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text(
            '예매 확정',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.25,
              letterSpacing: 0.10,
            ),
          ),
          content: Text('$userName님의 예매를 확정하시겠습니까?',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.25,
                letterSpacing: 0.10,
              )),
          actions: [
            TextButton(
              child: const Text('확정', style: TextStyle(color: Colors.blue)),
              onPressed: () => Navigator.of(context).pop(true),
            ),
            TextButton(
              child: const Text('취소', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        );
      },
    );

    if (isConfirmed == true) {
      // PATCH: APPROVED
      final result =
          await ApiService().updateReservationStatus(reservationId, 'APPROVED');
      result
          ? showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.gray1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  title: const Text(
                    '예매 확정 완료',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      letterSpacing: 0.10,
                    ),
                  ),
                  content: const Text('정상적으로 예매가 확정되었습니다.',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.25,
                        letterSpacing: 0.10,
                      )),
                  actions: [
                    TextButton(
                      child: const Text('확인',
                          style: TextStyle(
                            color: AppColors.subPurple,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.28,
                          )),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Provider.of<ReservationProvider>(context, listen: false)
                            .fetchReservationList(widget.postId);
                      },
                    ),
                  ],
                );
              },
            )
          : showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text('예매 확정 실패',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  content: const Text('오류가 발생했습니다.'),
                  actions: [
                    TextButton(
                      child: const Text('확인',
                          style: TextStyle(color: Color(0xFF6F3ADA))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              },
            );
    }
  }

  Future<void> showRejectDialog(
      BuildContext context, String userName, int reservationId) async {
    final isCancel = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.gray1,
          title: const Text(
            '예매 취소',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.25,
              letterSpacing: 0.10,
            ),
          ),
          content: Text('$userName님의 예매를 취소하시겠습니까?',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.25,
                letterSpacing: 0.10,
              )),
          actions: [
            TextButton(
              child: const Text('예', style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.of(context).pop(true),
            ),
            TextButton(
              child: const Text('아니요', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        );
      },
    );

    if (isCancel == true) {
      // PATCH: REJECTED
      final result = await ApiService().deleteReservation(reservationId);
      result
          ? showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.gray1,
                  title: const Text(
                    '예매 취소 완료',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      letterSpacing: 0.10,
                    ),
                  ),
                  content: const Text('정상적으로 예매가 취소되었습니다.',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.25,
                        letterSpacing: 0.10,
                      )),
                  actions: [
                    TextButton(
                      child: const Text('확인',
                          style: TextStyle(
                            color: AppColors.subPurple,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.28,
                          )),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Provider.of<ReservationProvider>(context, listen: false)
                            .fetchReservationList(widget.postId);
                      },
                    ),
                  ],
                );
              },
            )
          : showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text('예매 취소 실패',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
                  content: const Text('예매 취소가 '),
                  actions: [
                    TextButton(
                      child: const Text('확인',
                          style: TextStyle(color: Color(0xFF6F3ADA))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              },
            );
    }
  }

  int selectedHall = 1;
  @override
  Widget build(BuildContext context) {
    final reservationProv = context.watch<ReservationProvider>();
    final perfProv = context.watch<PerformanceProvider>();

    final provider = Provider.of<ReservationProvider>(context, listen: true);
    final reservation = provider.reservationList;
    final detailProvider =
        Provider.of<PerformanceProvider>(context, listen: true);
    final detail = detailProvider.performanceDetails;

    if (reservationProv.isLoading ||
        perfProv.isLoading ||
        perfProv.performanceDetails == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (reservationProv.error != null || perfProv.error != null) {
      final msg = reservationProv.error ?? perfProv.error!;
      return Scaffold(
        backgroundColor: Colors.black,
        body:
            Center(child: Text(msg, style: const TextStyle(color: Colors.red))),
      );
    }
    final perf = perfProv.performanceDetails!; // non-null 확정
    final reservations = reservationProv.reservationList; // List<Reservation>

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                white28(perf.title),
                SizedBox(height: 20),
                if (detail != null)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        detail.schedules.length,
                        (idx) {
                          final schedule = detail.schedules[idx];
                          // 버튼 사이에만 간격 넣기 (마지막 버튼엔 X)
                          return Row(
                            children: [
                              _buildHallButton(
                                  idx + 1, '${schedule.scheduleIndex + 1}공'),
                              if (idx != detail.schedules.length - 1)
                                const SizedBox(width: 10),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                _dropdownField('관람객 전체'),
                const SizedBox(height: 8),
                _buildSearchField(),
                const SizedBox(height: 32),
                dividerGray2(),
                const SizedBox(height: 32),
                if (detail != null)
                  Column(
                    children: reservation
                        .where((res) => res.status == "PENDING") // ★ 이 줄 추가!
                        .map((res) => _buildTicketCard(
                            status: _mapStatus(res.status),
                            name: res.userNickName,
                            seats: res.selectedSeats.join(', '),
                            count: res.count,
                            timeAgo: _timeAgo(res.regDate),
                            isConfirmed: res.status == 'CONFIRMED',
                            isRefunded: res.status == 'REFUNDED',
                            detail: detail,
                            reservationId: res.reservationId))
                        .toList(),
                  )
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
            overflow: TextOverflow.ellipsis,
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

  Widget _buildTicketCard(
      {required String status,
      required String name,
      required String seats,
      required int count,
      required String timeAgo,
      required bool isConfirmed,
      required bool isRefunded,
      required PerformanceDetail detail,
      required int reservationId}) {
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservationDetail2Page(
                            title: detail.title,
                            round: '$selectedHall', // 예시
                            seats: seats, // 예: "학관 104호 F8, F9, F10 (총 3좌석)"
                            userName: name,
                            userBankAccount: '',
                            reservationId: reservationId),
                      ),
                    );
                  },
                  child: SizedBox(
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
                    children: [
                      GestureDetector(
                          onTap: () {
                            showApproveDialog(context, name, reservationId);
                          },
                          child: Text('예매 확정',
                              style: TextStyle(color: Color(0xFF3774F7)))),
                      SizedBox(width: 16),
                      GestureDetector(
                          onTap: () {
                            showRejectDialog(context, name, reservationId);
                          },
                          child: Text('예매 취소',
                              style: TextStyle(color: Color(0xFFCE3939)))),
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
