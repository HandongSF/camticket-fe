import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/navigation_provider.dart';
import '../provider/pc_provider.dart';

Widget mainPurpleBtn(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      height: 56,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.mainPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 157,
            top: 18,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.32,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildCategoryButton(BuildContext context, String label, int index) {
  return GestureDetector(
    onTap: () {
      Provider.of<PerformanceCategoryProvider>(context, listen: false)
          .setCategory(index);
      Provider.of<NavigationProvider>(context, listen: false)
          .setIndex(1); // PerformancePage index
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 1.43,
          letterSpacing: 0.10,
        ),
      ),
    ),
  );
}

Widget subPurpleBtn(String text) {
  return Container(
    width: 47,
    height: 14,
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: const Color(0xFFE4C3FF),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 8,
          top: 2,
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.subPurple,
              fontSize: 8,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.25,
              letterSpacing: -0.16,
            ),
          ),
        ),
      ],
    ),
  );
}
