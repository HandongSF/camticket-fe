import 'dart:io';

import 'package:camticket/components/buttons.dart';
import 'package:camticket/components/dividers.dart';
import 'package:camticket/components/performance_round_widget.dart';
import 'package:camticket/components/texts.dart';
import 'package:camticket/components/ticket_option.dart';
import 'package:camticket/model/performance_create/performance_post_create_request.dart';
import 'package:camticket/src/pages/artist/unable_seat_page.dart';
import 'package:camticket/utility/color.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../model/performance_create/schedule_request.dart';
import '../../../model/performance_create/ticket_option_request.dart';
import '../../../provider/performance_upload_provider.dart';
import '../searchpage.dart';

class RegisterPerformancePage extends StatefulWidget {
  const RegisterPerformancePage({super.key});

  @override
  State<RegisterPerformancePage> createState() =>
      _RegisterPerformancePageState();
}

class _RegisterPerformancePageState extends State<RegisterPerformancePage> {
  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화
  PerformanceCategory _category = PerformanceCategory.ETC; // 기본값은 기타
  DateTime? _reservationStartAt;
  DateTime? _reservationEndAt;
  List<ScheduleRequest> _schedules = []; // PerformanceRoundsWidget에서 설정 필요
  PerformanceLocation _location =
      PerformanceLocation.HAKGWAN_104; // 기본값은 학관 104호
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _maxTicketsController =
      TextEditingController(); // 최대 티켓 수 입력 필드
  final TextEditingController _bankAccountController =
      TextEditingController(); // 백계좌 정보 입력 필드
  TicketType ticketType = TicketType.PAID; // 유료 공연 여부
  List<TicketOptionRequest> _ticket = [];
  bool _isFree = false; // 무료 공연 여부

