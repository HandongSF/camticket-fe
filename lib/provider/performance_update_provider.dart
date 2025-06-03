import 'dart:io';

import 'package:flutter/material.dart';

import '../model/performance_update/performance_post_update_request.dart';
import '../model/performance_create/schedule_request.dart';
import '../model/performance_create/seat_unavailable_schedule_request.dart';
import '../model/performance_create/ticket_option_request.dart';
import '../utility/api_service.dart';

class PerformanceUpdateProvider with ChangeNotifier {
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
  String _ticketInfoText = ''; // 티켓 가격 정보 안내 문구
  String _noticeText = ''; // 예매 공지사항 문구
  String _timeNotice = ''; // 공연 시간 안내 문구
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

  String get ticketInfoText => _ticketInfoText;
  String get noticeText => _noticeText;
  String get timeNotice => _timeNotice; // 공연 시간 안내 문구
  List<File> get detailImages => _detailImages;

  int postId = 0;

  // ===== Setter =====
  void setPostId(int id) {
    postId = id;
  }

  // 1페이지
  void setPage1Info(
      {required String title,
      required PerformanceCategory category,
      required DateTime reservationStartAt,
      required DateTime reservationEndAt,
      required List<ScheduleRequest> schedules,
      required PerformanceLocation location,
      required int maxTicketsPerUser,
      TicketType ticketType = TicketType.PAID, // 기본값은 일반 티켓
      required List<TicketOptionRequest> ticketOptionRequest, // 티켓 옵션
      required String bankAccount}) {
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

  void showPage1Info() {
    print('Profile Image: ${_profileImage?.path}');
    print('Title: $_title');
    print('Category: $_category');
    print('Reservation Start At: $_reservationStartAt');
    print('Reservation End At: $_reservationEndAt');
    print('Schedules: $_schedules');
    print('Location: $_location');
    print('Max Tickets Per User: $_maxTicketsPerUser');
    print('Ticket Type: $_ticketType');
    print('Ticket Options: $_ticketOptionRequest');
    print('Bank Account: $_bankAccount');
  }

  // 2페이지
  void setPage2UnavailableSeats(
      List<SeatUnavailableScheduleRequest> seatUnavailableSchedules) {
    _seatUnavailableSchedules = seatUnavailableSchedules;
    notifyListeners();
  }

  void showPage2UnavailableSeats() {
    debugPrint('Unavailable Seats: ${_seatUnavailableSchedules[0].codes}');
  }

  // 3페이지
  void setPage3Details({
    required String ticketInfoText,
    required String noticeText,
    required List<File> detailImages,
    required String timeNotice, // 공연 시간 안내 문구
  }) {
    _ticketInfoText = ticketInfoText;
    _noticeText = noticeText;
    _detailImages = detailImages;
    _timeNotice = timeNotice; // 공연 시간 안내 문구
    notifyListeners();
  }

  Future<void> showAll() async {
    print('Profile Image: ${_profileImage?.path}');
    print('Title: $_title');
    print('Category: $_category');
    print('Reservation Start At: $_reservationStartAt');
    print('Reservation End At: $_reservationEndAt');
    print('Schedules: $_schedules');
    print('Location: $_location');
    print('Max Tickets Per User: $_maxTicketsPerUser');
    print('Ticket Type: $_ticketType');
    print('Ticket Options: $_ticketOptionRequest');
    print('Bank Account: $bankAccount');
    print('Unavailable Seats: ${_seatUnavailableSchedules}');
    print('Ticket Info Text: $_ticketInfoText');
    print('Notice Text: $_noticeText');
    print('Time Notice: $_timeNotice'); // 공연 시간 안내 문구
  }

  // 요청 객체 생성
  PerformancePostUpdateRequest buildRequest() {
    return PerformancePostUpdateRequest(
      id: 0,
      title: _title, // 여러 문구를 content에 통합
      location: _location,
      reservationStartAt: _reservationStartAt!,
      reservationEndAt: _reservationEndAt!,
      schedules: _schedules,
      seatUnavailableCodesPerSchedule: _seatUnavailableSchedules,
      ticketType: _ticketType, // 기본값은 일반 티켓
      category: _category, // 기본값은 기타
      bankAccount: bankAccount, // 백계좌 정보는 나중에 추가
      timeNotice: _timeNotice, // 공연 시간 안내 문구
      priceNotice: _ticketInfoText, // 티켓 가격 정보 안내 문구
      reservationNotice: _noticeText, // 예매 공지사항 문구
      maxTicketsPerUser: _maxTicketsPerUser, // 최대 티켓 수
      ticketOptions: _ticketOptionRequest, // 티켓 옵션
    );
  }

  Future<bool> uploadPerformance(int postId) async {
    final request = buildRequest();

    try {
      print('[업로드 시작] 공연명: ${request.title}');

      final post = await ApiService().updatePerformancePost(
        requestData: request,
        detailImages: _detailImages,
        postId: postId,
      );

      if (post) {
        print('[업로드 성공] 등록된 공연 ID: $postId');
        return true;
      } else {
        print('[업로드 실패] postId가 null입니다.');
        return false;
      }
    } catch (e, stack) {
      print('[업로드 에러] $e');
      print(stack);
      return false;
    }
  }

  String _composeContent() {
    return '''
[공연 시간 안내]
$_timeNotice

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
    _timeNotice = '';
    _ticketInfoText = '';
    _noticeText = '';
    _detailImages = [];
    notifyListeners();
  }
}
