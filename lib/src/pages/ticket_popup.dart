import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../provider/ticket_provider.dart';

class TicketPopup extends StatefulWidget {
  const TicketPopup({super.key});

  @override
  State<TicketPopup> createState() => _TicketPopupState();
}

class _TicketPopupState extends State<TicketPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> ticketImages = [
    'assets/images/gospel.png',
    'assets/images/gospel.png',
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    Future.microtask(
        () => context.read<ReservationOverviewProvider>().fetchReservations());
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
    final reservationProvider = context.watch<ReservationOverviewProvider>();
    final reservations = reservationProvider.reservations;

    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Colors.black.withOpacity(0.3),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.only(top: 0, bottom: 24),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: reservationProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : reservationProvider.error != null
                    ? Center(
                        child: Text(
                          reservationProvider.error!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    : reservations.isEmpty
                        ? const Center(
                            child: Text('예매 내역이 없습니다.',
                                style: TextStyle(color: Colors.white)),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: IconButton(
                                    icon: const Icon(Icons.close,
                                        color: Colors.white),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.7,
                                height: screenWidth * 1.3,
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
                                        final ticket = reservations[index];
                                        return ClipPath(
                                          clipper: TicketClipper(),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                ticket
                                                    .performanceProfileImageUrl,
                                                width: screenWidth * 0.7,
                                                height: screenWidth * 5,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Container(
                                                  width: screenWidth * 0.7,
                                                  color: AppColors.gray2,
                                                  child: const Center(
                                                    child: Text(
                                                      '이미지 없음',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 20,
                                                right: 20,
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
                                    Positioned(
                                      left: -10,
                                      child: IconButton(
                                        icon: const Icon(Icons.arrow_back_ios,
                                            color: AppColors.gray5, size: 12),
                                        onPressed: () =>
                                            _goToPage(_currentPage - 1),
                                      ),
                                    ),
                                    Positioned(
                                      right: -10,
                                      child: IconButton(
                                        icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: AppColors.gray5,
                                            size: 12),
                                        onPressed: () =>
                                            _goToPage(_currentPage + 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${_currentPage + 1} / ${ticketImages.length}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
          ),
        ),
      ],
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double smallRadius = 10.0;
    const double bigRadius = 45.0; // 기존 20 → 더 큼

    final path = Path();

    // 상단
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.10 - smallRadius, 0);
    path.arcToPoint(
      Offset(size.width * 0.10 + smallRadius, 0),
      radius: Radius.circular(smallRadius),
      clockwise: false,
    );
    path.lineTo(size.width * 0.23 - smallRadius, 0);
    path.arcToPoint(
      Offset(size.width * 0.23 + smallRadius, 0),
      radius: Radius.circular(smallRadius),
      clockwise: false,
    );
    path.lineTo(size.width * 0.5 - bigRadius, 0);
    path.arcToPoint(
      Offset(size.width * 0.5 + bigRadius, 0),
      radius: Radius.circular(bigRadius),
      clockwise: false,
    );
    path.lineTo(size.width * 0.77 - smallRadius, 0);
    path.arcToPoint(
      Offset(size.width * 0.77 + smallRadius, 0),
      radius: Radius.circular(smallRadius),
      clockwise: false,
    );
    path.lineTo(size.width * 0.90 - smallRadius, 0);
    path.arcToPoint(
      Offset(size.width * 0.90 + smallRadius, 0),
      radius: Radius.circular(smallRadius),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);

    // 하단
    path.lineTo(size.width * 0.10 + smallRadius, size.height);
    path.arcToPoint(
      Offset(size.width * 0.10 - smallRadius, size.height),
      radius: Radius.circular(smallRadius),
      clockwise: false,
    );
    path.lineTo(size.width * 0.23 + smallRadius, size.height);
    path.arcToPoint(
      Offset(size.width * 0.23 - smallRadius, size.height),
      radius: Radius.circular(smallRadius),
      clockwise: false,
    );
    path.lineTo(size.width * 0.5 + bigRadius, size.height);
    path.arcToPoint(
      Offset(size.width * 0.5 - bigRadius, size.height),
      radius: Radius.circular(bigRadius),
      clockwise: false,
    );
    path.lineTo(size.width * 0.77 + smallRadius, size.height);
    path.arcToPoint(
      Offset(size.width * 0.77 - smallRadius, size.height),
      radius: Radius.circular(smallRadius),
      clockwise: false,
    );
    path.lineTo(size.width * 0.90 + smallRadius, size.height);
    path.arcToPoint(
      Offset(size.width * 0.90 - smallRadius, size.height),
      radius: Radius.circular(smallRadius),
      clockwise: false,
    );
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
