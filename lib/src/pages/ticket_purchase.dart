import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:camticket/src/pages/home_page.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
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
        title: Text('예매정보 확인 및 기입 / 결제'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
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
                  sectionTitle('공연명'),
                  normalText('🎭 The Gospel : Who we are'),
                  sectionTitle('관람 회차 (일시)'),
                  normalText('1공 : 2025.11.23(토) 16시 00분'),
                  sectionTitle('좌석'),
                  normalText('학관 104호 F8, F9, F10 (총 3좌석)'),
                  sectionTitle('좌석'),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            '학관 104호 F8, F9, F10 (총 3좌석)',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SeatViewPage(
                                    selectedSeats: ['F8', 'F9', 'F10']),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(0xFFE5C4FF)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            foregroundColor: Color(0xFFE5C4FF),
                          ),
                          child: Text('좌석위치보기', style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  sectionTitle('티켓 수령 방법'),
                  normalText('온라인수령'),
                  smallText(
                      '예매가 완료된 후, 해당 공연의 아티스트 측에서 관람객님의 입금 정보를 확정한 뒤 티켓 수령이 가능합니다.'),
                  SizedBox(height: 20),
                  sectionTitle('예매자 정보'),
                  normalText('이름: 박조이'),
                  normalText('환불계좌: 하나 910-910239-98907'),
                  SizedBox(height: 10),
                  Text('연락처 *', style: TextStyle(color: Colors.white70)),
                  Row(
                    children: [
                      phoneInput(phone1, hint: '010'),
                      SizedBox(width: 6),
                      phoneInput(phone2, hint: '1234'),
                      SizedBox(width: 6),
                      phoneInput(phone3, hint: '5678'),
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
                          Text('🎨 아티스트 피치파이프 님의 계좌로 입금하세요.',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(height: 4),
                          Text('하나 910-910123-45678',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Checkbox(
                                value: isDepositChecked,
                                onChanged: (value) =>
                                    setState(() => isDepositChecked = value!),
                                activeColor: Colors.purpleAccent,
                              ),
                              Expanded(
                                child: Text('입금 여부 체크',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                          smallText(
                              '입금 여부 체크는 관람객님이 입금하셨는지를 스스로 확인하고 기억하실 수 있도록 돕는 기능입니다.'),
                          SizedBox(height: 4),
                          smallText(
                              '실제 입금 확인은 아티스트 측에서 별도로 진행되므로, 참고용으로 사용해 주세요.'),
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
                    onPressed: validateAndSubmit,
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
      color: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: buildTicketOption('일반', generalCount, isGeneral: true),
          ),
          Divider(height: 1, color: Colors.white24, thickness: 1),
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
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        // 가격
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${price.toString()}원',
              style: TextStyle(fontSize: 16, color: Colors.white70),
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
    return Expanded(
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white30),
          filled: true,
          fillColor: Colors.white12,
          border: OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 4),
      child: Text(text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE5C4FF),
          )),
    );
  }

  Widget normalText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }

  Widget smallText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: Colors.white60, height: 1.4)),
    );
  }
}

class TicketCompletePage extends StatelessWidget {
  final int generalCount;
  final int newbieCount;
  final String phoneNumber;
  final bool isSuccess;

  TicketCompletePage({
    required this.generalCount,
    required this.newbieCount,
    required this.phoneNumber,
    this.isSuccess = false,
  });

