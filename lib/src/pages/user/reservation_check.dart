// reservation_check_page.dart
import 'package:camticket/src/pages/user/reservation_info.dart';
import 'package:flutter/material.dart';
import '../../../utility/color.dart';

class ReservationCheckPage extends StatelessWidget {
  const ReservationCheckPage({super.key});

  final List<Map<String, String>> reservations = const [
    {
      'image': 'assets/images/gospel.png',
      'title': 'The Gospel : Who we are',
      'subtitle':
          '예매 기간 | 11/18 월- 11/21 목\n공연 날짜 | 25.11.23 (2회)\n장소 | 학관 104호',
      'tag': '유료 공연',
      'subtag': '예매 확인중',
      'profile': 'assets/images/sticker.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBlack,
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () {
        //     // 검색 버튼 클릭 시 동작
        //     context.read<NavigationProvider>().setSubPage('default');
        //   },
        // ),
        backgroundColor: AppColors.mainBlack,
        title: Text(
          '예매 확인 / 취소',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final item = reservations[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReservationInfoPage(),
                  ),
                );
              },
              child: ReservationItemCard(item: item, index: index));
        },
      ),
    );
  }
}

class ReservationItemCard extends StatelessWidget {
  final Map<String, String> item;
  final int index;

  const ReservationItemCard(
      {super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Container(
        width: 372,
        height: 138,
        decoration: ShapeDecoration(
          color: AppColors.gray1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 19),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      item['profile']!,
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                width: 80,
                height: 114,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(item['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildTag(item['tag']!),
                        const SizedBox(width: 4),
                        _buildTag(item['subtag']!),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['title'] ?? '',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.32,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['subtitle'] ?? '',
                      style: const TextStyle(
                        color: AppColors.gray4,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.subPurple, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.subPurple,
          fontSize: 8,
          fontWeight: FontWeight.w600,
          height: 1,
          letterSpacing: -0.16,
        ),
      ),
    );
  }
}
