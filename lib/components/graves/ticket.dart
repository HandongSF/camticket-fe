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

import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../provider/ticket_provider.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

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

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
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
                        children: [
                          Expanded(
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
                                    return Center(
                                      child: Stack(
                                        children: [
                                          ClipPath(
                                            clipper: TicketClipper(),
                                            child: Image.network(
                                              ticket.performanceProfileImageUrl,
                                              width: screenWidth * 0.7,
                                              fit: BoxFit.fitWidth,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Container(
                                                width: screenWidth * 0.7,
                                                height: 240,
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
                                    onPressed: () =>
                                        _goToPage(_currentPage - 1),
                                  ),
                                ),
                                // ▶ 오른쪽 버튼
                                Positioned(
                                  right: 16,
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_forward_ios,
                                        color: AppColors.gray5, size: 12),
                                    onPressed: () =>
                                        _goToPage(_currentPage + 1),
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
