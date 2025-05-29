import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  final VoidCallback onFinish;

  const AnimationPage({super.key, required this.onFinish});

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _textAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _moveAnimationLeft;
  late Animation<double> _moveAnimationRight;

  @override
  void initState() {
    super.initState();

    // Text animation controller
    _textAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _moveAnimationLeft = Tween<double>(begin: 200.0, end: -200.0).animate(
      CurvedAnimation(parent: _textAnimationController, curve: Curves.easeOut),
    );

    _moveAnimationRight = Tween<double>(begin: -200.0, end: 200.0).animate(
      CurvedAnimation(parent: _textAnimationController, curve: Curves.easeOut),
    );

    _textAnimationController.forward();

    // Fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    // Redirect to main page after animation
    Future.delayed(const Duration(seconds: 3), () {
      _fadeController.forward().then((value) => widget.onFinish());
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD90206), // Red background
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer rectangle
                  _buildRotatedBoxWithText2(
                    -9.775,
                    800,
                    "FOLLOW",
                    "SCARLET",
                    "THREADS",
                  ),
                  // Middle rectangle
                  _buildRotatedBoxWithText(
                    9.067,
                    180,
                    "FOLLOW",
                    "SCARLET",
                    "THREADS",
                  ),
                  // Inner rectangle
                  _buildRotatedBoxWithText(
                    -6.8,
                    100,
                    "FOLLOW",
                    "SCARLET",
                    "THREADS",
                  ),
                ],
              ),
            ),
            // Upper left text
            Positioned(
              top: MediaQuery.of(context).size.height / 8,
              left: MediaQuery.of(context).size.width / 8,
              child: Transform.rotate(
                angle: -9.775 * 3.14159 / 180,
                child: const Text(
                  "ESCAPE ROOM\nTEAM MATCHING",
                  style: TextStyle(
                    fontFamily: 'NeueHaasDisplay',
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Lower right text
            Positioned(
              bottom: MediaQuery.of(context).size.height / 3,
              left: 0,
              child: Transform.rotate(
                angle: -9.775 * 3.14159 / 180,
                child: const Text(
                  "ESCAPE ROOM\nTEAM MATCHING",
                  style: TextStyle(
                    fontFamily: 'NeueHaasDisplay',
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRotatedBoxWithText(
    double angle,
    double size,
    String text1,
    String text2,
    String text3,
  ) {
    return Transform.rotate(
      angle: angle * 3.14159 / 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 사각형 배경
          Container(
            width: size,
            height: size * 1.4,
            decoration: const BoxDecoration(
              color: Color(0xFFD90206), // 빨간색 배경
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD90206),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: const Offset(5, 5), // 그림자 위치
                    blurRadius: 15,
                    spreadRadius: -5, // 그림자 확산 조정
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: const Offset(0, 5), // 그림자 위치
                    blurRadius: 15,
                    spreadRadius: -5, // 그림자 확산 조정
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: const Offset(5, 0), // 그림자 위치
                    blurRadius: 15,
                    spreadRadius: -5, // 그림자 확산 조정
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: const Offset(0, 0), // 그림자 위치
                    blurRadius: 15,
                    spreadRadius: -5, // 그림자 확산 조정
                  ),
                ],
              ),
            ),
          ),
          // 사각형 내부 텍스트
          ClipRect(
            child: SizedBox(
              width: size,
              height: size * 1.4,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildAnimatedText(text1, _moveAnimationLeft),
                      _buildAnimatedText(text2, _moveAnimationRight),
                      _buildAnimatedText(text3, _moveAnimationLeft),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRotatedBoxWithText2(
    double angle,
    double size,
    String text1,
    String text2,
    String text3,
  ) {
    return Transform.rotate(
      angle: angle * 3.14159 / 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 사각형 내부 텍스트
          ClipRect(
            // 초과된 내용 잘라내기
            child: SizedBox(
              width: size * 2,
              height: size * 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAnimatedText2(text1, _moveAnimationLeft),

                  _buildAnimatedText2(text2, _moveAnimationRight),
                  // SizedBox(height: 2),
                  _buildAnimatedText2(text3, _moveAnimationLeft),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedText(String text, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(animation.value, 0),
          child: Text(
            softWrap: false,
            text,
            style: const TextStyle(
              overflow: TextOverflow.visible,
              height: 0,
              fontFamily: 'NeueHaasDisplay',
              fontWeight: FontWeight.w600,
              fontSize: 90,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedText2(String text, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(animation.value, 0),
          child: Text(
            softWrap: false,
            text,
            style: const TextStyle(
              overflow: TextOverflow.visible,
              fontFamily: 'NeueHaasDisplay',
              fontSize: 150,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
