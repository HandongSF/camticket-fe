// reservation_info_page.dart
import 'package:camticket/src/pages/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/buttons.dart';
import '../../../provider/navigation_provider.dart';
import '../../../utility/category_btn.dart';
import '../../../utility/color.dart';

class ReservationInfoPage extends StatelessWidget {
  const ReservationInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.mainBlack,
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
                  // if (navigationProvider.selectedIndex == 4) {
                  //   navigationProvider.setSubPage('default');
                  // } else {
                  Navigator.pop(context);
                  // }
                },
              ),
              Image.asset(
                'assets/images/navi logo.png',
                width: 110,
                height: 28,
              ),
              // IconButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const Searchpage()),
              //     );
              //   },
              //   icon: const Icon(
              //     Icons.search,
              //     size: 24,
              //   ),
              // )
              SizedBox(
                width: 24,
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('공연명'),
            const SizedBox(height: 4),
            _buildInfoWithIcon('The Gospel : Who we are', Icons.music_note),
            const SizedBox(height: 24),
            _buildLabel('관람 회차 (일시)'),
            const SizedBox(height: 4),
            _buildInfoWithIcon('1공 : 2025.11.23(토) 16시 00분', null),
            const SizedBox(height: 24),
            _buildLabel('좌석'),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                    child: _buildInfoWithIcon(
                        '학관 104호 F8, F9, F10 (총 3좌석)', null)),
                Container(
                  width: 111,
                  height: 25,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: AppColors.subPurple,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 12,
                        top: 3,
                        child: Text(
                          '좌석위치보기',
                          style: TextStyle(
                            color: AppColors.subPurple,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.32,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),
            _grayDivider(),
            const SizedBox(height: 32),
            _buildSectionTitle('티켓 수령 방법', null),
            const SizedBox(height: 8),
            _buildWhiteText('온라인수령'),
            SizedBox(
              height: 5,
            ),
            _buildInfoText(
              '예매가 완료된 후, 해당 공연의 아티스트 측에서 관람객님의 입금 정보를 확인한 뒤 티켓 수령이 가능합니다. (마이>티켓보기 에서 수령된 티켓 확인 가능)※ 단, 무료 공연의 경우 입금 정보 확인 절차 없이 즉시 수령이 가능하나, 선착순 공연일 경우 조기 마감으로 인해 티켓 수령이 불가할 수 있으니 이 점 유의해 주세요.',
            ),
            const SizedBox(height: 32),
            _grayDivider(),
            const SizedBox(height: 32),
            _buildSectionTitle('예매자 정보', null),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildInfoBigText('이름', null),
                const SizedBox(width: 8),
                _buildWhiteText('박조이')
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildInfoBigText('환불계좌', null),
                const SizedBox(width: 8),
                _buildWhiteText('하나 910-910239-910')
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildInfoBigText('연락처 ', '*'),
                const SizedBox(width: 8),
                _buildPhoneNumber('010'),
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
                _buildPhoneNumber('2674'),
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
                _buildPhoneNumber('4006'),
              ],
            ),
            const SizedBox(height: 32),
            _grayDivider(),
            const SizedBox(height: 32),
            _buildSectionTitle('티켓 가격 옵션 선택 ', '*'),
            const SizedBox(height: 8),
            _whiteAndPurple('3매중', ' 3 ', '매 선택'),
            const SizedBox(height: 12),
            _buildTicketOptionRow('일반', '3,000원', '2매', '새내기', '2,000원', '1매'),
            const SizedBox(height: 8),
            _buildInfoText(
                '* (주의) 일반을 제외한 일부 유형은 현장에서 티켓 확인 시 증빙자료(학생증 등)가 요구될 수 있습니다. (공연 상세 페이지 > 가격정보 참고) 증빙되지 않은 경우, 현장에서 차액 지불이 요구될 수 있습니다.'),
            const SizedBox(height: 32),
            _buildSectionTitle('결제 금액', null),
            const SizedBox(height: 8),
            Container(
                padding: EdgeInsets.only(left: 20, top: 21),
                width: 372,
                height: 60,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: AppColors.gray1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '총 결제금액은 ',
                        style: TextStyle(
                          color: const Color(0xFFE5E5E5),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.32,
                        ),
                      ),
                      TextSpan(
                        text: '8,000원 ',
                        style: TextStyle(
                          color: const Color(0xFFE4C3FF),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.32,
                        ),
                      ),
                      TextSpan(
                        text: '입니다. (총 3매)',
                        style: TextStyle(
                          color: const Color(0xFFE5E5E5),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.32,
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 32),
            _buildSectionTitle('결제방법 안내', null),
            const SizedBox(height: 8),
            _buildArtistBox(),
            const SizedBox(height: 5),
            SizedBox(
              width: 372,
              child: Text(
                '예매가 완료된 후, 해당 공연의 아티스트 측에서 관람객님의 입금 정보를 확정한 뒤 티켓 수령이 가능합니다. (마이→티켓보기 에서 수령된 티켓 확인 가능) ※ 단, 무료 공연의 경우 입금 정보 확인 절차 없이 즉시 수령이 가능하나, 선착순 공연일 경우 조기 마감으로 인해 티켓 수령이 불가할 수 있으니 이 점 유의해 주세요.',
                style: TextStyle(
                  color: const Color(0xFF818181),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.24,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _showCancelDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD90206),
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:
                  const Text('예매 취소 요청', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumber(String text) {
    return Container(
      width: 80,
      height: 24,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF232323),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFF3C3C3C),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 8,
            top: 3,
            child: Text(
              text,
              style: TextStyle(
                color: const Color(0xFFE5E5E5),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.32,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _whiteAndPurple(String text, String? text2, String? text3) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              color: const Color(0xFFE5E5E5),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.32,
            ),
          ),
          TextSpan(
            text: text2,
            style: TextStyle(
              color: const Color(0xFF9A3AE8),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.32,
            ),
          ),
          TextSpan(
            text: text3,
            style: TextStyle(
              color: const Color(0xFFE5E5E5),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.subPurple,
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        letterSpacing: -0.32,
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.gray4,
        fontSize: 12,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        letterSpacing: -0.24,
      ),
    );
  }

  Widget _buildInfoBigText(String text, String? text2) {
    return SizedBox(
      width: 84,
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: AppColors.gray4,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.32,
            ),
          ),
          text2 == null
              ? SizedBox()
              : Text(
                  text2,
                  style: TextStyle(
                    color: const Color(0xFF9A3AE8),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.32,
                  ),
                )
        ],
      ),
    );
  }

  Widget _buildInfoWithIcon(String text, IconData? icon) {
    return Row(
      children: [
        icon == null
            ? SizedBox()
            : Icon(icon, color: AppColors.gray5, size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.gray5,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.32,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String text, String? text2) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: AppColors.subPurple,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.32,
          ),
        ),
        text2 == null
            ? SizedBox()
            : Text(
                text2,
                style: TextStyle(
                  color: const Color(0xFF9A3AE8),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.32,
                ),
              )
      ],
    );
  }

  Widget _buildTicketOptionRow(String label, String price, String count,
      String label2, String price2, String count2) {
    return Container(
      width: 372,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.gray1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      color: const Color(0xFFE5E5E5),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.32,
                      height: 1),
                ),
                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                          color: const Color(0xFFE5E5E5),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.32,
                          height: 1),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: 80,
                      height: 30,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: AppColors.gray3,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: AppColors.gray2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          count,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColors.gray5,
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.26,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.gray3,
            thickness: 1,
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label2,
                  style: const TextStyle(
                      color: const Color(0xFFE5E5E5),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.32,
                      height: 1),
                ),
                Row(
                  children: [
                    Text(
                      price2,
                      style: TextStyle(
                          color: const Color(0xFFE5E5E5),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.32,
                          height: 1),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: 80,
                      height: 30,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: AppColors.gray3,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: AppColors.gray2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          count2,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColors.gray5,
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.26,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtistBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gray1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildGradientBadge('아티스트'),
          SizedBox(height: 4),
          Text('피치파이프 님의 계좌로 입금하세요.', style: TextStyle(color: AppColors.white)),
          SizedBox(height: 4),
          Row(
            children: [
              _buildSectionTitle('하나 910-910123-45678', null),
              const SizedBox(width: 8),
              Icon(Icons.copy, color: AppColors.subPurple, size: 16),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.check_box, color: AppColors.subPurple, size: 16),
              SizedBox(width: 4),
              Text('입금 여부 체크', style: TextStyle(color: AppColors.white)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '입금 여부 체크는 관람객님이 입금하셨는지를 스스로 확인하고 기억하실 수 있도록 도와드리는 기능입니다. 실제 입금 확인은 아티스트 측에서 별도로 진행되므로, 참고용으로 사용해 주세요.',
            style: TextStyle(color: AppColors.gray4, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.gray5,
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
      ),
    );
  }

  Widget _grayDivider() {
    return Container(
      height: 1,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: AppColors.gray2,
          ),
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.gray1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '예매 취소 요청',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.25,
                letterSpacing: 0.10,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: SizedBox(
          width: 372,
          child: const Text('정말로 예매를 취소하시겠습니까?',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.25,
                letterSpacing: 0.10,
              )),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppColors.gray1,
                  title: const Text(
                    '예매 취소 요청 완료',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      letterSpacing: 0.10,
                    ),
                  ),
                  content: SizedBox(
                    width: 372,
                    child: const Text('정상적으로 예매 취소 요청이 완료되었습니다.',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.25,
                          letterSpacing: 0.10,
                        )),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('확인',
                          style: TextStyle(
                            color: AppColors.subPurple,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.28,
                          )),
                    ),
                  ],
                ),
              );
            },
            child: const Text('확인', style: TextStyle(color: Color(0xFFD90206))),
          ),
        ],
      ),
    );
  }
}
