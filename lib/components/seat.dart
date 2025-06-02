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
          color: AppColors.gray5,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.32,
        ),
      ),
    );
  }
}

class SeatMapWidget extends StatefulWidget {
  final Map<String, List<int>> seatMap;
  final double seatSize;
  final double seatSpacing;
  final double aisleSpacing;
  final Set<String> selectedSeats;
  final Set<String> disabledSeats;
  final Set<String> reservedSeats;
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
  State<SeatMapWidget> createState() => _SeatMapWidgetState();
}

class _SeatMapWidgetState extends State<SeatMapWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: widget.seatMap.entries.map((entry) {
          String row = entry.key;
          List<int> seats = entry.value.toSet().toList();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: widget.seatSpacing,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: List.generate(12, (index) {
                      int seatNumber = index + 1;
                      String seatId = '$row$seatNumber';
                      bool isAvailable = seats.contains(seatNumber);
                      bool isSelected = widget.selectedSeats.contains(seatId);
                      bool isDisabled = widget.disabledSeats.contains(seatId);
                      bool isReserved = widget.reservedSeats.contains(seatId);

                      if (!isAvailable) {
                        return SizedBox(
                          width: seatNumber == 6
                              ? widget.seatSize + widget.aisleSpacing
                              : widget.seatSize,
                          height: widget.seatSize,
                        );
                      }

                      final seatBox = GestureDetector(
                        onTap: () => widget.onSeatTapped(seatId),
                        child: Container(
                          width: widget.seatSize,
                          height: widget.seatSize,
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
                            SizedBox(width: widget.aisleSpacing),
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
