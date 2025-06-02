import 'package:camticket/components/buttons.dart';
import 'package:camticket/components/texts.dart';
import 'package:camticket/model/performanceDetail.dart';
import 'package:camticket/model/performance_overview_model.dart';
import 'package:camticket/provider/selected_performance_provider.dart';
import 'package:camticket/src/pages/searchpage.dart';
import 'package:camticket/src/pages/user/performance_seat_reservation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../components/bottomSheet.dart';
import '../../components/text_pair.dart';
import '../../provider/performance_provider.dart';
import '../../utility/color.dart';

class PerformanceDetailPage extends StatefulWidget {
  final PerformanceOverview item;
  const PerformanceDetailPage({super.key, required this.item});
  @override
  State<PerformanceDetailPage> createState() => _PerformanceDetailPageState();
}

class _PerformanceDetailPageState extends State<PerformanceDetailPage> {
  int _selectedTabIndex = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PerformanceProvider>(context, listen: false)
          .fetchPerformanceDetail(widget.item.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final performanceProvider =
        Provider.of<PerformanceProvider>(context, listen: false);
    final performanceDetails = performanceProvider.performanceDetails;
    return Scaffold(
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
                    MaterialPageRoute(builder: (context) => const Searchpage()),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  size: 24,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 배경 이미지
            Padding(
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 240, // 고정 높이
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter, // 상단 정렬
                    child: Image.network(
                      widget.item.profileImageUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover, // 이미지 확대해서 자르기 (높이 채우기)
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 공연 제목
                  Expanded(
                    child: SizedBox(
                      height: 228,
                      child: Image.network(
                        widget.item.profileImageUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(width: 12), // 간격 조정
                  Expanded(
                    child: SizedBox(
                      height: 228,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          subPurpleBtn('유료 공연'),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            child: Text(
                              widget.item.title,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.32,
                                  height: 0),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          grayAndWhite('카테고리', widget.item.category),
                          grayAndWhite('예매 기간',
                              '${DateFormat('MM.dd ').format(widget.item.reservationStartAt)} ~ ${DateFormat('MM.dd').format(widget.item.reservationEndAt)}'),
                          grayAndWhite(
                              '공연날짜',
                              DateFormat('MM.dd HH:mm')
                                  .format(widget.item.firstScheduleStartTime)),
                          grayAndWhite('장소', widget.item.location),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTabItem('상세정보', 0),
                  _buildTabItem('예매안내', 1),
                  _buildTabItem('공연장정보', 2)
                ],
              ),
            ),
            _buildTabContent(performanceDetails),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Provider.of<SelectedPerformanceProvider>(context, listen: false)
              .setSelectedPerformance(performanceDetails);
          showRoundSelectBottomSheet(
            context,
            (Schedule selectedSchedule) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerformanceSeatReservationPage(
                    schedule: selectedSchedule,
                  ),
                ),
              );
            },
            performanceDetails.schedules,
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: mainPurpleBtn('예매하기'),
        ),
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: _selectedTabIndex == index
                  ? AppColors.mainPurple
                  : AppColors.gray4,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 9,
          ),
          if (_selectedTabIndex == index)
            Container(
              width: 28,
              height: 2,
              decoration: BoxDecoration(color: AppColors.mainPurple),
            )
        ],
      ),
    );
  }

  String formatDateWithWeekday(DateTime date) {
    // "11월 23일 토요일" 형식
    final formatted = DateFormat('M월 d일 EEEE', 'ko').format(date);
    return formatted;
  }

  Widget _buildTabContent(PerformanceDetail performanceDetails) {
    switch (_selectedTabIndex) {
      case 0:
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subPurpleText('공연 시간'),
              SizedBox(height: 8),
              Text(
                DateFormat('M월 d일 EEEE', 'ko')
                    .format(widget.item.firstScheduleStartTime),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              Divider(
                color: AppColors.gray4, // 선 색상
                thickness: 0.5, // 선 두께
              ),
              SizedBox(height: 20),
              Text('가격정보',
                  style: TextStyle(
                      color: Color(0xFFE4C3FF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('모든 관람객 3,000원\n새내기일 경우 1,000원 할인하여 2,000원! (현장 학생증 지참)',
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              Divider(
                color: AppColors.gray4, // 선 색상
                thickness: 0.5, // 선 두께
              ),
              SizedBox(height: 20),
              Text('예매 공지사항',
                  style: TextStyle(
                      color: Color(0xFFE4C3FF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('11/18 월요일 오후 2시 - 5시 오프라인 티켓 예매 가능합니다.\n1인 4매까지 예매 가능합니다.',
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              Divider(
                color: AppColors.gray4, // 선 색상
                thickness: 0.5, // 선 두께
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      case 1:
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('티켓 수령 방법 안내',
                  style: TextStyle(
                      color: Color(0xFFE4C3FF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '티켓은 앱을 통해 온라인으로 수령하실 수 있습니다.\n앱 하단 메뉴의 ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                    TextSpan(
                      text: '‘마이 → 티켓 보기’',
                      style: TextStyle(
                        color: Color(0xFFE4C3FF),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                    TextSpan(
                      text: '에서 수령된 티켓을 확인하실 수 있습니다.\n\n예매가 완료된 후, 해당 공연의 ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                    TextSpan(
                      text: '아티스트 측에서 관람객님의 입금 정보를 확정',
                      style: TextStyle(
                        color: Color(0xFFE4C3FF),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                    TextSpan(
                      text: '한 뒤 ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                    TextSpan(
                      text: '티켓 수령',
                      style: TextStyle(
                        color: Color(0xFFE4C3FF),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                    TextSpan(
                      text:
                          '이 가능합니다.  ※ 단, 무료 공연의 경우 입금 정보 확인 절차 없이 즉시 수령이 가능하나, 선착순 공연일 경우 조기 마감으로 인해 티켓 수령이 불가할 수 있으니 이 점 유의해 주세요.\n\n캠티켓 앱은 무단 캡쳐 및 도용을 방지하기 위해, 실시간으로 움직이는 ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                    TextSpan(
                      text: '‘스크린샷 방지 씰’',
                      style: TextStyle(
                        color: Color(0xFFE4C3FF),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                    TextSpan(
                      text:
                          '을 적용하고 있습니다. 따라서 티켓을 캡쳐하거나 도용하여 사용하는 일이 없도록 각별히 주의해 주시기 바랍니다.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: AppColors.gray4, // 선 색상
                thickness: 0.5, // 선 두께
              ),
              SizedBox(height: 20),
              Text('취소/환불 안내',
                  style: TextStyle(
                      color: Color(0xFFE4C3FF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                '취소마감시간 이후 또는 관람일 당일 예매하신 건에 대해서는 취소/변경/환불이 불가능합니다.\n\n환불 요청 시 아티스트 측에서 해당 환불건에 대해서 확인한 뒤 관람객님의 등록된 환불 계좌번호로 환불 금액을 입금해드립니다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.28,
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: AppColors.gray4, // 선 색상
                thickness: 0.5, // 선 두께
              ),
              SizedBox(height: 20),
              Text('예매 안내',
                  style: TextStyle(
                      color: Color(0xFFE4C3FF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                  ' 원하시는 공연 회차와 좌석 선택 후, 예매자 정보 기입과 티켓 가격 선택 후 결제 금액에 해당하는 금액을 명시되어있는 아티스트의 계좌번호로 입금 후 ‘입금 여부 체크\' 박스를 체크 후 예매 완료를 진행하시면 됩니다.\n\n※ 잘못된 계좌번호로 입금 혹은 결제금액과 일치하지 않은 금액 입금시 해당 예매건이 취소될 수 있습니다.',
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              Divider(
                color: AppColors.gray4, // 선 색상
                thickness: 0.5, // 선 두께
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      case 2:
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('공연장 위치',
                  style: TextStyle(
                      color: Color(0xFFE4C3FF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                widget.item.location,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Divider(
                color: AppColors.gray4, // 선 색상
                thickness: 0.5, // 선 두께
              ),
              const SizedBox(height: 20),
              const Text('찾아오는 길',
                  style: TextStyle(
                      color: Color(0xFFE4C3FF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('걸어서', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 20),
              const Divider(
                color: AppColors.gray4, // 선 색상
                thickness: 0.5, // 선 두께
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
