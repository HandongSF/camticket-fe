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

Widget buildArtistButton() {
  return Container(
    width: 53,
    height: 18,
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 8,
          top: 4,
          child: Text(
            '아티스트',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1,
              letterSpacing: -0.20,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildGradientBadge(String text) {
  return Container(
    width: 64,
    height: 28,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment(-1.0, 0.0),
        end: Alignment(1.0, 0.0),
        colors: [
          AppColors.mainPurple,
          AppColors.mainPurple,
          AppColors.subPurple
        ],
        stops: [-0.1386, 0.2721, 1.5045],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(18),
      ),
      alignment: Alignment.center,
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            AppColors.mainPurple,
            AppColors.mainPurple,
            AppColors.subPurple
          ],
          stops: [-0.1386, 0.2721, 1.5045],
        ).createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1,
            letterSpacing: -0.20,
          ),
        ),
      ),
    ),
  );
}
