import 'package:flutter/material.dart';

import '../utility/color.dart';

Widget phoneInput(TextEditingController controller, {String? hint}) {
  return SizedBox(
    width: 70,
    height: 24,
    child: Center(
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 16,
          height: 1,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.gray5),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          filled: true,
          fillColor: AppColors.gray2,
          border: OutlineInputBorder(),
          isDense: true,
        ),
      ),
    ),
  );
}
