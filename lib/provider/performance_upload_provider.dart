import 'dart:io';

import 'package:camticket/model/performanceDetail.dart';
import 'package:flutter/material.dart';

import '../model/performance_create/performance_post_create_request.dart';
import '../model/performance_create/schedule_request.dart';
import '../model/performance_create/seat_unavailable_schedule_request.dart';
import '../model/performance_create/ticket_option_request.dart';

class PerformanceUploadProvider with ChangeNotifier {
  // 1페이지: 메인 이미지, 공연명, 카테고리, 예약 날짜/시간, 관람회차, 장소
  File? _profileImage;
  String _title = '';
  PerformanceCategory _category = PerformanceCategory.ETC; // 기본값은 기타
  DateTime? _reservationStartAt;
  DateTime? _reservationEndAt;
  List<ScheduleRequest> _schedules = [];
  PerformanceLocation _location =
      PerformanceLocation.HAKGWAN_104; // 기본값은 학관 104호
  TicketType _ticketType = TicketType.PAID; // 기본값은 일반 티켓
  // 2페이지: 예매 불가 좌석
  List<SeatUnavailableScheduleRequest> _seatUnavailableSchedules = [];
  int _maxTicketsPerUser = 1; // 최대 티켓 수, 기본값은 1
  String _bankAccount = ''; // 백계좌 정보는 나중에 추가

  // 3페이지: 공연 안내 문구, 티켓 가격 문구, 예매 공지사항, 추가 이미지
  String _content = ''; // 공연 시간 안내 문구
  String _ticketInfoText = ''; // 티켓 가격 정보 안내 문구
  String _noticeText = ''; // 예매 공지사항 문구
  List<File> _detailImages = [];
  List<TicketOptionRequest> _ticketOptionRequest = []; // 티켓 옵션

  // ===== Getter =====
  File? get profileImage => _profileImage;
  String get title => _title;
  PerformanceCategory get category => _category;
  DateTime? get reservationStartAt => _reservationStartAt;
  DateTime? get reservationEndAt => _reservationEndAt;
  List<ScheduleRequest> get schedules => _schedules;
  PerformanceLocation get location => _location;
  TicketType get ticketType => _ticketType;
  int get maxTicketsPerUser => _maxTicketsPerUser;
  String get bankAccount => _bankAccount;

  List<SeatUnavailableScheduleRequest> get seatUnavailableSchedules =>
      _seatUnavailableSchedules;

  String get content => _content;
  String get ticketInfoText => _ticketInfoText;
  String get noticeText => _noticeText;
  List<File> get detailImages => _detailImages;

  // ===== Setter =====

  // 1페이지
  void setPage1Info(
      {required File profileImage,
      required String title,
      required PerformanceCategory category,
      required DateTime reservationStartAt,
      required DateTime reservationEndAt,
      required List<ScheduleRequest> schedules,
      required PerformanceLocation location,
      required int maxTicketsPerUser,
      TicketType ticketType = TicketType.PAID, // 기본값은 일반 티켓
      required List<TicketOptionRequest> ticketOptionRequest, // 티켓 옵션
      required String bankAccount}) {
    _profileImage = profileImage;
    _title = title;
    _category = category;
    _reservationStartAt = reservationStartAt;
    _reservationEndAt = reservationEndAt;
    _schedules = schedules;
    _location = location;
    _maxTicketsPerUser = maxTicketsPerUser;
    _ticketType = ticketType; // 기본값은 일반 티켓
    _ticketOptionRequest = ticketOptionRequest;
    _bankAccount = bankAccount; // 백계좌 정보는 나중에 추가
    notifyListeners();
  }

  // 2페이지
  void setPage2UnavailableSeats(
      List<SeatUnavailableScheduleRequest> seatUnavailableSchedules) {
    _seatUnavailableSchedules = seatUnavailableSchedules;
    notifyListeners();
  }

  // 3페이지
  void setPage3Details({
    required String ticketInfoText,
    required String noticeText,
    required List<File> detailImages,
  }) {
    _ticketInfoText = ticketInfoText;
    _noticeText = noticeText;
    _detailImages = detailImages;
    notifyListeners();
  }

  // 요청 객체 생성
  PerformancePostCreateRequest buildRequest() {
    return PerformancePostCreateRequest(
      title: _title, // 여러 문구를 content에 통합
      location: _location,
      reservationStartAt: _reservationStartAt!,
      reservationEndAt: _reservationEndAt!,
      schedules: _schedules,
      seatUnavailableSchedules: _seatUnavailableSchedules,
      ticketType: _ticketType, // 기본값은 일반 티켓
      category: _category, // 기본값은 기타
      backAccount: '', // 백계좌 정보는 나중에 추가
      timeNotice: _content, // 공연 시간 안내 문구
      priceNotice: _ticketInfoText, // 티켓 가격 정보 안내 문구
      reservationNotice: _noticeText, // 예매 공지사항 문구
      maxTicketsPerUser: _maxTicketsPerUser, // 최대 티켓 수
      ticketOptions: _ticketOptionRequest, // 티켓 옵션
    );
  }

  String _composeContent() {
    return '''
[공연 시간 안내]
$_content

[티켓 가격 정보]
$_ticketInfoText

[예매 공지사항]
$_noticeText
''';
  }

  void clearAll() {
    _profileImage = null;
    _title = '';
    _category = PerformanceCategory.ETC; // 기본값은 기타
    _reservationStartAt = null;
    _reservationEndAt = null;
    _schedules = [];
    _location = PerformanceLocation.HAKGWAN_104; // 기본값은 학관 104호
    _seatUnavailableSchedules = [];
    _content = '';
    _ticketInfoText = '';
    _noticeText = '';
    _detailImages = [];
    notifyListeners();
  }
}
