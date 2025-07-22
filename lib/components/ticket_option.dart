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

import 'package:camticket/model/performance_create/ticket_option_request.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';

class PerformanceRoundsWidget2 extends StatefulWidget {
  final void Function(List<TicketOptionRequest>) onChanged;

  const PerformanceRoundsWidget2({super.key, required this.onChanged});

  @override
  State<PerformanceRoundsWidget2> createState() =>
      _PerformanceRoundsWidgetState();
}

class _PerformanceRoundsWidgetState extends State<PerformanceRoundsWidget2> {
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  //요금 추가 메서드 (추가 개발시 활성화)
  // void _addRound() {
  //   setState(() {
  //     _controllers.add(TextEditingController());
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (final c in _controllers) {
      c.addListener(_notifyParent);
    }
  }

  void _notifyParent() {
    final ticketOptions = [
      TicketOptionRequest(
        name: '일반',
        price: int.tryParse(_controllers[0].text.trim()) ?? 0,
      ),
      TicketOptionRequest(
        name: '새내기',
        price: int.tryParse(_controllers[1].text.trim()) ?? 0,
      ),
    ];
    widget.onChanged(ticketOptions);
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
          //for (int i = 0; i < _controllers.length; i++)
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
                      '일반',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controllers[0],
                        decoration: InputDecoration(
                          hintText: '티켓 가격을 입력하세요.',
                          hintStyle:
                              const TextStyle(color: AppColors.gray4), // gray4
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(color: AppColors.gray2, width: 1), // gray2
            )),
            child: Row(
              children: [
                Text(
                  '새내기',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _controllers[1],
                    decoration: InputDecoration(
                      hintText: '티켓 가격을 입력하세요.',
                      hintStyle:
                          const TextStyle(color: AppColors.gray4), // gray4
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
          ),
          // GestureDetector(
          //   onTap: () {
          //     _addRound();
          //     _notifyParent(); // 새로운 항목 추가 후도 갱신
          //   },
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          //     child: Row(
          //       children: [
          //         const SizedBox(width: 8),
          //         const Text(
          //           '+ 티켓 가격 옵션 추가',
          //           style: TextStyle(
          //             color: AppColors.gray5,
          //             fontSize: 16,
          //             fontFamily: 'Inter',
          //             fontWeight: FontWeight.w400,
          //             height: 1.12,
          //             letterSpacing: -0.32,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
