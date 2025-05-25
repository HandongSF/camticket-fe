import 'package:camticket/src/pages/performance_detail_page.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/buttons.dart';
import '../../provider/navigation_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> posterImages = [
    'assets/images/poster.png',
    'assets/images/poster.png',
    'assets/images/poster.png', // 너가 올린 포스터
    // 추가 포스터 넣고 싶으면 여기에 추가
  ];
  final List<Map<String, String>> performances = [
    {
      'profile': 'assets/Home/Pagination.png',
      'image': 'assets/Home/Pagination.png',
      'title': '🔥God\'s Fellows Street Concert🔥',
      'subtitle': '예매 기간 | 예매가 필요없는 공연\n공연 날짜 | 25.03.19 (1회)\n장소 | 학관 앞',
      'tag': '무료 공연',
    },
    {
      'profile': 'assets/Home/Pagination.png',
      'image': 'assets/Home/Pagination.png',
      'title': '🔥Street performance🕺',
      'subtitle': '예매 기간 | 예매가 필요없는 공연\n공연 날짜 | 25.03.12 (1회)\n장소 | 학관 앞',
      'tag': '무료 공연',
    },
    {
      'profile': 'assets/Home/Pagination.png',
      'image': 'assets/Home/Pagination.png',
      'title': '🎵The Gospel : Who we are🎵',
      'subtitle':
          '예매 기간 | 11/18 월 - 11/21 목\n공연 날짜 | 25.11.23 (2회)\n장소 | 학관 104호',
      'tag': '유료 공연',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '홈',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: 360,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemCount: posterImages.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 254,
                            height: 360,
                            child: Image.asset(
                              posterImages[index],
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // 왼쪽 버튼
                  Positioned(
                    left: -10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 32,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_currentPage > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                  // 오른쪽 버튼
                  Positioned(
                    right: -10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_right,
                        size: 32,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_currentPage < posterImages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 68,
                height: 24,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: AppColors.gray2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${_currentPage + 1} / ${posterImages.length}',
                    style: const TextStyle(
                      color: AppColors.gray5,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '공연 카테고리',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildCategoryButton(context, '전체', 0),
                    SizedBox(width: 8),
                    buildCategoryButton(context, '음악', 1),
                    SizedBox(width: 8),
                    buildCategoryButton(context, '연극 / 뮤지컬', 2),
                    SizedBox(width: 8),
                    buildCategoryButton(context, '댄스', 3),
                    SizedBox(width: 8),
                    buildCategoryButton(context, '전시', 4),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '이번주의 공연',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 372,
                height: 300,
                child: ListView.separated(
                  itemCount: performances.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = performances[index];
                    return Container(
                        decoration: ShapeDecoration(
                          color: AppColors.gray1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<NavigationProvider>()
                                .setSubPage('performanceDetail');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PerformanceDetailPage()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
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
                                        item['image']!,
                                        width: 28,
                                        height: 28,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 12),
                                Container(
                                  width: 80,
                                  height: 114,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.asset(
                                        item['image']!,
                                      ).image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 47,
                                        height: 14,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1,
                                              color: AppColors.subPurple,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 8,
                                              top: 2,
                                              child: Text(
                                                item['tag'] ?? '',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFFE4C3FF),
                                                  fontSize: 8,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  height: 1,
                                                  letterSpacing: -0.16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: 100,
                                              child: Text(
                                                item['title'] ?? '',
                                                style: const TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: -0.32,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
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
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
