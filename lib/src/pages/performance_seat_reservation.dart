import 'package:flutter/material.dart';
import '../../utility/color.dart';
import 'package:camticket/src/pages/ticket_purchase.dart';

class PerformanceSeatReservationPage extends StatefulWidget {
  const PerformanceSeatReservationPage({super.key});

  @override
  State<PerformanceSeatReservationPage> createState() =>
      _PerformanceSeatReservationPageState();
}

class _PerformanceSeatReservationPageState
    extends State<PerformanceSeatReservationPage> {
  final Set<String> _selectedSeats = {};
  final Set<String> _disabledSeats = {
    'A1',
    'A2',
    'A3',
    'A4',
    'A5',
    'A6',
    'A7',
    'A8',
    'A9',
    'A10',
    'A11',
    'A12',
    'C3',
    'C4'
  };
  final Set<String> _reservedSeats = {'B3', 'D4', 'E10', 'E11'};
  final int maxSelectableSeats = 4;
  final int alreadySelectedSeats = 2;

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
  Widget build(BuildContext context) {
    final seatMap = generateSeatMap();

    return Scaffold(
      backgroundColor: AppColors.mainBlack,
      appBar: AppBar(
        title: const Text('좌석 선택'),
        backgroundColor: AppColors.mainBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20, bottom: 8, top: 20),
              child: const Text(
                '선택된 회차',
                style: TextStyle(
                  color: AppColors.subPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
              child: Row(
                children: [
                  const Text(
                    '1공 : 2025.11.23(토) 16시 00분',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 30),
                  TextButton.icon(
                    onPressed: () {
                      final now = DateTime.now();
                      final eventDate =
                          DateTime(2026, 05, 11, 00); // 예: 1공 공연 시작 시간

                      if (now.isAfter(eventDate)) {
                        // 공연 시간이 지난 경우
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('예매가 종료된 공연입니다.'),
                            backgroundColor: const Color(0xFFCE3939),
                            duration: const Duration(seconds: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      } else {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (BuildContext context) {
                            return _ReservationModal();
                          },
                        );
                      }
                    },
                    label: const Text(
                      '회차 변경',
                      style: TextStyle(
                        color: AppColors.subPurple,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                      minimumSize: const Size(87, 25),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(
                          color: AppColors.subPurple, width: 1), // ✅ 테두리 추가
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100), // ✅ 모서리 둥글기
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColors.gray3, // 선 색상
              thickness: 0.5, // 선 두께
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20, bottom: 24, top: 20),
                child: Text.rich(
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
                        text: ' 입니다.\n아티스트의 정책에 따라 ',
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
                        text: '1인 4매',
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
                        text: ' 예매 가능합니다.',
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
                )),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  '무대',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFE5E5E5),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.32,
                  ),
                )),
            Container(
              width: 372,
              height: 400,
              child: Column(
                children: seatMap.entries.map((entry) {
                  String row = entry.key;
                  List<int> seats = entry.value.toSet().toList();

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: seatSpacing,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: List.generate(12, (index) {
                              int seatNumber = index + 1;
                              String seatId = '$row$seatNumber';
                              bool isAvailable = seats.contains(seatNumber);
                              bool isSelected = _selectedSeats.contains(seatId);
                              bool isDisabled = _disabledSeats.contains(seatId);
                              bool isReserved = _reservedSeats.contains(seatId);

                              if (!isAvailable) {
                                // 빈 자리
                                return SizedBox(
                                  width: seatNumber == 6
                                      ? seatSize + aisleSpacing
                                      : seatSize,
                                  height: seatSize,
                                );
                              }
                              final seatBox = GestureDetector(
                                onTap: (isDisabled || isReserved)
                                    ? null
                                    : () {
                                        setState(() {
                                          if (isSelected) {
                                            _selectedSeats.remove(seatId);
                                          } else {
                                            if (_selectedSeats.length <
                                                maxSelectableSeats -
                                                    alreadySelectedSeats) {
                                              _selectedSeats.add(seatId);
                                            } else {
                                              // 선택 제한 알림 (선택 사항)
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor:
                                                      Color(0xFFCE3939),
                                                  content: Text(
                                                    '⚠ 좌석은 최대 4개까지만 선택할 수 있습니다.',
                                                    style: TextStyle(),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 1),
                                                ),
                                              );
                                            }
                                          }
                                        });
                                      },
                                child: Container(
                                  width: seatSize,
                                  height: seatSize,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isDisabled
                                        ? AppColors.gray2
                                        : isSelected
                                            ? AppColors.mainPurple
                                            : isReserved
                                                ? AppColors.subPurple
                                                : AppColors.gray3,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: AppColors.gray4),
                                  ),
                                  child: Text(isDisabled ? 'X' : seatId,
                                      style: TextStyle(
                                        color: isDisabled
                                            ? Colors.red
                                            : isSelected
                                                ? AppColors.gray5
                                                : AppColors.mainBlack,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              );

                              if (seatNumber == 6) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    seatBox,
                                    SizedBox(width: aisleSpacing),
                                  ],
                                );
                              } else {
                                return seatBox;
                              }
                            }),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        color: AppColors.mainPurple,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '선택한 좌석',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  if (_selectedSeats.length == 0)
                    Container(
                      width: 372,
                      height: 56,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFCE3939),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 31,
                            top: 20,
                            child: Text(
                              '⚠ 좌석 선택 완료 후 다음 과정으로 넘어갈 수 있어요.',
                              style: TextStyle(
                                color: const Color(0xFFE5E5E5),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      width: 372,
                      height: 56,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: AppColors.mainBlack,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            child: Text(
                              _selectedSeats.join(', '),
                              style: TextStyle(
                                color: AppColors.subPurple,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print('선택된 좌석: $_selectedSeats');
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor:
                              AppColors.subPurple, // 버튼 색상 (원하는 색으로 변경 가능)
                        ),
                        child: const Text(
                          '선택 완료',
                          style: TextStyle(
                            color: AppColors.mainBlack,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('선택된 좌석: $_selectedSeats');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TicketPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(211, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor:
                              AppColors.mainPurple, // 버튼 색상 (원하는 색으로 변경 가능)
                        ),
                        child: const Text(
                          '다음',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReservationModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: MediaQuery.of(context).viewInsets, // 키보드 올라올 때 대응
        child: Container(
          width: 412,
          height: 218,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFF232323),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: const Color(0xFF3C3C3C),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          child: Stack(
            children: [
              const Positioned(
                left: 137,
                top: 20,
                child: Text(
                  '회차를 선택해주세요.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.32,
                  ),
                ),
              ),

              // 👉 1공
              Positioned(
                left: 20,
                top: 80,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // 모달 닫기
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PerformanceSeatReservationPage(),
                      ),
                    );
                  },
                  child: const Text(
                    '1공 : 2025.11.23(토) 16시 00분',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.32,
                    ),
                  ),
                ),
              ),

              // 👉 2공
              Positioned(
                left: 20,
                top: 139,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PerformanceSeatReservationPage(),
                      ),
                    );
                  },
                  child: const Text(
                    '2공 : 2025.11.23(토) 19시 30분',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.32,
                    ),
                  ),
                ),
              ),

              // 구분선들
              Positioned(
                left: 0,
                top: 60,
                child: Container(
                  width: 412,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF3C3C3C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 119,
                child: Container(
                  width: 412,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF3C3C3C),
                      ),
                    ),
                  ),
                ),
              ),

              // 닫기 버튼
              Positioned(
                left: 368,
                top: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(color: Color(0xFF232323)),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
