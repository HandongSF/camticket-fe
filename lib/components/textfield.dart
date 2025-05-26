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
