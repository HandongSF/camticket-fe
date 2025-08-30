/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:camticket/components/buttons.dart';
import 'package:camticket/components/dividers.dart';
import 'package:camticket/components/text_pair.dart';
import 'package:camticket/src/nav_page.dart';
import 'package:camticket/src/pages/searchpage.dart';
import 'package:camticket/src/pages/seat_view_page.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as context;
import 'package:provider/provider.dart';

import '../../../components/input_form.dart';
import '../../../components/texts.dart';
import '../../../provider/navigation_provider.dart';
import '../../../provider/seat_provider.dart';
import '../../../provider/user_provider.dart';

class TicketCompletePage extends StatelessWidget {
  final String performanceTitle;
  final String roundInfo;
  final Set<String> seatInfo;
  final String location;
  final String userName;
  final String userBankAccount;
  final String phoneNumber;
  final int generalCount;
  final int newbieCount;
  final int generalPrice;
  final int newbiePrice;
  final bool isSuccess;

  TicketCompletePage({
    super.key,
    required this.performanceTitle,
    required this.roundInfo,
    required this.seatInfo,
    required this.location,
    required this.userName,
    required this.userBankAccount,
    required this.phoneNumber,
    required this.generalCount,
    required this.newbieCount,
    required this.generalPrice,
    required this.newbiePrice,
    this.isSuccess = true,
  });