  int _selectedCategoryIndex = 0; // 카테고리 선택을 위한 인덱스

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  Future<void> _pickDateTime({
    required bool isStart,
  }) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final selectedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      if (isStart) {
        _reservationStartAt = selectedDateTime;
        _startDateController.text =
            '${selectedDateTime.year}.${selectedDateTime.month.toString().padLeft(2, '0')}.${selectedDateTime.day.toString().padLeft(2, '0')} ${pickedTime.format(context)}';
      } else {
        _reservationEndAt = selectedDateTime;
        _endDateController.text =
            '${selectedDateTime.year}.${selectedDateTime.month.toString().padLeft(2, '0')}.${selectedDateTime.day.toString().padLeft(2, '0')} ${pickedTime.format(context)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 숨기기
      },
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
              white28('새로운 공연 등록하기'),
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '메인 포스터 이미지 ',
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
              GestureDetector(
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Container(
                    height: 530,
                    padding: const EdgeInsets.all(20),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: AppColors.gray1),
                    child: Center(
                      child: _image == null
                          ? Text(
                              '이곳을 눌러 포스터 이미지를 추가해주세요.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.24,
                              ),
                            )
                          : Image.file(
                              File(_image!.path),
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                  )),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '공연명 ',
                      style: TextStyle(
                        color: AppColors.subPurple,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.32,
                      ),
                    ),
                    TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: AppColors.mainPurple,
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
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: '공연명을 입력해주세요.',
                  hintStyle: const TextStyle(color: AppColors.gray4),
                  filled: true,
                  fillColor: AppColors.gray1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.gray2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '공연 카테고리 선택 ',
                      style: TextStyle(
                        color: AppColors.subPurple,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.32,
                      ),
                    ),
                    TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: AppColors.mainPurple,
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  children: [
                    _chip('음악', 0),
                    _chip('연극 / 뮤지컬', 1),
                    _chip('댄스', 2),
                    _chip('전시', 3),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '예매 가능 기간 설정 ',
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
              white16('예매 시작 날짜 / 시간'),
              const SizedBox(height: 8),
              TextField(
                controller: _startDateController,
                readOnly: true,
                onTap: () => _pickDateTime(isStart: true),
                decoration: InputDecoration(
                  hintText: '예매 시작 날짜와 시간을 선택해주세요.',
                  hintStyle: const TextStyle(color: AppColors.gray4),
                  filled: true,
                  fillColor: AppColors.gray1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.gray2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              white16('예매 종료 날짜 / 시간'),
              const SizedBox(height: 8),
              TextField(
                controller: _endDateController,
                readOnly: true,
                onTap: () => _pickDateTime(isStart: false),
                decoration: InputDecoration(
                  hintText: '예매 종료 날짜와 시간을 선택해주세요.',
                  hintStyle: const TextStyle(color: AppColors.gray4),
                  filled: true,
                  fillColor: AppColors.gray1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.gray2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '관람 회차 (일시) ',
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
              PerformanceRoundsWidget(
                onChanged: (scheduleList) {
                  setState(() {
                    _schedules = scheduleList;
                  });
                  debugPrint(
                    'Selected schedules: ${_schedules.map((e) => e.toJson()).toList()}',
                  );
                },
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '공연 장소 선택 ',
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
              _dropdownField('공연 장소를 선택하세요.'),
              const SizedBox(height: 8),
              Transform.translate(
                offset: const Offset(-15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (v) {},
                      checkColor: AppColors.mainBlack,
                      activeColor: AppColors.subPurple,
                    ),
                    const Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '선택한 공연 장소를 사전에 대여 완료했습니다. ',
                              style: TextStyle(
                                color: Color(0xFFE5E5E5),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.32,
                              ),
                            ),
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Color(0xFF9A3AE8),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                '공연 장소를 사전에 대여한 경우에만, 공연 등록이 가능합니다.',
                style: TextStyle(
                  color: const Color(0xFF818181),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.24,
                ),
              ),
              const SizedBox(height: 32),
              dividerGray2(),
              const SizedBox(height: 32),
              subPurpleText('관람객 티켓 수령 방법'),
              white16('온라인수령'),
              const SizedBox(height: 8),
              SizedBox(
                width: 372,
                child: Text(
                  '관람객의 예매가 완료된 후, 아티스트님께서는 반드시 “마이페이지→관람객 예매 확인”에서 해당 공연의 관람객 입금 정보를 확정해야 관람객이 정상적으로 티켓을 수령받을 수 있습니다.',
                  style: TextStyle(
                    color: AppColors.gray4,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '관람객 1인당 구매 가능한 티켓 매수 ',
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
              TextField(
                controller: _maxTicketsController,
                decoration: InputDecoration(
                  hintText: '숫자만 입력 가능합니다.',
                  hintStyle: const TextStyle(color: AppColors.gray4),
                  filled: true,
                  fillColor: AppColors.gray1,
                  suffixText: '매',
                  suffixStyle: const TextStyle(color: Colors.white), // 색상 조정
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.gray2),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '티켓 가격 옵션 선택 ',
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
              Row(
                children: [
                  Expanded(
                      child: RadioListTile(
                          activeColor: AppColors.mainPurple,
                          value: _isFree,
                          groupValue: true,
                          onChanged: (_) {
                            setState(() {
                              _isFree = true;
                              ticketType = TicketType.FREE;
                            });
                          },
                          title: const Text('무료 공연',
                              style: TextStyle(color: Colors.white)))),
                  Expanded(
                      child: RadioListTile(
                          activeColor: AppColors.mainPurple,
                          value: !_isFree,
                          groupValue: true,
                          onChanged: (_) {
                            setState(() {
                              _isFree = false;
                              ticketType = TicketType.PAID;
                            });
                          },
                          title: const Text('유료 공연',
                              style: TextStyle(color: Colors.white)))),
                ],
              ),
              !_isFree
                  ? PerformanceRoundsWidget2(
                      onChanged: (options) {
                        setState(() {
                          _ticket = options;
                        });
                      },
                    )
                  : SizedBox(),
              SizedBox(
                height: 8,
              ),
              Text(
                '* 아티스트님께서는 일반을 제외한 일부 유형에 대해 현장에서 티켓 확인 시 증빙자료(학생증 등)를 요구할 수 있습니다. 증빙되지 않은 경우, 현장에서 차액 지불을 관람객에게 요구할 수 있습니다.',
                style: TextStyle(
                  color: const Color(0xFF818181),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.24,
                ),
              ),
              const SizedBox(height: 24),
              subPurpleText(
                '결제방법 - 입금',
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: '은행명과 계좌번호를 정확하게 입력해주세요.',
                  hintStyle: const TextStyle(color: AppColors.gray4),
                  filled: true,
                  fillColor: AppColors.gray1, // 색상 조정
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.gray2),
                  ),
                ),
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                '관람객은 입력된 계좌 정보대로 티켓 가격에 대한 입금을 진행하게 됩니다. \n정확한 은행명과 계좌번호를 입력해주세요.\n\n입력 예시) 하나 910-910123-45678',
                style: TextStyle(
                  color: const Color(0xFF818181),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.24,
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    final provider = context.read<PerformanceUploadProvider>();

                    if (_image == null ||
                        _titleController.text.isEmpty ||
                        _reservationStartAt == null ||
                        _reservationEndAt == null ||
                        _schedules.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('모든 필수 항목을 입력해주세요.')),
                      );
                      return;
                    }

                    provider.setPage1Info(
                      profileImage: File(_image!.path),
                      title: _titleController.text,
                      category: _category,
                      reservationStartAt: _reservationStartAt!,
                      reservationEndAt: _reservationEndAt!,
                      schedules: _schedules,
                      location: _location,
                      maxTicketsPerUser: int.parse(_maxTicketsController.text),
                      ticketType: ticketType,
                      ticketOptionRequest: _ticket,
                      bankAccount: _bankAccountController.text,
                    );

                    provider.showPage1Info();

                    // Perform the action for the next button
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UnableSeatPage(selectedSeats: []),
                      ),
                    );
                  },
                  child: mainPurpleBtn('다음')),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, int index) => GestureDetector(
        onTap: () {
          setState(() {
            if (label == '음악') {
              _category = PerformanceCategory.MUSIC;
              _selectedCategoryIndex = 0;
            } else if (label == '연극 / 뮤지컬') {
              _category = PerformanceCategory.ACT_MUSICAL;
              _selectedCategoryIndex = 1;
            } else if (label == '댄스') {
              _category = PerformanceCategory.DANCE;
              _selectedCategoryIndex = 2;
            } else if (label == '전시') {
              _category = PerformanceCategory.ETC;
              _selectedCategoryIndex = 3;
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: _selectedCategoryIndex == index
                ? AppColors.mainPurple
                : AppColors.gray1,
            border: Border.all(color: AppColors.gray3, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(label,
              style: const TextStyle(color: AppColors.white, fontSize: 14)),
        ),
      );

  Widget _dropdownField(String hint) => DropdownButtonFormField<String>(
        dropdownColor: const Color(0xFF3D3D3D),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF3D3D3D),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
        hint: Text(hint, style: const TextStyle(color: Color(0xFFE5E5EA))),
        items: ['공연 장소를 선택하세요.', '학관 104호']
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: const TextStyle(color: Colors.white))))
            .toList(),
        onChanged: (_) {
          setState(() {
            // 선택된 공연 장소에 따라 _location 값을 업데이트
            if (_ == '학관 104호') {
              _location = PerformanceLocation.HAKGWAN_104;
            } else {
              _location = PerformanceLocation.ETC; // 기타로 설정
            }
          });
        },
      );
}
