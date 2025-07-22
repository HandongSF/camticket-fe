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

Widget subPurpleText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.subPurple,
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      letterSpacing: -0.32,
    ),
  );
}

Widget whiteTitleText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.white,
      fontSize: 28,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget gray412(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppColors.gray4,
      fontSize: 12,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.24,
    ),
  );
}

Widget white16(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppColors.white,
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.32,
    ),
  );
}

Widget buildInfoBigText(String text, String? text2) {
  return SizedBox(
    width: 84,
    child: Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: AppColors.gray4,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.32,
          ),
        ),
        text2 == null
            ? SizedBox()
            : Text(
                text2,
                style: TextStyle(
                  color: const Color(0xFF9A3AE8),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.32,
                ),
              )
      ],
    ),
  );
}
