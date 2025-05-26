import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/navigation_provider.dart';
import '../provider/pc_provider.dart';
import '../src/pages/my_page.dart';

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
            child: Center(
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

Widget subPurpleBtn16(String text) {
  return Container(
    width: 111,
    height: 25,
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
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.subPurple,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 1.25,
          letterSpacing: -0.16,
        ),
      ),
    ),
  );
}

Widget white28(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppColors.white,
      fontSize: 28,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget buildGradientButton(
  BuildContext context, {
  required String label,
  required UserInfo? userInfo,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context, userInfo);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [Color(0xFFFFFFFF), Color(0xFFCC8DFF), Color(0xFF8415DE)],
          stops: [-0.1386, 0.2721, 1.5045],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.black, width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFCC8DFF),
              Color(0xFF8415DE),
            ],
            stops: [-0.1386, 0.2721, 1.5045],
          ).createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    ),
  );
}
