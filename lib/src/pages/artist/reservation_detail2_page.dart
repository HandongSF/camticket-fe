import 'package:camticket/components/buttons.dart';
import 'package:camticket/components/dividers.dart';
import 'package:camticket/components/text_pair.dart';
import 'package:camticket/src/pages/searchpage.dart';
import 'package:camticket/src/pages/seat_view_page.dart';
import 'package:camticket/src/pages/user/ticket_success_page.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../components/textfield.dart';
import '../../../components/texts.dart';

class ReservationDetail2Page extends StatefulWidget {
  const ReservationDetail2Page({super.key});

  @override
  _ReservationDetail2PageState createState() => _ReservationDetail2PageState();
}

class _ReservationDetail2PageState extends State<ReservationDetail2Page> {
  int generalCount = 0;
  int newbieCount = 0;
  final int maxTickets = 3;

  final TextEditingController phone1 = TextEditingController();
  final TextEditingController phone2 = TextEditingController();
  final TextEditingController phone3 = TextEditingController();

  bool isDepositChecked = false;

  void updateCount({required bool isGeneral, required bool increment}) {
    setState(() {
      int total = generalCount + newbieCount;
      if (increment) {
        if (total < maxTickets) {
          if (isGeneral)
            generalCount++;
          else
            newbieCount++;
        } else {
          showError('최대 $maxTickets매까지만 예매할 수 있습니다.');
        }
      } else {
        if (isGeneral && generalCount > 0) generalCount--;
        if (!isGeneral && newbieCount > 0) newbieCount--;
      }
    });
  }

  int get totalPrice => generalCount * 3000 + newbieCount * 2000;

  void validateAndSubmit() {
    String p1 = phone1.text.trim();
    String p2 = phone2.text.trim();
    String p3 = phone3.text.trim();

    if (p1.isEmpty || p2.isEmpty || p3.isEmpty) {
      showError('연락처를 모두 입력해주세요.');
      return;
    }

    if ((generalCount + newbieCount) != maxTickets) {
      showError('총 $maxTickets매를 모두 선택해주세요.');
      return;
    }

    String phoneNumber = '$p1 - $p2 - $p3';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TicketCompletePage(
          generalCount: generalCount,
          newbieCount: newbieCount,
          phoneNumber: phoneNumber,
          isSuccess: true, // 예매 성공 여부는 실제 구현에 따라 다름
        ),
      ),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 100),
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  white28('관람객 예매 상세정보'),
                  sectionTitle('공연명'),
                  normalText('🎭 The Gospel : Who we are'),
                  sectionTitle('관람 회차 (일시)'),
                  normalText('1공 : 2025.11.23(토) 16시 00분'),
                  sectionTitle('좌석'),
                  Row(
                    children: [
                      normalText('학관 104호 F8, F9, F10 (총 3좌석)'),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SeatViewPage(
                                      selectedSeats: [],
                                    )));
                          },
                          child: subPurpleBtn16('좌석위치보기'))
                    ],
                  ),
                  SizedBox(height: 32),
                  dividerGray2(),
                  sectionTitle('티켓 수령 방법'),
                  SizedBox(height: 8),
                  normalText('온라인수령'),
                  SizedBox(height: 8),
                  smallText(
                      '예매가 완료된 후, 해당 공연의 아티스트 측에서 관람객님의 입금 정보를 확정한 뒤 티켓 수령이 가능합니다.'),
                  SizedBox(height: 20),
                  dividerGray2(),
                  sectionTitle('예매자 정보'),
                  SizedBox(width: 160, child: grayAndWhite16('이름', '박조이')),
                  SizedBox(
                      width: 160,
                      child: grayAndWhite16('환불계좌:', '하나 910-910239-98907')),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      buildInfoBigText('연락처 ', '*'),
                      const SizedBox(width: 8),
                      buildPhoneNumber('010'),
                      Text(
                        '-',
                        style: TextStyle(
                          color: const Color(0xFFE5E5E5),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.32,
                          height: 1,
                        ),
                      ),
                      buildPhoneNumber('2674'),
                      Text(
                        '-',
                        style: TextStyle(
                          color: const Color(0xFFE5E5E5),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.32,
                          height: 1,
                        ),
                      ),
                      buildPhoneNumber('4006'),
                    ],
                  ),
                  SizedBox(height: 20),
                  sectionTitle('티켓 가격 옵션 선택 *'),
                  normalText('3매중 ${generalCount + newbieCount}매 선택'),
                  buildTicketOptionGroup(),
                  SizedBox(height: 20),
                  sectionTitle('결제 금액'),
                  Card(
                    color: Color(0xFF1E1E1E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      child: Text.rich(
                        TextSpan(
                          text: '총 결제금액은 ',
                          children: [
                            TextSpan(
                              text: '${totalPrice}원',
                              style: TextStyle(
                                  color: Color(0xFFE5C4FF),
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text:
                                    ' 입니다. (총 ${generalCount + newbieCount}매)'),
                          ],
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 고정된 하단 버튼
        ],
      ),
    );
  }

  Widget buildTicketOptionGroup() {
    return Card(
      color: AppColors.gray1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: buildTicketOption('일반', generalCount, isGeneral: true),
          ),
          Divider(height: 1, color: AppColors.gray2, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: buildTicketOption('새내기', newbieCount, isGeneral: false),
          ),
        ],
      ),
    );
  }

  Widget buildTicketOption(String title, int count, {required bool isGeneral}) {
    final int price = isGeneral ? 3000 : 2000;

    return Row(
      children: [
        // 티켓 종류
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: TextStyle(fontSize: 16, color: AppColors.white),
          ),
        ),
        // 가격
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${price.toString()}원',
              style: TextStyle(fontSize: 16, color: AppColors.white),
            ),
          ),
        ),
        // 수량 조절
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () =>
                    updateCount(isGeneral: isGeneral, increment: false),
                icon: Icon(Icons.remove_circle_outline, color: Colors.white70),
              ),
              Text(
                '${count}매',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              IconButton(
                onPressed: () =>
                    updateCount(isGeneral: isGeneral, increment: true),
                icon: Icon(Icons.add_circle_outline, color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget phoneInput(TextEditingController controller, {String? hint}) {
    return SizedBox(
      width: 85,
      height: 24,
      child: Center(
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 16,
            height: 1,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.gray5),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            filled: true,
            fillColor: AppColors.gray2,
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 4),
      child: Text(text,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.32,
            color: AppColors.subPurple,
          )),
    );
  }

  Widget normalText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.gray5,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.32,
        ),
      ),
    );
  }

  Widget smallText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.gray4,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.24,
        ),
      ),
    );
  }
}
