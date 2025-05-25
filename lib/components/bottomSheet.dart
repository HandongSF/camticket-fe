import 'package:flutter/material.dart';

import '../utility/color.dart';

void showRoundSelectBottomSheet(
  BuildContext context,
  Future push,
) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.black,
    builder: (context) {
      return Padding(
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
            ListTile(
              title: Text(
                '1공 : 2025.11.23(토) 16시 00분',
                style: TextStyle(color: AppColors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                push;
              },
            ),
            const Divider(color: AppColors.gray2),
            ListTile(
              title: Text(
                '2공 : 2025.11.23(토) 19시 30분',
                style: TextStyle(color: AppColors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                push;
              },
            ),
          ],
        ),
      );
    },
  );
}
