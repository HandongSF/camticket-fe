import 'package:camticket/components/buttons.dart';
import 'package:camticket/components/dividers.dart';
import 'package:camticket/components/performance_round_widget.dart';
import 'package:camticket/components/texts.dart';
import 'package:camticket/components/ticket_option.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';

import '../searchpage.dart';
import 'edit_unable_seat_page.dart';

class PerformanceEditPage extends StatelessWidget {
  const PerformanceEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 숨기기
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1B1B1B), // mainBlack
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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    white28('공연 정보 수정하기'),
                    SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '메인 포스터 이미지 ',
                            style: TextStyle(
                              color: const Color(0xFFE4C3FF),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: const Color(0xFF9A3AE8),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                        onTap: () {
                          // 여기에 추후 이미지 선택 기능 구현 가능
                        },
                        child: Container(
                          height: 530,
                          padding: const EdgeInsets.all(20),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(color: AppColors.gray1),
                          child: Center(
                            child: Image.asset(
                              'assets/images/pitch_stage.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        )),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '공연명 ',
                            style: TextStyle(
                              color: AppColors.subPurple,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: AppColors.mainPurple,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '공연명을 입력해주세요.',
                        hintStyle: const TextStyle(color: AppColors.gray4),
                        filled: true,
                        fillColor: AppColors.gray1,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.gray2),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '공연 카테고리 선택 ',
                            style: TextStyle(
                              color: AppColors.subPurple,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: AppColors.mainPurple,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 8,
                        children: [
                          _chip('음악'),
                          _chip('연극 / 뮤지컬'),
                          _chip('댄스'),
                          _chip('전시'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '예매 가능 기간 설정 ',
                            style: TextStyle(
                              color: const Color(0xFFE4C3FF),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: const Color(0xFF9A3AE8),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    white16('예매 시작 날짜 / 시간'),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '예매 시작 날짜와 시간을 선택해주세요.',
                        hintStyle: const TextStyle(color: AppColors.gray4),
                        filled: true,
                        fillColor: AppColors.gray1,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.gray2),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    white16('예매 종료 날짜 / 시간'),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '예매 종료 날짜와 시간을 선택해주세요.',
                        hintStyle: const TextStyle(color: AppColors.gray4),
                        filled: true,
                        fillColor: AppColors.gray1,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.gray2),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '관람 회차 (일시) ',
                            style: TextStyle(
                              color: const Color(0xFFE4C3FF),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: const Color(0xFF9A3AE8),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    PerformanceRoundsWidget(
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '공연 장소 선택 ',
                            style: TextStyle(
                              color: const Color(0xFFE4C3FF),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: const Color(0xFF9A3AE8),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _dropdownField('공연 장소를 선택하세요.'),
                    const SizedBox(height: 8),
                    Transform.translate(
                      offset: const Offset(-15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (v) {},
                            checkColor: AppColors.mainBlack,
                            activeColor: AppColors.subPurple,
                          ),
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '선택한 공연 장소를 사전에 대여 완료했습니다. ',
                                    style: TextStyle(
                                      color: Color(0xFFE5E5E5),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.32,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: Color(0xFF9A3AE8),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.32,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '공연 장소를 사전에 대여한 경우에만, 공연 등록이 가능합니다.',
                      style: TextStyle(
                        color: const Color(0xFF818181),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.24,
                      ),
                    ),
                    const SizedBox(height: 32),
                    dividerGray2(),
                    const SizedBox(height: 32),
                    subPurpleText('관람객 티켓 수령 방법'),
                    white16('온라인수령'),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 372,
                      child: Text(
                        '관람객의 예매가 완료된 후, 아티스트님께서는 반드시 “마이페이지→관람객 예매 확인”에서 해당 공연의 관람객 입금 정보를 확정해야 관람객이 정상적으로 티켓을 수령받을 수 있습니다.',
                        style: TextStyle(
                          color: AppColors.gray4,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '관람객 1인당 구매 가능한 티켓 매수 ',
                            style: TextStyle(
                              color: const Color(0xFFE4C3FF),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: const Color(0xFF9A3AE8),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '숫자만 입력 가능합니다.',
                        hintStyle: const TextStyle(color: AppColors.gray4),
                        filled: true,
                        fillColor: AppColors.gray1,
                        suffixText: '매',
                        suffixStyle:
                            const TextStyle(color: Colors.white), // 색상 조정
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.gray2),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '티켓 가격 옵션 선택 ',
                            style: TextStyle(
                              color: const Color(0xFFE4C3FF),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: const Color(0xFF9A3AE8),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: RadioListTile(
                                activeColor: AppColors.mainPurple,
                                value: false,
                                groupValue: true,
                                onChanged: (_) {},
                                title: const Text('무료 공연',
                                    style: TextStyle(color: Colors.white)))),
                        Expanded(
                            child: RadioListTile(
                                activeColor: AppColors.mainPurple,
                                value: true,
                                groupValue: true,
                                onChanged: (_) {},
                                title: const Text('유료 공연',
                                    style: TextStyle(color: Colors.white)))),
                      ],
                    ),
                    PerformanceRoundsWidget2(),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '* 아티스트님께서는 일반을 제외한 일부 유형에 대해 현장에서 티켓 확인 시 증빙자료(학생증 등)를 요구할 수 있습니다. 증빙되지 않은 경우, 현장에서 차액 지불을 관람객에게 요구할 수 있습니다.',
                      style: TextStyle(
                        color: const Color(0xFF818181),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.24,
                      ),
                    ),
                    const SizedBox(height: 24),
                    subPurpleText(
                      '결제방법 - 입금',
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '은행명과 계좌번호를 정확하게 입력해주세요.',
                        hintStyle: const TextStyle(color: AppColors.gray4),
                        filled: true,
                        fillColor: AppColors.gray1, // 색상 조정
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.gray2),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '관람객은 입력된 계좌 정보대로 티켓 가격에 대한 입금을 진행하게 됩니다. \n정확한 은행명과 계좌번호를 입력해주세요.\n\n입력 예시) 하나 910-910123-45678',
                      style: TextStyle(
                        color: const Color(0xFF818181),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  // Perform the action for the next button
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditUnableSeatPage(selectedSeats: []),
                    ),
                  );
                },
                child: mainPurpleBtn('다음')),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.gray1,
          border: Border.all(color: AppColors.gray3, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: const TextStyle(color: AppColors.white, fontSize: 14)),
      );

  Widget _dateField(String hint) => TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFE5E5EA)),
          filled: true,
          fillColor: Color(0xFF3D3D3D),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
        style: const TextStyle(color: Colors.white),
      );

  Widget _dropdownField(String hint) => DropdownButtonFormField<String>(
        dropdownColor: const Color(0xFF3D3D3D),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF3D3D3D),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
        hint: Text(hint, style: const TextStyle(color: Color(0xFFE5E5EA))),
        items: ['공연 장소를 선택하세요.', '학관 104호']
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: const TextStyle(color: Colors.white))))
            .toList(),
        onChanged: (_) {},
      );

  Widget _addButton(String label) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color(0xFF9B3BE9), shape: BoxShape.circle),
              child: const Text('박', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      );

  Widget _ticketOptionField(String label, String hint) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
                child:
                    Text(label, style: const TextStyle(color: Colors.white))),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: TextField(
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(color: Color(0xFFE5E5EA)),
                  filled: true,
                  fillColor: const Color(0xFF3D3D3D),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
}
