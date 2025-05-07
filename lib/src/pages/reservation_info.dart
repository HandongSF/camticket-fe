// reservation_info_page.dart
import 'package:flutter/material.dart';
import '../../utility/color.dart';

class ReservationInfoPage extends StatelessWidget {
  const ReservationInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainBlack,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const Text('예매정보', style: TextStyle(color: AppColors.white)),
        centerTitle: true,
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
            _buildInfoText('1공 : 2025.11.23(토) 16시 00분'),
            const SizedBox(height: 24),
            _buildLabel('좌석'),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(child: _buildInfoText('학관 104호 F8, F9, F10 (총 3좌석)')),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.subPurple),
                    foregroundColor: AppColors.subPurple,
                  ),
                  onPressed: () {},
                  child: const Text('좌석위치보기'),
                )
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('티켓 수령 방법'),
            const SizedBox(height: 8),
            _buildInfoText(
              '온라인수령\n\n예매가 완료된 후, 해당 공연의 아티스트 측에서 관람객님의 입금 정보를 확인한 뒤 티켓 수령이 가능합니다. (마이>티켓보기 에서 수령된 티켓 확인 가능)\n\n※ 단, 무료 공연의 경우 입금 정보 확인 절차 없이 즉시 수령이 가능하나, 선착순 공연일 경우 조기 마감으로 인해 티켓 수령이 불가할 수 있으니 이 점 유의해 주세요.',
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('예매자 정보'),
            const SizedBox(height: 8),
            _buildInfoText('이름\n박조이'),
            const SizedBox(height: 8),
            _buildInfoText('환불계좌\n하나 910-910****-910'),
            const SizedBox(height: 8),
            _buildInfoText('연락처\n010-2674-4006'),
            const SizedBox(height: 32),
            _buildSectionTitle('티켓 가격 옵션 선택 *'),
            const SizedBox(height: 8),
            _buildInfoText('3매중 3매 선택'),
            const SizedBox(height: 12),
            _buildTicketOptionRow('일반', '3,000원', '2매'),
            const SizedBox(height: 8),
            _buildTicketOptionRow('새내기', '2,000원', '1매'),
            const SizedBox(height: 8),
            _buildInfoText(
                '* (주의) 일반을 제외한 일부 유형은 현장에서 티켓 확인 시 증빙자료(학생증 등)가 요구될 수 있습니다. (공연 상세 페이지 > 가격정보 참고) 증빙되지 않은 경우, 현장에서 차액 지불이 요구될 수 있습니다.'),
            const SizedBox(height: 32),
            _buildSectionTitle('결제 금액'),
            const SizedBox(height: 8),
            const Text(
              '총 결제금액은 8,000원 입니다. (총 3매)',
              style: TextStyle(
                color: AppColors.mainPurple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('결제방법 안내'),
            const SizedBox(height: 8),
            _buildArtistBox(),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.gray5,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 14,
        height: 1.6,
      ),
    );
  }

  Widget _buildInfoWithIcon(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.gray4, size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTicketOptionRow(String label, String price, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.white)),
        Text(price, style: const TextStyle(color: AppColors.white)),
        Text(count, style: const TextStyle(color: AppColors.gray4)),
      ],
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
        children: const [
          Text('🎤 아티스트',
              style: TextStyle(
                  color: AppColors.subPurple, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('피치파이프 님의 계좌로 입금하세요.', style: TextStyle(color: AppColors.white)),
          SizedBox(height: 4),
          SelectableText('하나 910-910123-45678',
              style: TextStyle(color: AppColors.white)),
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
}