  int get totalPrice => generalCount * 3000 + newbieCount * 2000;

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: [Color(0xFFB957FF), Color(0xFF9A34FF)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 70.0));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Camticket', style: TextStyle(fontFamily: 'YourLogoFont')),
        centerTitle: true,
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
                            ? '예매가 정상적으로 완료되었습니다.'
                            : '정상적으로 예매가 이루어지지 않았습니다.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          foreground: isSuccess
                              ? (Paint()..shader = linearGradient)
                              : Paint()
                            ..color = Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      if (isSuccess)
                        smallText('예매 상세내역은 마이페이지 ➝ 예매확인 / 취소에서 확인하실 수 있습니다.'),
                    ],
                  ),
                ),
                if (isSuccess) ...[
                  SizedBox(height: 30),
                  sectionTitle('예매정보'),
                  Divider(color: Colors.white24),
                  normalText('공연명: 🎭 The Gospel : Who we are'),
                  normalText('관람 회차 (일시): 1공 : 2025.11.23(토) 16시 00분'),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            '학관 104호 F8, F9, F10 (총 3좌석)',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SeatViewPage(
                                    selectedSeats: ['F8', 'F9', 'F10']),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(0xFFE5C4FF)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            foregroundColor: Color(0xFFE5C4FF),
                          ),
                          child: Text('좌석위치보기', style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  normalText('티켓 수령 방법: 온라인수령'),
                  smallText(
                      '예매가 완료된 후, 해당 공연의 아티스트 측에서 입금 정보를 확인한 뒤 티켓 수령이 가능합니다.'),
                  SizedBox(height: 20),
                  sectionTitle('예매자 정보'),
                  Divider(color: Colors.white24),
                  normalText('이름: 박조이'),
                  normalText('환불계좌: 하나 910-910239-98907'),
                  normalText('연락처: $phoneNumber'),
                  SizedBox(height: 20),
                  sectionTitle('티켓 가격 옵션 선택 *'),
                  Divider(color: Colors.white24),
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
                          rowText('일반', '3,000원', '${generalCount}매'),
                          Divider(color: Colors.white24, height: 20),
                          rowText('새내기', '2,000원', '${newbieCount}매'),
                        ],
                      ),
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
                              text: '${totalPrice}원',
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
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                margin: EdgeInsets.only(right: 6),
                                decoration: BoxDecoration(
                                  color: Colors.purpleAccent.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text('아티스트',
                                    style: TextStyle(
                                        color: Colors.purpleAccent,
                                        fontSize: 12)),
                              ),
                              Text('피치파이프 님의 계좌로 입금하세요.',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: 6),
                          Text('하나 910-910123-45678',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16)),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.check_box, color: Colors.purpleAccent),
                              SizedBox(width: 6),
                              Expanded(child: normalText('입금 여부 체크')),
                            ],
                          ),
                          SizedBox(height: 4),
                          smallText(
                              '입금 여부 체크는 관람객님이 입금하셨는지를 스스로 확인하고 기억하실 수 있도록 돕는 기능입니다. 실제 입금 확인은 아티스트 측에서 별도로 진행되므로, 참고용으로 사용해 주세요.'),
                        ],
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),

          // 홈으로 버튼 (항상 표시)
          Positioned(
            bottom: 16,
            left: 24,
            right: 24,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9a3ae8),
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('홈으로',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
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
      child: Text(text, style: TextStyle(fontSize: 16, color: Colors.white)),
    );
  }

  Widget smallText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.white60, height: 1.4),
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
            Text(price, style: TextStyle(color: Colors.white70)),
            SizedBox(width: 10),
            Text(count, style: TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}

class SeatViewPage extends StatelessWidget {
  final List<String> selectedSeats;

  SeatViewPage({required this.selectedSeats});

  final List<String> allRows = [
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L'
  ];
  final int columns = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('좌석위치보기'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Text('무대', style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 10),
          Expanded(
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 4,
                runSpacing: 4,
                children: List.generate(allRows.length * columns, (index) {
                  String row = allRows[index ~/ columns];
                  int col = index % columns + 1;
                  String seatLabel = '$row$col';

                  bool isSelected = selectedSeats.contains(seatLabel);
                  bool isDisabled = _isDisabled(seatLabel);

                  return Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.purpleAccent
                          : isDisabled
                              ? Colors.red.withOpacity(0.6)
                              : Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      seatLabel,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text('확인', style: TextStyle(fontSize: 16)),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _isDisabled(String seat) {
    List<String> disabled = [
      'B1',
      'B2',
      'B3',
      'B4',
      'B5',
      'B7',
      'B8',
      'B9',
      'B10',
      'B11',
      'C3',
      'C4',
      'D3',
      'D4',
      'E9',
      'E10',
      'E11',
      'G2',
      'G3',
      'G4',
      'G5',
      'G6'
    ];
    return disabled.contains(seat);
  }
}
