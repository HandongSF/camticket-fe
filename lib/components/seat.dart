import 'package:flutter/material.dart';
import '../utility/color.dart';

class SeatStageSection extends StatelessWidget {
  const SeatStageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 12),
      child: const Text(
        '무대',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFFE5E5E5),
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.32,
        ),
      ),
    );
  }
}

class SeatMapWidget extends StatelessWidget {
  final Map<String, List<int>> seatMap;
  final double seatSize;
  final double seatSpacing;
  final double aisleSpacing;
  final List<String> selectedSeats;
  final List<String> disabledSeats;
  final List<String> reservedSeats;
  final int maxSelectableSeats;
  final int alreadySelectedSeats;
  final void Function(String seatId) onSeatTapped;

  const SeatMapWidget({
    super.key,
    required this.seatMap,
    required this.seatSize,
    required this.seatSpacing,
    required this.aisleSpacing,
    required this.selectedSeats,
    required this.disabledSeats,
    required this.reservedSeats,
    required this.maxSelectableSeats,
    required this.alreadySelectedSeats,
    required this.onSeatTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      bool isSelected = selectedSeats.contains(seatId);
                      bool isDisabled = disabledSeats.contains(seatId);
                      bool isReserved = reservedSeats.contains(seatId);

                      if (!isAvailable) {
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
                            : () => onSeatTapped(seatId),
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
                          child: Text(
                            isDisabled ? 'X' : seatId,
                            style: TextStyle(
                              color: isDisabled
                                  ? Colors.red
                                  : isSelected
                                      ? AppColors.gray5
                                      : AppColors.mainBlack,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}
