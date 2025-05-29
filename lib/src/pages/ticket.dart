import 'dart:math' as math;
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> ticketImages = [
    'assets/images/gospel.png',
    'assets/images/gospel.png', // 추가 이미지 필요시 여기에 추가
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    if (index >= 0 && index < ticketImages.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: ticketImages.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: Stack(
                          children: [
                            ClipPath(
                              clipper: TicketClipper(),
                              child: Image.asset(
                                ticketImages[index],
                                width: screenWidth * 0.7,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Positioned(
                              top: 40,
                              right: 40,
                              child: RotationTransition(
                                turns: _rotationController,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/mark.svg',
                                      width: 60,
                                      height: 60,
                                    ),
                                    Image.asset(
                                      'assets/images/sticker.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // ◀ 왼쪽 버튼
                  Positioned(
                    left: 16,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.gray5,
                        size: 12,
                      ),
                      onPressed: () => _goToPage(_currentPage - 1),
                    ),
                  ),
                  // ▶ 오른쪽 버튼
                  Positioned(
                    right: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: AppColors.gray5, size: 12),
                      onPressed: () => _goToPage(_currentPage + 1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${_currentPage + 1} / ${ticketImages.length}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const radius = 30.0;
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width / 2 - radius, 0);
    path.arcToPoint(
      Offset(size.width / 2 + radius, 0),
      radius: const Radius.circular(radius),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2 + radius, size.height);
    path.arcToPoint(
      Offset(size.width / 2 - radius, size.height),
      radius: const Radius.circular(radius),
      clockwise: false,
    );
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
