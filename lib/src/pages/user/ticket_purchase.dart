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
import 'package:camticket/model/performanceDetail.dart';
import 'package:camticket/model/ticket_option_detail.dart';
import 'package:camticket/provider/reservation_upload_provider.dart';
import 'package:camticket/provider/selected_performance_provider.dart';
import 'package:camticket/provider/ticket_option_provider.dart';
import 'package:camticket/provider/user_provider.dart';
import 'package:camticket/src/pages/searchpage.dart';
import 'package:camticket/src/pages/seat_view_page.dart';
import 'package:camticket/src/pages/user/ticket_success_page.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../components/textfield.dart';
import '../../../components/texts.dart';
import '../../../model/reservation_request.dart';
import '../../../provider/seat_provider.dart';

class ReservationCheckInsertPayment extends StatefulWidget {
  const ReservationCheckInsertPayment({
    super.key,
    required this.detail,
    required this.num,
    required this.disabled,
    required this.scheduleId,
    this.time,
    required this.count,
  });

  final PerformanceDetail detail;
  final int num;
  final DateTime? time;
  final Set<String> disabled;
  final int scheduleId;
  final int count;

  @override
  State<ReservationCheckInsertPayment> createState() =>
      _ReservationCheckInsertPaymentState();
}

class _ReservationCheckInsertPaymentState
    extends State<ReservationCheckInsertPayment> {
  List<TicketOptionDetail> _ticketOptions = [];
  int _ticketOptionIdGeneral = 0;
  int _ticketUnitPriceGeneral = 0;
  int _ticketOptionIdNewbie = 0;

  int _generalCount = 0;
  int _newbieCount = 0;
  int _maxTickets = 0;

  final TextEditingController _phone1 = TextEditingController(text: '010');
  final TextEditingController _phone2 = TextEditingController();
  final TextEditingController _phone3 = TextEditingController();

  // ───── 초기 로딩 ──────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 유저 정보
      context.read<UserProvider>().fetchUser();
      _maxTickets = widget.detail.maxTicketsPerUser;
      // 티켓 옵션
      final optionProv = context.read<TicketOptionProvider>();
      await optionProv.loadOptions(widget.detail.id);
      setState(() {
        _ticketOptions = optionProv.options;
        if (_ticketOptions.isNotEmpty) {
          _ticketOptionIdGeneral = _ticketOptions[0].optionId;
          _ticketUnitPriceGeneral = _ticketOptions[0].price;
          if (_ticketOptions.length > 1) {
            _ticketOptionIdNewbie = _ticketOptions[1].optionId;
          }
        }
      });
    });
  }

  // ───── 가격 계산 ─────────────────────────────────────────────
  int get _totalPrice =>
      _generalCount * _ticketUnitPriceGeneral +
      _newbieCount * (_ticketOptions.length > 1 ? _ticketOptions[1].price : 0);

  // ───── 수량 변경 ─────────────────────────────────────────────
  void _updateCount({required bool isGeneral, required bool increment}) {
    setState(() {
      final total = _generalCount + _newbieCount;
      if (increment) {
        if (total >= widget.count) {
          showError('최대 ${widget.count}매까지만 예매할 수 있습니다.');
          return;
        }
        isGeneral ? _generalCount++ : _newbieCount++;
      } else {
        if (isGeneral && _generalCount > 0) _generalCount--;
        if (!isGeneral && _newbieCount > 0) _newbieCount--;
      }
    });
  }

  void _showError(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  // ───── 예매 제출 ─────────────────────────────────────────────
  Future<void> _validateAndSubmit() async {
    // ① 티켓 수량
    if ((_generalCount + _newbieCount) != widget.count) {
      _showError('총 ${widget.count}매를 모두 선택해주세요.');
      return;
    }

    // ② 연락처
    final p1 = _phone1.text.trim();
    final p2 = _phone2.text.trim();
    final p3 = _phone3.text.trim();
    if (p2.length < 3 || p3.length < 3) {
      _showError('연락처를 정확히 입력해주세요.');
      return;
    }
    final phoneNumber = '$p1-$p2-$p3';

    // ③ 좌석
    final selectedSeats =
        context.read<SeatProvider>().selectedSeat ?? <String>{};
    if (selectedSeats.isEmpty) {
      _showError('좌석을 선택해주세요.');
      return;
    }

    // ④ 유저 정보
    final user = context.read<UserProvider>().user;
    if (user?.bankAccount == null) {
      _showError('사용자 계좌 정보가 없습니다.');
      return;
    }

    // ⑤ 예약 요청 모델
    final request = ReservationRequest(
      performancePostId: widget.detail.id,
      performanceScheduleId: widget.scheduleId,
      selectedSeatCodes: selectedSeats.toList(),
      userBankAccount: user!.bankAccount!,
      ticketOrders: [
        TicketOrder(
          ticketOptionId: _ticketOptionIdGeneral,
          count: _generalCount,
          unitPrice: _ticketUnitPriceGeneral,
        ),
        if (_ticketOptions.length > 1)
          TicketOrder(
            ticketOptionId: _ticketOptionIdNewbie,
            count: _newbieCount,
            unitPrice: _ticketOptions[1].price,
          ),
      ],
      isPaymentCompleted: true,
    );

    // ⑥ 업로드
    final uploadProv = context.read<ReservationUploadProvider>();
    await uploadProv.uploadReservation(request);
    if (!mounted) return;
    debugPrint("selected Seats : $selectedSeats");
    if (uploadProv.isSuccess) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TicketCompletePage(
            performanceTitle: widget.detail.title,
            roundInfo: '${widget.num}공 : ${widget.time}', // 원하는 형태로 포맷팅
            seatInfo: selectedSeats, // Set<String> 그대로 넘기면 됨
            location: widget.detail.location,
            userName: user.name!,
            userBankAccount: user.bankAccount!,
            phoneNumber: phoneNumber,
            generalCount: _generalCount,
            newbieCount: _newbieCount,
            generalPrice: _ticketUnitPriceGeneral,
            newbiePrice:
                _ticketOptions.length > 1 ? _ticketOptions[1].price : 0,
            isSuccess: true,
          ),
        ),
      );
      context.read<SeatProvider>().clearSeats();
    } else {
      _showError(uploadProv.errorMessage ?? '예매에 실패했습니다.');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedPerformance =
        Provider.of<SelectedPerformanceProvider>(context).selectedPerformance;
    final selectedSeats = Provider.of<SeatProvider>(context).selectedSeat;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
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
                  white28('예매정보 확인 및 기입 / 결제'),
                  sectionTitle('공연명'),
                  normalText(widget.detail.title),
                  sectionTitle('관람 회차 (일시)'),
                  normalText('${widget.num}공 : ${widget.time}'),
                  sectionTitle('좌석'),
                  Row(
                    children: [
                      Expanded(
                        child: normalText(
                            '${widget.detail.location} $selectedSeats (총 ${selectedSeats?.length.toString()}좌석)'),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SeatViewPage(
                                      selectedSeats: selectedSeats,
                                      disabledSeats: widget.disabled,
                                    )));
                          },
                          child: subPurpleBtn16('좌석위치보기'))
                    ],
                  ),
                  SizedBox(height: 32),
                  dividerGray2(),
                  sectionTitle('티켓 수령 방법'),
                  SizedBox(height: 8),
                  normalText(selectedPerformance!.priceNotice),
                  SizedBox(height: 8),
                  smallText(
                      '예매가 완료된 후, 해당 공연의 아티스트 측에서 관람객님의 입금 정보를 확정한 뒤 티켓 수령이 가능합니다.'),
                  SizedBox(height: 20),
                  dividerGray2(),
                  sectionTitle('예매자 정보'),
                  SizedBox(
                      width: 160,
                      child: grayAndWhite16(
                          '이름', user != null ? user.name.toString() : '')),
                  SizedBox(
                      width: 160,
                      child: grayAndWhite16('환불계좌:',
                          user != null ? user.bankAccount.toString() : '')),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      buildInfoBigText('연락처 ', '*'),
                      const SizedBox(width: 8),
                      phoneInput(_phone1, hint: '010'),
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
                      phoneInput(_phone2, hint: '0000'),
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
                      phoneInput(_phone3, hint: '4006'),
                    ],
                  ),
                  SizedBox(height: 20),
                  sectionTitle('티켓 가격 옵션 선택 *'),
                  normalText('3매중 ${_generalCount + _newbieCount}매 선택'),
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
                              text: '$_totalPrice원',
                              style: TextStyle(
                                  color: Color(0xFFE5C4FF),
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text:
                                    ' 입니다. (총 ${_generalCount + _newbieCount}매)'),
                          ],
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
                                      text: '피치파이프 ',
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
                                '하나 910-910123-45678',
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
                                      text: '하나 910-910123-45678')); // 예시 계좌번호
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
                ],
              ),
            ),
          ),

          // 고정된 하단 버튼
          Positioned(
            bottom: 16,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Color(0xFFE4C3FF),
                      foregroundColor: Color(0xFFE4C3FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '이전',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _validateAndSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Color(0xFF9a3ae8),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '예매 완료하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
          if (_ticketOptions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: buildTicketOption(_ticketOptions[0].name, _generalCount,
                  isGeneral: true),
            ),
          Divider(height: 1, color: AppColors.gray2, thickness: 1),
          if (_ticketOptions.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: buildTicketOption(_ticketOptions[1].name, _newbieCount,
                  isGeneral: false),
            ),
        ],
      ),
    );
  }

  Widget buildTicketOption(String title, int count, {required bool isGeneral}) {
    final int price =
        isGeneral ? _ticketOptions[0].price : _ticketOptions[1].price;

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
                    _updateCount(isGeneral: isGeneral, increment: false),
                icon: Icon(Icons.remove_circle_outline, color: Colors.white70),
              ),
              Text(
                '$count매',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              IconButton(
                onPressed: () =>
                    _updateCount(isGeneral: isGeneral, increment: true),
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
      width: 70,
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
          overflow: TextOverflow.visible,
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
