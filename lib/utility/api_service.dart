import 'dart:convert';
import 'dart:io';

import 'package:camticket/model/manage_overview.dart';
import 'package:camticket/model/reservation_list_model.dart';
import 'package:camticket/utility/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../auth/secure_storage.dart';
import '../model/performanceDetail.dart';
import '../model/performance_create/performance_post_create_request.dart';
import '../model/performance_update/performance_post_update_request.dart';
import '../model/performance_overview_model.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class ApiService {
  final SecureStorage secureStorage = SecureStorage();

  Future<List<PerformanceOverview>> fetchOverview() async {
    final accessToken = await secureStorage.readToken("x-access-token");
    debugPrint('저장된 액세스 토큰: $accessToken');
    debugPrint(
        'API 호출: ${ApiConstants.baseUrl}/camticket/api/performance/overview');

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/camticket/api/performance/overview'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    debugPrint('API 응답: ${response.statusCode} : ${response.body}');

    if (response.statusCode == 200) {
      final jsonMap = json.decode(utf8.decode(response.bodyBytes));
      final List<dynamic> data = jsonMap['data'];
      debugPrint('성공적으로 데이터를 가져왔습니다: ${data.length}개 항목');

      // 1. Overview 모델 리스트 생성
      List<PerformanceOverview> overviewList =
          data.map((e) => PerformanceOverview.fromJson(e)).toList();

      // 2. 각 item에 대해 이미지 추가 요청 병렬 수행
      await Future.wait(overviewList.map((item) async {
        try {
          debugPrint('이미지 URL 가져오기: userId=${item.userId}');
          final imageUrl = await fetchOverviewImage(item.userId);
          item.profileImageUrl2 = imageUrl;
        } catch (e) {
          debugPrint('이미지 URL 가져오기: userId=${item.userId}');
          debugPrint('이미지 가져오기 실패: $e');
          item.profileImageUrl2 = 'null';
        }
      }));

      return overviewList;
    } else {
      throw Exception('서버 오류: ${response.statusCode}');
    }
  }

  Future<String> fetchOverviewImage(int userId) async {
    final accessToken = await secureStorage.readToken("x-access-token");
    // debugPrint('저장된 액세스 토큰: $accessToken');
    // debugPrint('이미지 URL 가져오기: userId=$userId');

    final response = await http.get(
      Uri.parse(
          '${ApiConstants.baseUrl}/camticket/api/performance/profile/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(utf8.decode(response.bodyBytes));
      final List<dynamic> data = jsonMap['data'];

      if (data.isNotEmpty && data[0]['profileImageUrl'] != null) {
        final imageUrl = data[0]['profileImageUrl'] as String;
        return imageUrl;
      } else {
        throw Exception('데이터가 비어있거나 profileImageUrl이 없음');
      }
    } else {
      throw Exception('프로필 이미지 요청 실패: ${response.statusCode}');
    }
  }

  Future<PerformanceDetail> fetchPerformanceDetail(int postId) async {
    final accessToken = await secureStorage.readToken("x-access-token");
    final response = await http.get(
      Uri.parse(
          '${ApiConstants.baseUrl}/camticket/api/performance-management/$postId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    debugPrint('API 응답: ${response.statusCode} : ${response.body}');

    if (response.statusCode == 200) {
      final jsonMap = json.decode(utf8.decode(response.bodyBytes));
      final data = jsonMap['data'];

      debugPrint('성공적으로 티켓 상세 데이터를 가져왔습니다.');

      return PerformanceDetail.fromJson(data);
    } else {
      throw Exception('서버 오류: ${response.statusCode}');
    }
  }

  Future<int?> createPerformancePost({
    required PerformancePostCreateRequest requestData,
    required File profileImage,
    List<File> detailImages = const [],
  }) async {
    try {
      debugPrint('requestData: ${requestData.toJson()}');

      final accessToken = await secureStorage.readToken("x-access-token");

      final uri = Uri.parse(
          '${ApiConstants.baseUrl}/camticket/api/performance-management');

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $accessToken';

      final jsonPart = http.MultipartFile.fromString(
        'request',
        jsonEncode(requestData.toJson()),
        contentType: MediaType('application', 'json'),
      );
      request.files.add(jsonPart);

      request.files.add(await http.MultipartFile.fromPath(
        'profileImage',
        profileImage.path,
        contentType: MediaType(
          'image',
          lookupMimeType(profileImage.path) ?? 'jpeg',
        ),
      ));
      for (var img in detailImages) {
        request.files.add(await http.MultipartFile.fromPath(
          'detailImages',
          img.path,
          contentType: MediaType(
            'image',
            lookupMimeType(img.path) ?? 'jpeg',
          ),
        ));
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print("공연 등록 성공: postId = ${data['data']}");
        return data['data']; // postId 반환
      } else {
        print("공연 등록 실패: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e, stackTrace) {
      print("공연 등록 중 예외 발생: $e");
      print("StackTrace: $stackTrace");
      return null;
    }
  }

  Future<bool> updatePerformancePost({
    required PerformancePostUpdateRequest requestData,
    List<File> detailImages = const [],
    required int postId,
  }) async {
    try {
      debugPrint('requestData: ${requestData.toJson()}');

      final accessToken = await secureStorage.readToken("x-access-token");

      final uri = Uri.parse(
          '${ApiConstants.baseUrl}/camticket/api/performance-management/$postId');

      var request = http.MultipartRequest('PUT', uri)
        ..headers['Authorization'] = 'Bearer $accessToken';

      final jsonPart = http.MultipartFile.fromString(
        'request',
        jsonEncode(requestData.toJson()),
        contentType: MediaType('application', 'json'),
      );
      request.files.add(jsonPart);

      for (var img in detailImages) {
        request.files.add(await http.MultipartFile.fromPath(
          'newDetailImages',
          img.path,
          contentType: MediaType(
            'image',
            lookupMimeType(img.path) ?? 'jpeg',
          ),
        ));
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print("공연 등록 성공: postId = ${data['data']}");
        return true; // postId 반환
      } else {
        print("공연 등록 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e, stackTrace) {
      print("공연 등록 중 예외 발생: $e");
      print("StackTrace: $stackTrace");
      return false;
    }
  }

  Future<User> fetchUserInfo(int userId) async {
    final accessToken = await secureStorage.readToken("x-access-token");

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/camticket/api/user/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final jsonMap = json.decode(utf8.decode(response.bodyBytes));
      final data = jsonMap['data'];

      return User.fromJson(data);
    } else {
      throw Exception('유저 정보를 불러오는 데 실패했습니다: ${response.statusCode}');
    }
  }

  Future<List<ReservationData>> fetchReservationList(int postId) async {
    final accessToken = await secureStorage.readToken("x-access-token");

    final response = await http.get(
      Uri.parse(
          '${ApiConstants.baseUrl}/camticket/api/reservation/management/performance/$postId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    //debugPrint('response.bodyBytes : ${response.headers}');
    if (response.statusCode == 200) {
      final jsonMap = json.decode(utf8.decode(response.bodyBytes));
      final data = jsonMap['data'];
/*
List<PerformanceOverview> overviewList =
          data.map((e) => PerformanceOverview.fromJson(e)).toList();
 */
      List<ReservationData> reservationList = (jsonMap['data'] as List)
          .map((e) => ReservationData.fromJson(e))
          .toList();
      debugPrint(reservationList.length.toString());
      return reservationList;
    } else {
      throw Exception('유저 정보를 불러오는 데 실패했습니다: ${response.statusCode}');
    }
  }

  Future<List<ManageOverview>> fetchManageOverviewImage() async {
    final accessToken = await secureStorage.readToken("x-access-token");
    // debugPrint('저장된 액세스 토큰: $accessToken');
    // debugPrint('이미지 URL 가져오기: userId=$userId');

    final response = await http.get(
      Uri.parse(
          '${ApiConstants.baseUrl}/camticket/api/performance-management/overview'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    debugPrint('API 응답: ${response.statusCode} : ${response.body}');

    if (response.statusCode == 200) {
      final jsonMap = json.decode(utf8.decode(response.bodyBytes));
      final data = jsonMap['data'];
      if (data.isNotEmpty) {
        debugPrint('데이터가 비어있지 않습니다. profileImageUrl이 있는지 확인합니다.');
        try {
          List<ManageOverview> manageOverviewList =
              data.map<ManageOverview>((e) {
            try {
              return ManageOverview.fromJson(e);
            } catch (e) {
              debugPrint('fromJson 변환 중 오류 발생: $e\n데이터: $e');
              rethrow;
            }
          }).toList();

          debugPrint('성공적으로 데이터를 가져왔습니다: ${manageOverviewList.length}개 항목');
          return manageOverviewList;
        } catch (e) {
          debugPrint('데이터 파싱 실패: $e');
          throw Exception('ManageOverview 리스트 생성 중 오류');
        }
        // 각 항목에 대해 이미지 URL을 가져오는 비동기 작업 수행
      } else {
        throw Exception('데이터가 비어있거나 profileImageUrl이 없음');
      }
    } else {
      throw Exception('프로필 이미지 요청 실패: ${response.statusCode}');
    }
  }

  Future<void> deletePerformance(int postId) async {
    final accessToken = await secureStorage.readToken("x-access-token");
    final response = await http.delete(
      Uri.parse(
          '${ApiConstants.baseUrl}/camticket/api/performance-management/$postId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    debugPrint('API 응답: ${response.statusCode} : ${response.body}');

    if (response.statusCode == 200) {
      debugPrint('공연 삭제 성공: $postId');
    } else {
      throw Exception('공연 삭제 실패: ${response.statusCode}');
    }
  }
}
