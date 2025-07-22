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

import '../model/performance_create/schedule_request.dart';

class PerformanceRoundsWidget extends StatefulWidget {
  final void Function(List<ScheduleRequest>) onChanged;

  const PerformanceRoundsWidget({
    super.key,
    required this.onChanged,
  });

  @override
  State<PerformanceRoundsWidget> createState() =>
      _PerformanceRoundsWidgetState();
}

class _PerformanceRoundsWidgetState extends State<PerformanceRoundsWidget> {
  final List<TextEditingController> _controllers = [TextEditingController()];
  final List<DateTime?> _dateTimes = [null];
  Future<void> _pickSchedule(int index) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final dateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      _dateTimes[index] = dateTime;
      _controllers[index].text =
          '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} '
          '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';

      _notifyParent();
    });
  }

  void _notifyParent() {
    final result = <ScheduleRequest>[];

    for (int i = 0; i < _dateTimes.length; i++) {
      final dt = _dateTimes[i];
      if (dt != null) {
        result.add(ScheduleRequest(scheduleIndex: i, startTime: dt));
      }
    }

    widget.onChanged(result);
  }

  void _addRound() {
    setState(() {
      _controllers.add(TextEditingController());
      _dateTimes.add(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF242424), // gray1
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray2), // gray2
      ),
      child: Column(
        children: [
          for (int i = 0; i < _controllers.length; i++)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: AppColors.gray2, width: 1), // gray2
              )),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${i + 1}공',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controllers[i],
                          readOnly: true,
                          onTap: () {
                            _pickSchedule(i);
                          },
                          decoration: InputDecoration(
                            hintText: '공연 날짜와 시간을 선택하세요.',
                            hintStyle: const TextStyle(
                                color: AppColors.gray4), // gray4
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          GestureDetector(
            onTap: () {
              _addRound();
              _notifyParent(); // 새로운 항목 추가 후도 갱신
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  const Text(
                    '+ 관람 회차 추가',
                    style: TextStyle(
                      color: AppColors.gray5,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.12,
                      letterSpacing: -0.32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
