import 'package:camticket/components/dividers.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';

class PerformanceRoundsWidget extends StatefulWidget {
  const PerformanceRoundsWidget({super.key});

  @override
  State<PerformanceRoundsWidget> createState() =>
      _PerformanceRoundsWidgetState();
}

class _PerformanceRoundsWidgetState extends State<PerformanceRoundsWidget> {
  List<TextEditingController> _controllers = [TextEditingController()];

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