  int get totalPrice => generalCount * generalPrice + newbieCount * newbiePrice;
  final TextEditingController phone1 = TextEditingController();
  final TextEditingController phone2 = TextEditingController();
  final TextEditingController phone3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _showError(String msg) => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));

    final selectedSeats = Provider.of<SeatProvider>(context).selectedSeat;
    final user = Provider.of<UserProvider>(context).user;
    if (user?.bankAccount == null) {
      _showError('사용자 계좌 정보가 없습니다.');
    }
    final linearGradient = LinearGradient(
      begin: Alignment(1.03, 1.82),
      end: Alignment(-0.23, -0.56),
      colors: [
        Colors.white,
        const Color(0xFFCC8DFF),
        const Color(0xFF8414DD),
        const Color(0xFF8A20E1)
      ],
    );

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
                    MaterialPageRoute(builder: (context) => Searchpage()),
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
            padding: EdgeInsets.fromLTRB(24, 24, 24, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        isSuccess
                            ? '예매가 정상적으로\n완료되었습니다.'
                            : '정상적으로 예매가\n이루어지지 않았습니다.',
                        textAlign: TextAlign.center,
                        style: isSuccess
                            ? TextStyle(
                                fontSize: 28,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                foreground: Paint()
                                  ..shader = linearGradient.createShader(
                                    const Rect.fromLTWH(100.0, 100.0, 200.0,
                                        50.0), // 너비/높이는 적절히 조정
                                  ),
                              )
                            : const TextStyle(
                                fontSize: 28,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                      ),
                      if (!isSuccess)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '예매 실패 사유',
                                    style: TextStyle(
                                      color: const Color(0xFFCE3939),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.24,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' : 서버에 장애가 발생하였습니다.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.24,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      SizedBox(height: 10),
                      if (isSuccess)
                        smallText('예매 상세내역은 마이페이지 ➝ 예매확인 / 취소에서\n확인하실 수 있습니다.'),
                    ],
                  ),
                ),
                if (isSuccess) ...[
                  SizedBox(height: 30),
                  white28('예매정보'),
                  SizedBox(height: 20),
                  subPurpleText('공연명'),
                  normalText(performanceTitle),
                  SizedBox(height: 32),
                  subPurpleText('관람 회차 (일시)'),
                  normalText(roundInfo),
                  SizedBox(height: 32),
                  subPurpleText('좌석'),
                  Row(
                    children: [
                      normalText(
                          '$selectedSeats (총 ${selectedSeats?.length.toString()}좌석)'),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeatViewPage(
                                  selectedSeats: selectedSeats,
                                  disabledSeats: {},
                                ),
                              ),
                            );
                          },
                          child: subPurpleBtn16('좌석위치보기'))
                    ],
                  ),
                  SizedBox(height: 20),
                  dividerGray2(),
                  SizedBox(height: 20),
                  subPurpleText('티켓 수령 방법'),
                  normalText('온라인수령'),
                  gray412(
                      '예매가 완료된 후, 해당 공연의 아티스트 측에서 입금 정보를 확인한 뒤 티켓 수령이 가능합니다.'),
                  SizedBox(height: 20),
                  dividerGray2(),
                  SizedBox(height: 20),
                  sectionTitle('예매자 정보'),
                  SizedBox(
                      width: 160,
                      child: grayAndWhite16(
                          '이름', user != null ? user.name.toString() : '')),
                  SizedBox(height: 8),
                  SizedBox(
                      width: 160,
                      child: grayAndWhite16('환불계좌',
                          user != null ? user.bankAccount.toString() : '')),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: 84,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '연락처',
                                style: TextStyle(
                                  color: const Color(0xFF818181),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.32,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: const Color(0xFFE5E5E5),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.32,
                                ),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: const Color(0xFF9A3AE8),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.32,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      phoneInput(phone1, hint: '010'),
                      Text(' - ',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.32,
                          )),
                      phoneInput(phone2, hint: '1234'),
                      Text(' - ',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.32,
                          )),
                      phoneInput(phone3, hint: '5678'),
                    ],
                  ),
                  SizedBox(height: 20),
                  dividerGray2(),
                  sectionTitle('티켓 가격 옵션 선택 *'),
                  Card(
                    color: Color(0xFF1E1E1E),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Column(
                        children: [
                          rowText('일반', '3,000원', '$generalCount매'),
                          Divider(color: Colors.white24, height: 20),
                          rowText('새내기', '2,000원', '$newbieCount매'),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '*(주의) 일반을 제외한 일부 유형은 현장에서 티켓 확인 시 증빙자료(학생증 등)가 요구될 수 있습니다. (공연 상세 페이지 > 가격정보 참고) 증빙되지 않은 경우, 현장에서 차액 지불이 요구될 수 있습니다.',
                    style: TextStyle(
                      color: const Color(0xFF818181),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.24,
                    ),
                  ),
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
                              text: '$totalPrice원',
                              style: TextStyle(
                                color: Color(0xFFE5C4FF),
                                fontWeight: FontWeight.bold,
                              ),
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
                  sectionTitle('결제방법 안내'),
                  Card(
                    color: Color(0xFF1E1E1E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/artist.png',
                            width: 53,
                            height: 18,
                          ),
                          Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '한동 오케스트라 ',
                                      style: TextStyle(
                                        color: AppColors.gray5,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.36,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '님',
                                      style: TextStyle(
                                        color: AppColors.gray5,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.36,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '의 계좌로 입금하세요.',
                                      style: TextStyle(
                                        color: AppColors.gray5,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.28,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Text(
                                '하나 123-456-789',
                                style: TextStyle(
                                  color: AppColors.subPurple,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.36,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.copy,
                                    color: AppColors.subPurple, size: 16),
                                onPressed: () {
                                  // 클립보드에 복사하는 기능 구현
                                  Clipboard.setData(ClipboardData(
                                      text: '하나 123-456-789')); // 예시 계좌번호
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('계좌번호가 복사되었습니다.'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.check_box, color: AppColors.subPurple),
                              SizedBox(width: 6),
                              Expanded(child: normalText('입금 여부 체크')),
                            ],
                          ),
                          SizedBox(height: 4),
                          gray412(
                              '입금 여부 체크는 관람객님이 입금하셨는지를 스스로 확인하고 기억하실 수 있도록 돕는 기능입니다. 실제 입금 확인은 아티스트 측에서 별도로 진행되므로, 참고용으로 사용해 주세요.'),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '예매가 완료된 후, 해당 공연의 아티스트 측에서 관람객님의 입금 정보를 확정한 뒤 티켓 수령이 가능합니다. (마이→티켓보기 에서 수령된 티켓 확인 가능) ※ 단, 무료 공연의 경우 입금 정보 확인 절차 없이 즉시 수령이 가능하나, 선착순 공연일 경우 조기 마감으로 인해 티켓 수령이 불가할 수 있으니 이 점 유의해 주세요.',
                    style: TextStyle(
                      color: const Color(0xFF818181),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.24,
                    ),
                  )
                ]
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
          onTap: () {
            // final navigationProvider = Provider.of<NavigationProvider>(context);
            // navigationProvider.setIndex(1);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Start()),
              (Route<dynamic> route) => false,
            );
          },
          child: mainPurpleBtn('홈으로')),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 4),
      child: Text(text,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE5C4FF))),
    );
  }

  Widget normalText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.white,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.32,
          )),
    );
  }

  Widget smallText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.white,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget rowText(String title, String price, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
        Row(
          children: [
            Text(price, style: TextStyle(color: AppColors.gray5, fontSize: 16)),
            SizedBox(width: 10),
            Container(
              width: 80,
              height: 24,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFF3C3C3C),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: const Color(0xFF5C5C5C),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Center(
                child: Text(
                  count,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color(0xFFE5E5E5),
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.26,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
