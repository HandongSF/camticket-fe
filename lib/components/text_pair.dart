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

Widget grayAndWhite(String text, String text2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 44,
        child: Text(
          text,
          softWrap: false,
          style: TextStyle(
            color: AppColors.gray4,
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.24,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
      SizedBox(
        width: 75,
        child: Text(
          text2,
          softWrap: false,
          style: TextStyle(
            color: AppColors.gray5,
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.24,
            overflow: TextOverflow.visible,
          ),
          textAlign: TextAlign.left,
        ),
      )
    ],
  );
}

Widget grayAndWhite16(String text, String text2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 44,
        child: Text(
          text,
          softWrap: false,
          style: TextStyle(
            color: AppColors.gray4,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.24,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
      SizedBox(
        width: 75,
        child: Text(
          text2,
          softWrap: false,
          style: TextStyle(
            color: AppColors.gray5,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.24,
            overflow: TextOverflow.visible,
          ),
          textAlign: TextAlign.left,
        ),
      )
    ],
  );
}
