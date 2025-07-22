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

import 'package:camticket/src/pages/artist_page.dart';
import 'package:camticket/src/pages/my_page.dart';
import 'package:camticket/src/pages/notification_page.dart';
import 'package:camticket/src/pages/performance_page.dart';
import 'package:camticket/src/pages/user/reservation_check.dart';
import 'package:camticket/src/pages/searchpage.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/navigation_provider.dart';
import 'pages/home_page.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    final List<Widget> pages = [
      const HomePage(), // 홈
      const PerformancePage(),
      const ArtistPage(), // 아티스트
      const NotificationPage(), // 알림
      navigationProvider.subPage == 'reservation'
          ? const ReservationCheckPage()
          : const Mypage(),
    ];

    return Scaffold(
      appBar: navigationProvider.selectedIndex == 0 ||
              navigationProvider.selectedIndex == 1 ||
              navigationProvider.selectedIndex == 4
          ? AppBar(
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
                        if (navigationProvider.selectedIndex == 4) {
                          navigationProvider.setSubPage('default');
                        } else if (navigationProvider.selectedIndex == 1) {
                          navigationProvider.setSubPage('default');
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    Image.asset(
                      'assets/images/navi logo.png',
                      width: 110,
                      height: 28,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Searchpage()),
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 24,
                      ),
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
            )
          : null,
      body: pages[navigationProvider.selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        color: const Color(0xFF131313),
        child: BottomNavigationBar(
          iconSize: 24,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.mainBlack,
          selectedItemColor: AppColors.mainPurple,
          unselectedItemColor: AppColors.gray3,
          currentIndex: navigationProvider.selectedIndex,
          onTap: (index) {
            navigationProvider.setIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.festival),
              label: '공연',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: '아티스트',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              label: '알림',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '마이',
            ),
          ],
        ),
      ),
    );
  }
}
