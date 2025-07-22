/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/navigation_provider.dart';
import '../provider/pc_provider.dart';
import '../src/pages/my_page.dart';

Widget mainPurpleBtn(String text) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
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
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.32,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget mainPurpleBtn6018(String text) {
  return Container(
    height: 56,
    padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 18),
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: AppColors.mainPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        softWrap: false,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.32,
        ),
        overflow: TextOverflow.visible,
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
        style: const TextStyle(
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
        side: const BorderSide(width: 1, color: Color(0xFFE4C3FF)),
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
        side: const BorderSide(width: 1, color: Color(0xFFE4C3FF)),
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
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
          border: Border.all(color: Colors.black, width: 0.1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget redBtn2918(String text) {
  return Container(
    height: 56,
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: const Color(0xFFCF3939),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.black, width: 1),
    ),
    child: Center(
      child: Text(
        softWrap: false,
        text,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 1.25,
          letterSpacing: -0.32,
        ),
      ),
    ),
  );
}

Widget subPurpleBtn4518(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 18),
    height: 56,
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: AppColors.subPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.mainBlack,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.32,
        ),
      ),
    ),
  );
}

Widget mainPurpleBtn18107(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 107.0, vertical: 18),
    height: 56,
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: AppColors.mainPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.32,
        ),
      ),
    ),
  );
}

Widget mainPurpleBtn1876(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 76.0, vertical: 18),
    height: 56,
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: AppColors.mainPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.32,
        ),
      ),
    ),
  );
}
