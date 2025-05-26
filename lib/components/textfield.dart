import 'package:flutter/material.dart';

import '../utility/color.dart';

Widget textField5(String hintText, TextEditingController controller) {
  return TextField(
    controller: controller,
    maxLines: 5,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: AppColors.gray4),
      filled: true,
      fillColor: AppColors.gray1,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.gray2,
          width: 1.0,
        ),
      ),
    ),
    style: const TextStyle(color: Colors.white),
  );
}

Widget buildPhoneNumber(String text) {
  return Container(
    width: 80,
    height: 24,
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: const Color(0xFF232323),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: const Color(0xFF3C3C3C),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 8,
          top: 3,
          child: Text(
            text,
            style: TextStyle(
              color: const Color(0xFFE5E5E5),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.32,
              height: 1,
            ),
          ),
        ),
      ],
    ),
  );
}
