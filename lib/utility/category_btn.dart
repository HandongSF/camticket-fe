import 'package:flutter/material.dart';

import 'color.dart';

Widget buildCategoryButton(String text) {
  return Container(
    clipBehavior: Clip.antiAlias,
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.gray3, width: 1),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 14,
      ),
    ),
  );
}
