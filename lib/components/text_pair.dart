import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';

Widget grayAndWhite(String text, String text2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 44,
        child: Text(
          text,
          softWrap: false,
          style: TextStyle(
            color: AppColors.gray4,
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.24,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
      SizedBox(
        width: 75,
        child: Text(
          text2,
          softWrap: false,
          style: TextStyle(
            color: AppColors.gray5,
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.24,
            overflow: TextOverflow.visible,
          ),
          textAlign: TextAlign.left,
        ),
      )
    ],
  );
}
