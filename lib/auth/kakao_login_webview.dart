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

import 'dart:convert';

import 'package:camticket/src/nav_page.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:camticket/auth/secure_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import '../model/jwt_model.dart';
import '../provider/jwt_provider.dart';
import '../utility/endpoint.dart';

class KakaoLoginWebView extends StatefulWidget {
  final String clientId;
  final String redirectUri;

  const KakaoLoginWebView({
    super.key,
    required this.clientId,
    required this.redirectUri,
  });

  @override
  _KakaoLoginWebViewState createState() => _KakaoLoginWebViewState();
}

class _KakaoLoginWebViewState extends State<KakaoLoginWebView> {
  late final WebViewController _controller;
  SecureStorage storage = SecureStorage();
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            debugPrint("Navigating to: ${request.url}");
            if (request.url.startsWith(widget.redirectUri)) {
              Uri uri = Uri.parse(request.url);
              if (uri.queryParameters['code'] != null) {
                String authCode = uri.queryParameters['code']!;
                debugPrint("Authorization Code: $authCode");

                // 서버에 Authorization Code 전달
                _sendCodeToServer(authCode);
              } else if (uri.queryParameters['error'] != null) {
                String error = uri.queryParameters['error']!;
                debugPrint("Error: $error");
                Navigator.pop(context, "Error: $error");
              }
              return NavigationDecision.prevent; // 리다이렉션 중단
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            debugPrint("Page started loading: $url");
          },
          onPageFinished: (String url) async {
            debugPrint("Page finished loading: $url");
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${widget.clientId}&redirect_uri=${widget.redirectUri}",
        ),
      );
  }

  String? extractUserIdFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(decoded);

      return payloadMap['userId'].toString(); // 또는 'id' 키에 맞게 변경
    } catch (e) {
      debugPrint("Token decode error: $e");
      return null;
    }
  }

  // 서버로 Authorization Code 전달
  void _sendCodeToServer(String authCode) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${ApiConstants.loginUrl}/camticket/auth/kakao-login?code=$authCode"),
        headers: {
          "Origin": ApiConstants.loginUrl,
        },
      );

      if (response.statusCode == 200) {
        debugPrint("Server Response: ${response.body}");
        debugPrint("Server Headers: ${response.headers}");

        // 헤더에서 토큰 꺼내기
        final authorizationHeader = response.headers['authorization'];

        if (authorizationHeader != null) {
          // access-token에서 "Bearer " 제거
          final accessToken = authorizationHeader.startsWith("Bearer ")
              ? authorizationHeader.substring(7) // "Bearer " 제외한 토큰만 저장
              : authorizationHeader;

          // 저장
          await storage.saveToken("x-access-token", accessToken);

          final savedAccessToken = await storage.readToken("x-access-token");

          debugPrint("Saved x-access-token: $savedAccessToken");
          // if (savedAccessToken != null) {
          //   debugPrint("Initializing NotificationProvider");
          //   Provider.of<NotificationProvider>(context, listen: false)
          //       .initialize(context, savedAccessToken);
          // }
          final userId = extractUserIdFromToken(accessToken);

          if (userId != null && savedAccessToken != null) {
            debugPrint("User ID: $userId");
            await storage.saveToken('user-id', userId); // 원하는 키로 저장
            await storage.saveToken('jwt', savedAccessToken);
            Provider.of<JwtProvider>(context, listen: false).setJwt(
                JwtToken.fromDecodedToken(JwtDecoder.decode(savedAccessToken)));
            debugPrint("User ID 저장됨: $userId");
          } else {
            debugPrint("토큰에서 userId 추출 실패");
          }
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Start()),
            (Route<dynamic> route) => false,
          );
        } else {
          debugPrint("Token missing in response headers.");
          Navigator.pop(context, "Error: Token missing");
        }
      } else {
        debugPrint("Server Error: ${response.statusCode} ${response.body}");
        Navigator.pop(context, "Error: ${response.body}");
      }
    } catch (error) {
      debugPrint("HTTP Error: $error");
      Navigator.pop(context, "Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
