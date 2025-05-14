import 'package:camticket/src/pages/performance_seat_reservation.dart';
import 'package:flutter/material.dart';
import '../../utility/color.dart';
import 'package:camticket/src/pages/performance_detail_page.dart';

class PerformanceDetailPage extends StatefulWidget {
  const PerformanceDetailPage({super.key});

  @override
  State<PerformanceDetailPage> createState() => _PerformanceDetailPageState();
}

class _PerformanceDetailPageState extends State<PerformanceDetailPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.mainBlack,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const Text('공연 정보', style: TextStyle(color: AppColors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            width: 412,
            height: 240,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.50, 1.00),
                end: Alignment(0.50, 0.00),
                colors: [
                  const Color(0xFF1B1B1B),
                  const Color(0x00818181),
                ],
              ),
              image: const DecorationImage(
                image: AssetImage('assets/Home/Pagination.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.zero,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              initialChildSize: 0.72,
              minChildSize: 0.72,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: AppColors.mainBlack,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          width: 160,
                          height: 228,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/Home/Pagination.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 192,
                        child: Container(
                          width: 47,
                          height: 14,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFFE4C3FF),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '유료 공연',
                              style: TextStyle(
                                color: Color(0xFFE4C3FF),
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                height: 1.25,
                                letterSpacing: -0.16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 38,
                        left: 192,
                        child: const SizedBox(
                          width: 200,
                          child: Text(
                            '🎼 The Gospel \n    : Who we are',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 101,
                        left: 192,
                        child: _buildPerformanceColumn('카테고리', '예매 기간', '공연날짜', '장소'),
                      ),
                      Positioned(
                        top: 101,
                        left: 251,
                        child: _buildPerformanceInfoColumn('뮤지컬', '11/18~11/21 목', '25.11.23(2회)', '학관 104호'),
                      ),

                      // 탭 영역
                      Positioned(
                        top: 288,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(color: AppColors.mainBlack),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 60,
                                decoration: const BoxDecoration(color: Color(0xFF1B1B1B)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 20,
                                      top: 20,
                                      child: _buildTabItem("상세정보", 0),
                                    ),
                                    Positioned(
                                      left: 119,
                                      top: 20,
                                      child: _buildTabItem("예매안내", 1),
                                    ),
                                    Positioned(
                                      left: 218,
                                      top: 20,
                                      child: _buildTabItem("공연장정보", 2),
                                    ),
                                    if (_selectedTabIndex == 0)
                                      const Positioned(left: 31, bottom: 0, child: _TabUnderline()),
                                    if (_selectedTabIndex == 1)
                                      const Positioned(left: 133, bottom: 0, child: _TabUnderline()),
                                    if (_selectedTabIndex == 2)
                                      const Positioned(left: 238, bottom: 0, child: _TabUnderline()),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 300,
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: _buildTabContent(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // 예매 버튼
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: SizedBox(
              width: 372,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainPurple,
                ),
                onPressed: () {
                  final now = DateTime.now();
                  final eventDate = DateTime(2026, 05, 11, 00); // 예: 1공 공연 시작 시간

                  if (now.isAfter(eventDate)) {
                    // 공연 시간이 지난 경우
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('예매가 종료된 공연입니다.'),
                        backgroundColor:  const Color(0xFFCE3939),
                        duration: const Duration(seconds: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  } else {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius
                            .circular(20)),
                      ),
                      builder: (BuildContext context) {
                        return _ReservationModal();
                      },
                    );
                  }
                },

                child: const Text(
                  '예매하기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Text(
        label,
        style: TextStyle(
          color: _selectedTabIndex == index ? AppColors.mainPurple : AppColors.gray4,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('공연 소개', style: TextStyle(color: Color(0xFFE4C3FF), fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              '이 공연은 현대 복음 음악과 연극이 결합된 창작 뮤지컬입니다. 각기 다른 사연을 가진 인물들이 음악을 통해 치유받는 여정을 그립니다.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Divider(
              color: AppColors.gray4,   // 선 색상
              thickness: 0.5,         // 선 두께
            ),
            SizedBox(height: 20),
            Text('가격정보', style: TextStyle(color: Color(0xFFE4C3FF), fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('모든 관람객 3,000원\n새내기일 경우 1,000원 할인하여 2,000원! (현장 학생증 지참)', style: TextStyle(color: Colors.white)),
            SizedBox(height: 20),
            Divider(
              color: AppColors.gray4,   // 선 색상
              thickness: 0.5,         // 선 두께
            ),
            SizedBox(height: 20),
            Text('예매 공지사항', style: TextStyle(color: Color(0xFFE4C3FF), fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('11/18 월요일 오후 2시 - 5시 오프라인 티켓 예매 가능합니다.\n1인 4매까지 예매 가능합니다.', style: TextStyle(color: Colors.white)),
            SizedBox(height: 20),
            Divider(
              color: AppColors.gray4,   // 선 색상
              thickness: 0.5,         // 선 두께
            ),
            SizedBox(height: 20),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('티켓 수령 방법 안내', style: TextStyle(color: Color(0xFFE4C3FF), fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '티켓은 앱을 통해 온라인으로 수령하실 수 있습니다.\n앱 하단 메뉴의 ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                  ),
                  TextSpan(
                    text: '‘마이 → 티켓 보기’',
                    style: TextStyle(
                      color: const Color(0xFFE4C3FF),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                  ),
                  TextSpan(
                    text: '에서 수령된 티켓을 확인하실 수 있습니다.\n\n예매가 완료된 후, 해당 공연의 ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                  ),
                  TextSpan(
                    text: '아티스트 측에서 관람객님의 입금 정보를 확정',
                    style: TextStyle(
                      color: const Color(0xFFE4C3FF),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                  ),
                  TextSpan(
                    text: '한 뒤 ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                  ),
                  TextSpan(
                    text: '티켓 수령',
                    style: TextStyle(
                      color: const Color(0xFFE4C3FF),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                  ),
                  TextSpan(
                    text: '이 가능합니다.  ※ 단, 무료 공연의 경우 입금 정보 확인 절차 없이 즉시 수령이 가능하나, 선착순 공연일 경우 조기 마감으로 인해 티켓 수령이 불가할 수 있으니 이 점 유의해 주세요.\n\n캠티켓 앱은 무단 캡쳐 및 도용을 방지하기 위해, 실시간으로 움직이는 ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                  ),
                  TextSpan(
                    text: '‘스크린샷 방지 씰’',
                    style: TextStyle(
                      color: const Color(0xFFE4C3FF),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                  ),
                  TextSpan(
                    text: '을 적용하고 있습니다. 따라서 티켓을 캡쳐하거나 도용하여 사용하는 일이 없도록 각별히 주의해 주시기 바랍니다.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(
              color: AppColors.gray4,   // 선 색상
              thickness: 0.5,         // 선 두께
            ),
            SizedBox(height: 20),
            Text('취소/환불 안내', style: TextStyle(color: Color(0xFFE4C3FF), fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              '취소마감시간 이후 또는 관람일 당일 예매하신 건에 대해서는 취소/변경/환불이 불가능합니다.\n\n환불 요청 시 아티스트 측에서 해당 환불건에 대해서 확인한 뒤 관람객님의 등록된 환불 계좌번호로 환불 금액을 입금해드립니다.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.28,
              ),
            ),
            SizedBox(height: 20),
            Divider(
              color: AppColors.gray4,   // 선 색상
              thickness: 0.5,         // 선 두께
            ),
            SizedBox(height: 20),
            Text('예매 안내', style: TextStyle(color: Color(0xFFE4C3FF), fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(' 원하시는 공연 회차와 좌석 선택 후, 예매자 정보 기입과 티켓 가격 선택 후 결제 금액에 해당하는 금액을 명시되어있는 아티스트의 계좌번호로 입금 후 ‘입금 여부 체크\' 박스를 체크 후 예매 완료를 진행하시면 됩니다.\n\n※ 잘못된 계좌번호로 입금 혹은 결제금액과 일치하지 않은 금액 입금시 해당 예매건이 취소될 수 있습니다.', style: TextStyle(color: Colors.white)),
            SizedBox(height: 20),
            Divider(
              color: AppColors.gray4,   // 선 색상
              thickness: 0.5,         // 선 두께
            ),
            SizedBox(height: 20),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('공연장 위치', style: TextStyle(color: Color(0xFFE4C3FF), fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              '학관 104호',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Divider(
              color: AppColors.gray4,   // 선 색상
              thickness: 0.5,         // 선 두께
            ),
            SizedBox(height: 20),
            Text('찾아오는 길', style: TextStyle(color: Color(0xFFE4C3FF), fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('걸어서', style: TextStyle(color: Colors.white)),
            SizedBox(height: 20),
            Divider(
              color: AppColors.gray4,   // 선 색상
              thickness: 0.5,         // 선 두께
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPerformanceColumn(String category, String reserveDate, String date, String location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: const TextStyle(color: AppColors.gray4)),
        Text(reserveDate, style: const TextStyle(color: AppColors.gray4)),
        Text(date, style: const TextStyle(color: AppColors.gray4)),
        Text(location, style: const TextStyle(color: AppColors.gray4)),
      ],
    );
  }

  Widget _buildPerformanceInfoColumn(String category, String reserveDate, String date, String location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: const TextStyle(color: AppColors.gray5)),
        Text(reserveDate, style: const TextStyle(color: AppColors.gray5)),
        Text(date, style: const TextStyle(color: AppColors.gray5)),
        Text(location, style: const TextStyle(color: AppColors.gray5)),
      ],
    );
  }
}

class _TabUnderline extends StatelessWidget {
  const _TabUnderline();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 2,
      color: AppColors.mainPurple,
    );
  }
}

class _ReservationModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, // 키보드 올라올 때 대응
      child: Container(
        width: 412,
        height: 218,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFF232323),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: const Color(0xFF3C3C3C),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              left: 137,
              top: 20,
              child: Text(
                '회차를 선택해주세요.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.32,
                ),
              ),
            ),

            // 👉 1공
            Positioned(
              left: 20,
              top: 80,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // 모달 닫기
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PerformanceSeatReservationPage(),
                    ),
                  );
                },
                child: const Text(
                  '1공 : 2025.11.23(토) 16시 00분',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.32,
                  ),
                ),
              ),
            ),

            // 👉 2공
            Positioned(
              left: 20,
              top: 139,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PerformanceSeatReservationPage(),
                    ),
                  );
                },
                child: const Text(
                  '2공 : 2025.11.23(토) 19시 30분',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.32,
                  ),
                ),
              ),
            ),

            // 구분선들
            Positioned(
              left: 0,
              top: 60,
              child: Container(
                width: 412,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF3C3C3C),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 119,
              child: Container(
                width: 412,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF3C3C3C),
                    ),
                  ),
                ),
              ),
            ),

            // 닫기 버튼
            Positioned(
              left: 368,
              top: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(color: Color(0xFF232323)),
                  child: const Icon(Icons.close, size: 20, color: Colors.white,),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

