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

import 'package:camticket/components/seat.dart';
import 'package:camticket/model/performance_create/seat_unavailable_schedule_request.dart';
import 'package:camticket/src/pages/artist/register_detail_page.dart';
import 'package:camticket/src/pages/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/buttons.dart';
import '../../../provider/performance_upload_provider.dart';

class UnableSeatPage extends StatefulWidget {
  final List<String> selectedSeats;

  UnableSeatPage({super.key, required this.selectedSeats});
  @override
  State<UnableSeatPage> createState() => _UnableSeatPageState();
}

class _UnableSeatPageState extends State<UnableSeatPage> {
  late final List<String> _roundKeys; // '날짜|시간' 형식
  String? _selectedRoundKey;
  final Map<String, Set<String>> _disabledSeatsMap = {};

  final Set<String> _disabledSeats = {};
  final Set<String> _reservedSeats = {};
  final int maxSelectableSeats = 4;
  final int alreadySelectedSeats = 2;
  final Set<String> _selectedSeats = {};
  final double seatSize = 26;
  final double seatSpacing = 2;
  final double aisleSpacing = 10;
  Map<String, List<int>> generateSeatMap() {
    Map<String, List<int>> seatMap = {};
    for (int i = 0; i < 12; i++) {
      String row = String.fromCharCode('A'.codeUnitAt(0) + i);
      if (row == 'L') {
        seatMap[row] = List.generate(6, (index) => index + 4); // 4~9
      } else {
        seatMap[row] = List.generate(12, (index) => index + 1); // 1~12
      }
    }
    return seatMap;
  }

  @override
  void initState() {
    super.initState();
    final schedules = context.read<PerformanceUploadProvider>().schedules;

    _roundKeys = schedules
        .map((schedule) =>
            '${schedule.scheduleIndex}|${schedule.startTime.toIso8601String()}')
        .toList();
    debugPrint('Round Keys: $_roundKeys');
    _selectedRoundKey = _roundKeys.first;
  }

  @override
  Widget build(BuildContext context) {
    final seatMap = generateSeatMap();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
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
                  MaterialPageRoute(builder: (context) => const Searchpage()),
                );
              },
              icon: const Icon(
                Icons.search,
                size: 24,
              ),
            )
          ],
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32),
                        white28('예매 불가 좌석 배치'),
                        SizedBox(height: 20),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '해당 공연장소는 ',
                                style: TextStyle(
                                  color: const Color(0xFFE5E5E5),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 1.43,
                                  letterSpacing: -0.28,
                                ),
                              ),
                              TextSpan(
                                text: '학관 104호',
                                style: TextStyle(
                                  color: const Color(0xFFE4C3FF),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 1.43,
                                  letterSpacing: -0.28,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' 입니다.\n각 좌석을 클릭하여 관람객이 예매 불가한 좌석을 지정합니다.\n(초대석, 고장난 좌석 등)',
                                style: TextStyle(
                                  color: const Color(0xFFE5E5E5),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 1.43,
                                  letterSpacing: -0.28,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownButton<String>(
                      value: _selectedRoundKey,
                      dropdownColor: Colors.grey[900],
                      isExpanded: true,
                      style: const TextStyle(color: Colors.white),
                      items: _roundKeys.map((key) {
                        final parts = key.split('|');
                        if (parts.length < 2) {
                          return DropdownMenuItem(
                            value: key,
                            child: Text('Invalid Key Format'),
                          );
                        }

                        final scheduleIndex = parts[0];
                        final dateStr = parts[1];
                        final date = DateTime.tryParse(dateStr);

                        return DropdownMenuItem(
                          value: key,
                          child: Text(
                            date != null
                                ? '회차 $scheduleIndex / ${date.toLocal().toString().split(' ')[0]}'
                                : 'Invalid Date',
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRoundKey = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  SeatStageSection(),
                  SizedBox(height: 10),
                  SeatMapWidget(
                    seatMap: seatMap,
                    seatSize: MediaQuery.of(context).size.width / 13 - 2,
                    seatSpacing: seatSpacing,
                    aisleSpacing: aisleSpacing,
                    selectedSeats: _selectedSeats,
                    disabledSeats: _disabledSeatsMap[_selectedRoundKey] ?? {},
                    reservedSeats: _reservedSeats,
                    maxSelectableSeats: maxSelectableSeats,
                    alreadySelectedSeats: alreadySelectedSeats,
                    onSeatTapped: (seatId) {
                      setState(() {
                        final seats = _disabledSeatsMap.putIfAbsent(
                            _selectedRoundKey!, () => <String>{});
                        if (seats.contains(seatId)) {
                          seats.remove(seatId);
                        } else {
                          seats.add(seatId);
                        }
                      });
                    },
                  ),
                  SizedBox(height: 200),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, widget.selectedSeats);
                  },
                  child: subPurpleBtn4518(
                    '이전',
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      final provider =
                          context.read<PerformanceUploadProvider>();
                      final schedules = provider.schedules;

                      final List<SeatUnavailableScheduleRequest> results = [];

                      for (final schedule in schedules) {
                        final key =
                            '${schedule.scheduleIndex}|${schedule.startTime.toIso8601String()}';
                        final seatIds = _disabledSeatsMap[key];
                        if (seatIds != null && seatIds.isNotEmpty) {
                          results.add(SeatUnavailableScheduleRequest(
                            scheduleIndex: schedule.scheduleIndex,
                            codes: seatIds.toList(),
                          ));
                        }
                      }

                      if (results.length < _roundKeys.length) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("모든 회차에 대해 좌석을 지정해주세요.")),
                        );
                        return;
                      }

                      provider.setPage2UnavailableSeats(results);

                      //provider.showPage2UnavailableSeats();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterDetailPage(),
                        ),
                      );
                    },
                    child: mainPurpleBtn18107('다음')),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
