import 'dart:ui';

import 'package:camticket/provider/user_provider.dart';
import 'package:camticket/src/pages/artist/reservation_manage_page.dart';
import 'package:camticket/src/pages/ticket_popup.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/buttons.dart';
import '../../provider/navigation_provider.dart';
import 'artist/manage_registered_page.dart';
import 'artist/register_performance_page.dart';

enum UserRole { none, viewer, artist }

class UserInfo {
  final String? name;
  final UserRole role;

  UserInfo({this.name, this.role = UserRole.none});
}

class Mypage extends StatefulWidget {
  const Mypage({super.key});

  @override
  _Mypagestate createState() => _Mypagestate();
}

class _Mypagestate extends State<Mypage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUser();
    });
  }

  UserInfo currentUser = UserInfo(role: UserRole.none); // 초기 상태: 비로그인
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: true);
    final userRole = provider.user?.role;
    if(userRole == 'ROLE_USER'){
      debugPrint("userRole = $userRole  goodgood");
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '마이페이지',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildProfileSection(context),
              const SizedBox(height: 32),
              if (currentUser.role != UserRole.none) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: const Text(
                    '메뉴',
                    style: TextStyle(color: AppColors.gray4, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),
                if (currentUser.role == UserRole.artist) ...[
                  _buildOptionButton(
                    '새로운 공연 등록하기',
                    () {
                      // 공연 등록 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterPerformancePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildOptionButton(
                    '등록된 공연 관리',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ManageRegisteredPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildOptionButton(
                    '관람객 예매 확인 및 관리',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReservationManagePage(),
                        ),
                      );
                    },
                  ),
                ],
                if (currentUser.role == UserRole.viewer) ...[
                  _buildOptionButton(
                    '티켓보기',
                    () {
                      // 관람 기록 페이지로 이동
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => const TicketPopup(),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => const TicketPage()),
                      // );
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildOptionButton(
                    '예매 확인 / 취소',
                    () {
                      context
                          .read<NavigationProvider>()
                          .setSubPage('reservation');
                    },
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildLogoutButton()),
                    const SizedBox(width: 8),
                    Expanded(child: _buildSignOutButton())
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 372,
        height: 52,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFF232323),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                color: AppColors.gray5,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1,
                letterSpacing: -0.32,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFF232323),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Center(
          child: const Text(
            '로그아웃',
            style: TextStyle(
              color: Color(0xFFCE3939),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 1,
              letterSpacing: -0.32,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentUser = UserInfo(role: UserRole.none);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFF232323),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Center(
          child: const Text(
            '탈퇴하기',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 1,
              letterSpacing: -0.32,
            ),
            textAlign: TextAlign.left,
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
          width: 372,
          height: 138,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColors.gray1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.gray2,
                  radius: 50,
                  child: Icon(
                    Icons.person_outline,
                    color: AppColors.gray3,
                    size: 50,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  '로그인을 해주세요.',
                  style: TextStyle(
                    color: Color(0xFFE5E5E5),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.40,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    final provider = Provider.of<UserProvider>(context, listen: true);
    final badgeText = currentUser.role == UserRole.viewer
        ? 'assets/images/viewer.png'
        : 'assets/images/artist.png';
    final userText = currentUser.role == UserRole.viewer ? provider.user?.nickName : provider.user?.nickName;
    final user = provider.user;
    final profileImageUrl = user?.profileImageUrl;
    final bankAccount = user?.bankAccount;
    debugPrint('bank account = $bankAccount');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.gray1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.gray1,
              radius: 50,
              backgroundImage: provider.user?.profileImageUrl != null &&
                  provider.user!.profileImageUrl!.isNotEmpty
                  ? NetworkImage(profileImageUrl!)
                  : null,
              child: provider.user?.profileImageUrl == null ||
                  provider.user!.profileImageUrl!.isEmpty
                  ? const Icon(Icons.person_outline, color: AppColors.gray3, size: 50)
                  : null,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  badgeText,
                  width: 44,
                  height: 18,
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      userText!,
                      style: TextStyle(
                        color: AppColors.gray5,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.40,
                      ),
                    ),
                    Text(
                      '님',
                      style: TextStyle(
                        color: AppColors.gray5,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ],
                ),
                currentUser.role == UserRole.viewer
                    ? Column(
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            bankAccount!,
                            style: TextStyle(
                              color: const Color(0xFF818181),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.24,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      )
                    : SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: "프로필 변경",
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: Duration(milliseconds: 200),
                          pageBuilder: (_, __, ___) {
                            return ProfileEditDialog(); // ← 위에서 구현한 다이얼로그
                          },
                        );
                      },
                      child:Text(
                        currentUser.role == UserRole.viewer
                            ? '환불계좌 / 프로필 변경하기'
                            : '프로필 변경하기',
                        style: const TextStyle(
                          color: AppColors.gray4,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.28,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.gray4,
                          decorationThickness: 1.2, // ← 밑줄 추가
                        ),
                      ),
                    ),
                    SizedBox(width: 1),
                    Icon(
                      Icons.edit,
                      color: const Color(0xFF818181),
                      size: 14,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
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
            buildGradientButton(
              context,
              label: '아티스트',
              userInfo: UserInfo(name: '네오', role: UserRole.artist),
            ),
            const SizedBox(height: 16),
            buildGradientButton(
              context,
              label: '관람객',
              userInfo: UserInfo(name: '박조이', role: UserRole.viewer),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileEditDialog extends StatefulWidget {
  const ProfileEditDialog({Key? key}) : super(key: key);

  @override
  _ProfileEditDialogState createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _introductionController;
  late TextEditingController _bankAccountController;
  final _formKey = GlobalKey<FormState>();

  String? _role;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _introductionController = TextEditingController();
    _bankAccountController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Provider.of<UserProvider>(context, listen: false).user;

      setState(() {
        _role = user?.role;
        _nameController.text = user?.name ?? '';
        _introductionController.text = user?.introduction ?? '';
        _bankAccountController.text = user?.bankAccount ?? '';
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _introductionController.dispose();
    _bankAccountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => Navigator.pop(context), // 배경 클릭 시 닫기
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
            Center(
              child: GestureDetector(
                onTap: () {}, // 다이얼로그 내부 터치 시 닫히지 않게
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("프로필 수정", style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 16),

                        // 닉네임
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: "닉네임",
                            hintText: "변경할 닉네임을 입력하세요",
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return '닉네임은 필수입니다.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // 소개글 (매니저만)
                        if (_role == 'ROLE_MANAGER')
                          TextFormField(
                            controller: _introductionController,
                            decoration: const InputDecoration(
                              labelText: "소개글",
                              hintText: "간단한 소개글을 입력하세요",
                            ),
                            maxLines: 3,
                          ),

                        // 환불 계좌 (일반 유저만)
                        if (_role == 'ROLE_USER')
                          TextFormField(
                            controller: _bankAccountController,
                            decoration: const InputDecoration(
                              labelText: "환불 계좌",
                              hintText: "은행명 + 계좌번호 입력",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return '환불 계좌를 입력해주세요.';
                              }
                              return null;
                            },
                          ),

                        const SizedBox(height: 20),

                        // 버튼
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: const Text("취소"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            ElevatedButton(
                              child: const Text("저장"),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  userProvider.updateUserInfo(
                                    name: _nameController.text,
                                    introduction: _role == 'ROLE_MANAGER' ? _introductionController.text.trim() : null,
                                    bankAccount: _role == 'ROLE_USER' ? _bankAccountController.text.trim() : null,
                                  );
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



