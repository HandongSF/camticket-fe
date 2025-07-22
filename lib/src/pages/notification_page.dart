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

import 'package:flutter/material.dart';
import '../../utility/color.dart';
import 'dart:async';

class NotificationItem {
  final String message;
  final DateTime timestamp;
  final String imageUrl;

  NotificationItem(this.message, this.timestamp, this.imageUrl);
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      '아티스트 피치파이프 공연 🎵 The Gospel : Who we are 예매가 완료되었습니다.',
      DateTime.now().subtract(const Duration(days: 1)),
      'assets/images/zzanggu.png', // 예시 이미지
    ),
    NotificationItem(
      '아티스트 갓스펠로우 공연이 업데이트 되었습니다.',
      DateTime.now().subtract(const Duration(days: 2)),
      'assets/images/zzanggu.png',
    ),
    NotificationItem(
      '아티스트 MIC 공연이 업데이트 되었습니다.',
      DateTime.now().subtract(const Duration(days: 3)),
      'assets/images/zzanggu.png',
    ),
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 1분마다 화면 새로고침 (timeAgo 갱신용)
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 타이머 해제
    super.dispose();
  }

  String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return '방금 전';
    if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
    if (diff.inHours < 24) return '${diff.inHours}시간 전';
    return '${diff.inDays}일 전';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBlack,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '알림',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _notifications.isEmpty
                  ? const Center(
                child: Text(
                  '알림이 없습니다.',
                  style: TextStyle(
                    color: Color(0xFF818181),
                    fontSize: 12,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final item = _notifications[index];
                  return  Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart, // 오른쪽 → 왼쪽 스와이프
                      background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      _notifications.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('알림이 삭제되었습니다.')),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(12, 15, 20, 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF232323),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 이미지
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              item.imageUrl,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // 메시지 텍스트
                          Expanded(
                            child: Text(
                              item.message,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // 시간
                          Text(
                            timeAgo(item.timestamp),
                            style: const TextStyle(
                              color: Color(0xFF818181),
                              fontSize: 12,
                            ),
                          ),
                        ],
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
