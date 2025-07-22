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

import 'package:camticket/components/buttons.dart';
import 'package:camticket/src/pages/artist/reservation_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/texts.dart';
import '../../../model/manage_overview.dart';
import '../../../provider/manage_overview_provider.dart';
import '../searchpage.dart';

class ReservationManagePage extends StatefulWidget {
  const ReservationManagePage({super.key});
  @override
  State<ReservationManagePage> createState() => _ReservationManagePageState();
}

class _ReservationManagePageState extends State<ReservationManagePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ManageOverviewProvider>(context, listen: false)
          .fetchManageOverview();
    });
  }

  @override
  Widget build(BuildContext context) {
    final manageOverviewProvider =
        Provider.of<ManageOverviewProvider>(context, listen: true);
    final now = DateTime.now();

    final ongoingPerformances = manageOverviewProvider.performances
        .where((p) => p.lastScheduleDateTime.isAfter(now))
        .toList();

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
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
                        Navigator.pop(context);
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
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      white28('관람객 예매 확인 및 관리'),
                      const SizedBox(height: 16),
                      white16('진행중인 공연'),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildPosterGrid(ongoingPerformances),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget _buildPosterGrid(List<ManageOverview> performances) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: performances.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 136 / 194,
      ),
      itemBuilder: (context, index) {
        final item = performances[index];
        return GestureDetector(
          onTap: () {
            debugPrint('포스터 ${item.postId} 클릭됨');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReservationDetailPage(postId: item.postId)),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF5C5C5C),
              borderRadius: BorderRadius.circular(2),
              image: DecorationImage(
                image: NetworkImage(item.profileImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
