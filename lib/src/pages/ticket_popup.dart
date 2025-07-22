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

import 'dart:ui';

import 'package:camticket/components/buttons.dart';
import 'package:camticket/provider/user_provider.dart';
import 'package:camticket/utility/category_btn.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../components/dashed_divider.dart';
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

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    Future.microtask(
        () => context.read<ReservationOverviewProvider>().fetchReservations());
    Future.microtask(() => context.read<UserProvider>().fetchUser());
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index, List reservations) {
    if (index >= 0 && index < reservations.length) {
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
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

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
            child: reservationProvider.isLoading && userProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : reservationProvider.error != null || userProvider.isLoading
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
                                      itemCount: reservations.length,
                                      onPageChanged: (index) {
                                        setState(() => _currentPage = index);
                                      },
                                      itemBuilder: (context, index) {
                                        final ticket = reservations[index];
                                        final bool isPast = ticket
                                            .performanceDate
                                            .isBefore(DateTime.now());
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
                                              // 💡 반투명 블랙 레이어 추가
                                              Container(
                                                width: screenWidth * 0.7,
                                                height: screenWidth * 5,
                                                color: Colors.black.withOpacity(
                                                    isPast ? 0.6 : 0.4),
                                              ),
                                              if (isPast) ...[
                                                // 배경을 흐리게 처리 (Blur)
                                                Positioned.fill(
                                                  child: ClipRect(
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 5.5,
                                                          sigmaY: 5.5),
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // 가운데에 약간 돌린 sold.png 오버레이
                                                Center(
                                                  child: Transform.rotate(
                                                    angle:
                                                        -0.22, // 라디안 단위 (약 -12도)
                                                    child: Image.asset(
                                                      'assets/sold.png', // 또는 'assets/images/sold.png'
                                                      width: screenWidth * 0.45,
                                                      opacity:
                                                          const AlwaysStoppedAnimation(
                                                              0.90),
                                                    ),
                                                  ),
                                                ),
                                              ],

                                              ticket.performanceDate
                                                      .isAfter(DateTime.now())
                                                  ? Positioned(
                                                      top: 20,
                                                      right: 20,
                                                      child: RotationTransition(
                                                        turns:
                                                            _rotationController,
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
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
                                                    )
                                                  : SizedBox(),
                                              Positioned.fill(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      // 중간: 좌석 정보, 예매자

                                                      SizedBox(
                                                        height: 50,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Text('좌석정보',
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .mainPurple,
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              '${ticket.selectedSeats}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14)),
                                                          const SizedBox(
                                                              height: 4),
                                                          const Text('예매자 정보',
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .mainPurple,
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              '${user!.name} ${ticket.ticketOptionName}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14)),
                                                        ],
                                                      ),
                                                      DashedDivider(
                                                        height: 2, // 두께
                                                        dashWidth:
                                                            15, // 한 줄의 길이 (이미지처럼 길게)
                                                        dashSpace:
                                                            20, // 줄과 줄 사이 간격
                                                        color: Color(
                                                            0xFF828282), // 밝은 회색 (이미지 참고)
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              buildGradientBadge(
                                                                '아티스트',
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                  ticket
                                                                      .artistName,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                          Text(
                                                              '${ticket.performanceTitle}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14)),
                                                          const SizedBox(
                                                              height: 4),
                                                          Text(
                                                              '${ticket.performanceDate}',
                                                              style: const TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .gray4,
                                                                  fontSize:
                                                                      14)),
                                                          const SizedBox(
                                                              height: 4),
                                                          Text(
                                                              '${ticket.location}',
                                                              style: const TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .gray4,
                                                                  fontSize:
                                                                      14)),
                                                          SizedBox(
                                                            height: 40,
                                                          )
                                                        ],
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
                                        onPressed: () => _goToPage(
                                            _currentPage - 1, reservations),
                                      ),
                                    ),
                                    Positioned(
                                      right: -10,
                                      child: IconButton(
                                        icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: AppColors.gray5,
                                            size: 12),
                                        onPressed: () => _goToPage(
                                            _currentPage + 1, reservations),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${_currentPage + 1} / ${reservations.length}',
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
