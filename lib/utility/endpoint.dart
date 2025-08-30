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

class ApiConstants {
  static const String loginUrl = "http://172.18.137.76:8080";
  // static const String loginUrl = "http://172.17.171.107:8080";
  // static const String loginUrl = "http://192.168.0.8:8080"; // 집
  static const String baseUrl = loginUrl;
  //static const String baseUrl = "http://192.168.45.92:8080"; // 집
  //static const String baseUrl = "https://test.apiofpeg.com";
  static const String mainList = "$baseUrl/scrd/api/theme/paged";
  static const String reviewList = "$baseUrl/scrd/api/review";
  //static const String mainList = "$baseUrl/scrd/every";
  //static const String loginUrl = "http://172.17.205.100"; //갈대상자
  //갈대상자관
  //static const String loginUrl = "http://192.168.45.92";
  static const String filteredThemeList = "$baseUrl/scrd/api/theme/filter";
  //static const baseHost = "172.17.205.100:8080";
  static String baseHost = baseUrl.replaceAll("https://", "");
  static String myReviewList(String userId) =>
      "$baseUrl/scrd/api/review/$userId";
  static const String mySavedList = '/scrd/api/save';
  static const String themeDetail = "$baseUrl/scrd/api/web/theme"; // <- 추가

  //static const String clientId = "f77e1396028dc1a29468fd99dda85ef6";
  static const String clientId = "e3307974d7dd2a29d14bcab5355f4082";
}
