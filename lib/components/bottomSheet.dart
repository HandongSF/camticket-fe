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

import 'package:camticket/model/schedule_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/performanceDetail.dart';
import '../utility/color.dart';

void showRoundSelectBottomSheet(
    BuildContext context,
    Function(ScheduleDetail, int) onSelect, // ✅ Schedule을 인자로 받도록 수정
    List<ScheduleDetail> scheduleDetails,
    List<Schedule> schedules) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.black,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: const Text(
                      '회차를 선택해주세요.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(color: AppColors.gray2),
              ...schedules.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final schedule = entry.value;
                // final formattedDate = DateFormat('yyyy.MM.dd(E)', 'ko')
                //     .format(schedule.startTime as DateTime);
                // final formattedTime =
                //     DateFormat('HH시 mm분').format(schedule.startTime as DateTime);

                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        '${schedule.scheduleIndex}공 : ${scheduleDetails[schedule.scheduleIndex].startTime}',
                        // '$formattedDate $formattedTime',
                        style: const TextStyle(color: AppColors.white),
                      ),
                      onTap: () async {
                        debugPrint('schedules : ${schedules[0].scheduleIndex}');
                        Navigator.pop(context);
                        onSelect(scheduleDetails[schedule.scheduleIndex],
                            schedule.scheduleIndex); // 선택 시 콜백 호출
                      },
                    ),
                    const Divider(color: AppColors.gray2),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      );
    },
  );
}
