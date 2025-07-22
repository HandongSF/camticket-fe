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
