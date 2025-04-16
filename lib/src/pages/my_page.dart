import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';

enum UserRole { none, viewer, artist }

class UserInfo {
  final String? name;
  final UserRole role;

  UserInfo({this.name, this.role = UserRole.none});
}

class Mypage extends StatefulWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  _Mypagestate createState() => _Mypagestate();
}

class _Mypagestate extends State<Mypage> {
  UserInfo currentUser = UserInfo(role: UserRole.none); // 초기 상태: 비로그인

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.only(left: 26.0, top: 22),
            child: const Text(
              '마이페이지',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildProfileSection(context),
          const SizedBox(height: 32),
          if (currentUser.role != UserRole.none) ...[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: const Text(
                '메뉴',
                style: TextStyle(color: AppColors.gray1, fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: AppColors.gray2,
                  ),
                ),
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLogoutButton(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentUser = UserInfo(role: UserRole.none);
        });
      },
      child: Container(
        child: const Text(
          '로그아웃',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    if (currentUser.role == UserRole.none) {
      return GestureDetector(
        onTap: () async {
          final result = await Navigator.push<UserInfo>(
            context,
            MaterialPageRoute(builder: (context) => const LoginSelectPage()),
          );

          if (result != null) {
            setState(() {
              currentUser = result;
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: AppColors.gray2,
              ),
            ),
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.gray1,
                  radius: 35,
                  child: Icon(Icons.person_outline, color: AppColors.gray4),
                ),
                const SizedBox(width: 16),
                const Text(
                  '로그인을 해주세요.',
                  style: TextStyle(
                    color: AppColors.gray5,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.40,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final badgeText = currentUser.role == UserRole.viewer ? '관람객' : '아티스트';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: AppColors.gray2,
          ),
        ),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.gray1,
              radius: 35,
              backgroundImage: AssetImage('assets/images/zzanggu.png'),
            ),
            const SizedBox(width: 16),
            const Text(
              '유저 님',
              style: TextStyle(
                color: AppColors.gray5,
                fontSize: 20,
                decoration: TextDecoration.underline,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientBadge(String text) {
    return Container(
      width: 64,
      height: 28,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [Color(0xFFFFFFFF), Color(0xFFCC8DFF), Color(0xFF8415DE)],
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
              Color(0xFFFFFFFF),
              Color(0xFFCC8DFF),
              Color(0xFF8415DE),
            ],
            stops: [-0.1386, 0.2721, 1.5045],
          ).createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }
}

class LoginSelectPage extends StatelessWidget {
  const LoginSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildGradientButton(
              context,
              label: '아티스트',
              userInfo: UserInfo(name: '네오', role: UserRole.artist),
            ),
            const SizedBox(height: 16),
            _buildGradientButton(
              context,
              label: '관람객',
              userInfo: UserInfo(name: '박조이', role: UserRole.viewer),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton(
    BuildContext context, {
    required String label,
    required UserInfo userInfo,
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
}
