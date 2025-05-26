import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';

Widget dividerGray2() {
  return Container(
    width: double.infinity,
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          strokeAlign: BorderSide.strokeAlignCenter,
          color: AppColors.gray2,
        ),
      ),
    ),
  );
}
