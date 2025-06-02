import 'dart:io';

import 'package:camticket/components/buttons.dart';
import 'package:camticket/components/dividers.dart';
import 'package:camticket/components/textfield.dart';
import 'package:camticket/components/texts.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/performance_upload_provider.dart';
import '../../nav_page.dart';
import '../my_page.dart';
import '../searchpage.dart';

class RegisterDetailPage extends StatefulWidget {
  const RegisterDetailPage({super.key});

  @override
  State<RegisterDetailPage> createState() => _RegisterDetailPageState();
}

class _RegisterDetailPageState extends State<RegisterDetailPage> {
  List<File> _selectedImages = [];

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> files = await picker.pickMultiImage();

    setState(() {
      _selectedImages = files.take(4).map((f) => File(f.path)).toList();
    });
  }

  TextEditingController timeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController noticeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1B1B1B), // mainBlack
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Image.asset(
                  'assets/images/navi logo.png',
                  width: 110,
                  height: 28,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Searchpage()),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 24,
                  ),
                )
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              height: 1.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0x001B1B1B), // 완전 투명한 검정 (왼쪽)
                    Color(0xFF828282), // 중간 회색 (중앙이 밝음)
                    Color(0x001B1B1B), // 완전 투명한 검정 (오른쪽)
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[],
          toolbarHeight: 64,
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              white28('공연 상세 정보 입력'),
              const SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '공연 시간 안내 문구 ',
                      style: TextStyle(
                        color: const Color(0xFFE4C3FF),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.32,
                      ),
                    ),
                    TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: const Color(0xFF9A3AE8),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.32,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              textField5('공연 시간 안내 문구를 구체적으로 입력해주세요.\nex) 공연 날짜, 회차, 시간 ..',
                  timeController),
              const SizedBox(height: 32),
              dividerGray2(),
              const SizedBox(height: 22),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '티켓 가격 정보 안내 문구 ',
                      style: TextStyle(
                        color: const Color(0xFFE4C3FF),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.32,
                      ),
                    ),
                    TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: const Color(0xFF9A3AE8),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.32,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              textField5('티켓 가격 정보 안내 문구를 구체적으로 입력해주세요.', priceController),
              const SizedBox(height: 32),
              dividerGray2(),
              const SizedBox(height: 32),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '예매 공지사항 문구 ',
                      style: TextStyle(
                        color: const Color(0xFFE4C3FF),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.32,
                      ),
                    ),
                    TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: const Color(0xFF9A3AE8),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.32,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              textField5(
                  '예매 공지사항 문구를 구체적으로 입력해주세요.  ex) 오프라인 티켓 예매 일정, 1인당 구입 가능한 티켓 매수..',
                  noticeController),
              const SizedBox(height: 32),
              dividerGray2(),
              const SizedBox(height: 32),
              subPurpleText('이미지 첨부 (팜플렛, 그 이외의 정보) -  최대 4장'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  await pickImages();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: AppColors.subPurple,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: AppColors.gray2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      Icon(
                        Icons.image_outlined,
                        color: AppColors.mainBlack,
                        size: 18,
                      ),
                      Text(
                        '+ 새로운 이미지 첨부하기',
                        style: TextStyle(
                          color: AppColors.mainBlack,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.12,
                          letterSpacing: -0.32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              const SizedBox(height: 8),
              if (_selectedImages.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: _selectedImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.gray3,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.file(
                        _selectedImages[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              SizedBox(height: 24),
              dividerGray2(),
              const SizedBox(height: 24),
              subPurpleText('티켓 수령 방법 안내'),
              white16(
                  '관람객의 예매가 완료된 후, 아티스트님께서는 반드시 “마이페이지→관람객 예매 확인”에서 해당 공연의 관람객 입금 정보를 확정해야 관람객이 정상적으로 티켓을 수령받을 수 있습니다.'),
              const SizedBox(height: 32),
              dividerGray2(),
              const SizedBox(height: 8),
              subPurpleText('취소/환불 안내'),
              white16(
                  '관람객은 취소마감시간 이후 또는 관람일 당일 예매하신 건에 대해서 취소/변경/환불이 불가능합니다.\n\n환불 요청 시 아티스트님 께서는 해당 환불건에 대해서 확인한 뒤 관람객의 등록된 환불 계좌번호로 환불 금액을 반드시 입금해주셔야 합니다.'),
              SizedBox(height: 32),
              subPurpleText('예매 안내'),
              SizedBox(height: 8),
              white16(
                  '관람객이 잘못된 계좌번호로 입금을 하거나 혹은 결제금액과 일치하지 않은 금액 입금한 경우, 아티스트님께서는 해당 예매건을 취소하실 수 있습니다.'),
              SizedBox(height: 164),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 100,
          color: Colors.transparent,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // 예매 하기 버튼 클릭 시 처리 로직
                      // 예를 들어, 선택된 좌석 정보를 서버에 전송하거나 다음 페이지로 이동
                      Navigator.pop(context);
                    },
                    child: subPurpleBtn4518(
                      '이전',
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        final provider =
                            context.read<PerformanceUploadProvider>();

                        provider.setPage3Details(
                          timeNotice: timeController.text,
                          ticketInfoText: priceController.text,
                          noticeText: noticeController.text,
                          detailImages: _selectedImages, // 빈 리스트여도 괜찮음
                        );

                        provider.showAll(); // 디버깅용

                        if (await provider.uploadPerformance()) {
                          // 업로드 성공 시
                          showPerformanceCompleteDialog(context);
                        } else {
                          // 업로드 실패 시
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('공연 등록에 실패했습니다.'),
                            ),
                          );
                        }
                      },
                      child: mainPurpleBtn1876('공연 등록하기')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPerformanceCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 바깥 터치로 닫히지 않음
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF1B1B1B), // mainBlack
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '공연 등록 완료',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                    letterSpacing: 0.10,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '정상적으로 공연 등록이 완료되었습니다!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.25,
                    letterSpacing: 0.10,
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const Start(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      '확인',
                      style: TextStyle(
                        color: AppColors.subPurple, // mainPurple
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.28,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
