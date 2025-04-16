import 'package:camticket/src/pages/performance_page.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/navigation_provider.dart';
import '../../provider/pc_provider.dart';
import '../../utility/category_btn.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildCategoryButton(context, '음악', 0),
                  _buildCategoryButton(context, '연극 / 뮤지컬', 1),
                  _buildCategoryButton(context, '댄스', 2),
                  _buildCategoryButton(context, '전시', 3),
                ],
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
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String label, int index) {
    return GestureDetector(
      onTap: () {
        Provider.of<PerformanceCategoryProvider>(context, listen: false)
            .setCategory(index);
        Provider.of<NavigationProvider>(context, listen: false)
            .setIndex(1); // PerformancePage index
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray3),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
