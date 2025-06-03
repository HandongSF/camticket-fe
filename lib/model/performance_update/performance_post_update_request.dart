import '../performance_create/schedule_request.dart';
import '../performance_create/ticket_option_request.dart';
import '../performance_create/seat_unavailable_schedule_request.dart';

class PerformancePostUpdateRequest {
  final int id;
  final String title; //
  final PerformanceCategory category; //
  final PerformanceLocation location; //
  final TicketType ticketType; //
  final int maxTicketsPerUser; //
  final String bankAccount; //
  final DateTime reservationStartAt; //최대 티켓 수
  final DateTime reservationEndAt;

  final String timeNotice;
  final String priceNotice;
  final String reservationNotice;

  final List<ScheduleRequest> schedules;
  final List<TicketOptionRequest> ticketOptions;
  final List<SeatUnavailableScheduleRequest> seatUnavailableCodesPerSchedule;

  PerformancePostUpdateRequest({
    required this.id,
    required this.title,
    required this.location,
    required this.reservationStartAt,
    required this.reservationEndAt,
    required this.schedules,
    required this.ticketOptions,
    required this.maxTicketsPerUser,
    required this.seatUnavailableCodesPerSchedule,
    required this.ticketType, // 기본값은 일반 티켓
    required this.category,
    required this.bankAccount,
    required this.timeNotice,
    required this.priceNotice,
    required this.reservationNotice,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location.toString().split('.').last, // Enum을 문자열로 변환
        'reservationStartAt': reservationStartAt.toIso8601String(),
        'reservationEndAt': reservationEndAt.toIso8601String(),
        'schedules': schedules.map((s) => s.toJson()).toList(),
        'ticketOptions': ticketOptions.map((t) => t.toJson()).toList(),
        'maxTicketsPerUser': maxTicketsPerUser,
        'seatUnavailableCodesPerSchedule':
            seatUnavailableCodesPerSchedule.map((s) => s.toJson()).toList(),
        'ticketType': ticketType.toString().split('.').last, // Enum을 문자열로 변환
        'category': category.toString().split('.').last, // Enum을 문자열로 변환
        'backAccount': bankAccount,
        'timeNotice': timeNotice,
        'priceNotice': priceNotice,
        'reservationNotice': reservationNotice,
      };
}

enum PerformanceCategory { ACT_MUSICAL, CONCERT, PLAY, MUSIC, DANCE, ETC }

enum PerformanceLocation {
  HAKGWAN_104, //("학관 104호"),
  BUSAN, //("BUSAN"),
  INCHEON, //("INCHEON"),
  ETC, //("기타");
}

enum TicketType { PAID, FREE }
