import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/navigation_provider.dart';
import '../../provider/pc_provider.dart';
import '../../utility/color.dart';
import 'performance_detail_page.dart';


class PerformancePage extends StatefulWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  int selectedSort = 0; // 등록순(0) / 최신순(1)

  final List<String> categories = ['음악', '연극 / 뮤지컬', '댄스', '전시'];

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
    final categoryProvider = Provider.of<PerformanceCategoryProvider>(context);
    final selectedCategory = categoryProvider.selectedCategory;
    return Scaffold(
      backgroundColor: AppColors.mainBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '공연',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(categories.length, (index) {
                  final isSelected = selectedCategory == index;
                  return GestureDetector(
                    onTap: () {
                      categoryProvider.setCategory(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.subPurple
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.gray3),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.mainBlack
                              : AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSort = 0;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          '등록',
                          style: TextStyle(
                            color: selectedSort == 0
                                ? AppColors.white
                                : AppColors.gray4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Icon(Icons.keyboard_arrow_down,
                        //     color: AppColors.gray4, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSort = 1;
                      });
                    },
                    child: Text(
                      '최신순',
                      style: TextStyle(
                        color: selectedSort == 1
                            ? AppColors.white
                            : AppColors.gray4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: performances.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = performances[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<NavigationProvider>()
                            .setSubPage('performanceDetail');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PerformanceDetailPage()),
                        );
                      },
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          borderRadius: BorderRadius.circular(20),
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
                                                color: const Color(0xFFE4C3FF),
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
                    ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
