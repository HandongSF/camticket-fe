import 'package:camticket/src/nav_page.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utility/endpoint.dart';
import 'kakao_login_webview.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    //autoLogin(); // 앱 시작 시 자동 로그인 시도
  }

  // 권한 요청 메서드
  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
  }

  // 자동 로그인 메서드
  Future<void> autoLogin() async {
    final accessToken = await _storage.read(key: 'accessToken');
    if (accessToken != null) {
      debugPrint('자동 로그인 중: $accessToken');
      await _processLogin(accessToken, isAutoLogin: true);
    } else {
      debugPrint('저장된 토큰 없음');
    }
  }

  // 카카오 로그인 메서드
  Future<void> kakaoLogin() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      await _processLogin(token.accessToken);
    } catch (error) {
      debugPrint('카카오톡으로 로그인 실패: $error');
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        await _processLogin(token.accessToken);
      } catch (accountError) {
        debugPrint('카카오 계정으로 로그인 실패: $accountError');
      }
    }
  }

  // 로그인 처리 메서드
  Future<void> _processLogin(String accessToken,
      {bool isAutoLogin = false}) async {
    try {
      debugPrint('로그인 요청 시작: $accessToken');

      // 첫 번째 요청
      var response = await http.get(
        Uri.parse(
            // 'https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=6b4d8cc48ec73499504d519e26c84c91&redirect_uri=http://172.18.144.123:8000/scrd/auth/kakao-login'),
            'https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${ApiConstants.clientId}&redirect_uri=${ApiConstants.loginUrl}/camticket/auth/kakao-login'), //갈대상자관
      ); // IP 주소를 로컬 네트워크 IP로 교체
      debugPrint('서버 응답: ${response.statusCode} : ${response.headers}');

      if (response.statusCode == 302) {
        // 리다이렉션 URL 추출
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          debugPrint('리다이렉션 URL: $redirectUrl');

          // 두 번째 요청
          var loginResponse = await http.get(Uri.parse(redirectUrl));
          debugPrint(
              '로그인 응답: ${loginResponse.statusCode} ${loginResponse.body}');

          if (loginResponse.statusCode == 200) {
            // 토큰 저장
            await _storage.write(key: 'accessToken', value: accessToken);

            if (!isAutoLogin) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Start()),
              );
            }
          } else {
            debugPrint('로그인 실패: ${loginResponse.statusCode}');
          }
        } else {
          debugPrint('리다이렉션 URL을 찾을 수 없습니다.');
        }
      } else {
        debugPrint('로그인 실패: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('서버 요청 오류 발생: $e');
    }
  }

  // 로그아웃 메서드
  Future<void> logout() async {
    await _storage.delete(key: 'accessToken');
    debugPrint('로그아웃 성공');

    // 로그인 페이지로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 250), // 상단 여백
        Image.asset(
          'assets/images/navi logo.png',
          width: 110,
          height: 28,
          fit: BoxFit.cover,
        ),

        const Spacer(), // 로그인 버튼을 아래로 밀기

        Center(
          child: ElevatedButton(
            onPressed: () {
              final result = Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KakaoLoginWebView(
                    clientId: ApiConstants.clientId,
                    // redirectUri: 'http://172.18.144.123:8000/login/oauth/kakao',
                    redirectUri:
                        '${ApiConstants.loginUrl}/login/oauth/kakao', //기숙사
                  ),
                ),
              );
              // http.post(Uri.parse('https://kauth.kakao.com/oauth/token'));

              // kakaoLogin();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFfee502),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/kakao_login_large_narrow.png',
                  height: 40,
                  width: 180,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 250),
      ],
    );
  }
}
