import 'package:flutter/material.dart';

import '../utility/color.dart';

Widget subPurpleText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.subPurple,
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      letterSpacing: -0.32,
    ),
  );
}

Widget whiteTitleText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.white,
      fontSize: 28,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget gray412(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppColors.gray4,
      fontSize: 12,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.24,
    ),
  );
}

Widget white16(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppColors.white,
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.32,
    ),
  );
}
