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
  final Map<DateTime, List<String>> _scheduleMap = {}; // key: 날짜, value: 회차 리스트

  final List<TextEditingController> _controllers = [TextEditingController()];
  Future<void> _addSchedule(int i) async {
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

    final formattedTime = pickedTime.format(context);

    setState(() {
      _controllers[i].text =
          '${pickedDate.year}-${pickedDate.month}-${pickedDate.day} $formattedTime';
      final dateKey =
          DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
      if (!_scheduleMap.containsKey(dateKey)) {
        _scheduleMap[dateKey] = [];
      }
      _scheduleMap[dateKey]!.add(formattedTime);

      _notifyParent();
    });
  }

  void _notifyParent() {
    final result = _scheduleMap.entries.map((entry) {
      return ScheduleRequest(date: entry.key, rounds: entry.value);
    }).toList();
    widget.onChanged(result);
  }

  void _addRound() {
    setState(() {
      _controllers.add(TextEditingController());
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
                            _addSchedule(i);
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
            onTap: _addRound,
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
