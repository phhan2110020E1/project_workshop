// ignore_for_file: avoid_print, non_constant_identifier_names, unrelated_type_equality_checks, use_rethrow_when_possible, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:workshop_mobi/model/rating/home_rageListRatingDTO.dart';
import 'package:workshop_mobi/model/student/favorite.dart';
import 'package:workshop_mobi/model/student/wallet.dart';
import 'package:workshop_mobi/model/student/workshop_endroll.dart';
import 'package:workshop_mobi/model/userInforResponse.dart';
import 'package:workshop_mobi/model/workshop/ListWorkShopSortByRating.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';
import 'package:workshop_mobi/model/workshopResquest.dart';
import 'package:workshop_mobi/model/workshopUpdateRequest.dart';
import 'package:workshop_mobi/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

import '../model/teacher/ListTeacherSortByRating.dart';

class ApiService {
  ApiService();
  //---------------------------------------------------------------Public Service//---------------------------------------------------------------//

  Future<dynamic> loginWebAccount(String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginWebAccount);
      Map body = {
        'email': email.trim(),
        'password': password,
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'success') {
          var data = json['data'];
          var user = data['user'];
          return user;
        } else if (json['code'] == 1) {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occurred";
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> login0AuthenAccount(String email) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginOAuthen);
      Map body = {
        'email': email.trim(),
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'success') {
          var data = json['data'];
          var user = data['user'];
          return user;
        } else if (json['code'] == 1) {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occurred";
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> registerAccount(
      String email, String password, String roles) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.register);
      Map body = {
        'full_name': email.trim(),
        'balance': 0,
        'user_name': email.trim(),
        'email': email.trim(),
        'password': password,
        'phoneNumber': 'string',
        'gender': 'string',
        'role': roles,
        "enable": true
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 202) {
        final json = jsonDecode(response.body);
        return json;
      } else if (response.statusCode == 302) {
        final json = jsonDecode(response.body);
        return json;
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occurred";
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> resetPassword(String email) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(
        '${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.resetPassword}?Email=$email');
    var data = {
      'Email': email,
    };

    try {
      final http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 202) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == 'Success') {
          return jsonResponse;
        } else {
          throw jsonResponse['message'] ?? 'Failed to Reset Password ';
        }
      } else {
        final dynamic errorResponse = jsonDecode(response.body);
        throw errorResponse?['message'] ?? 'Unknown Error Occurred';
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<CourseResponses>> listworkshop() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.homePageEndPoints.listWorkshop);
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 202) {
        List<CourseResponses> workshopList = parseWorkshopList(response.body);
        return workshopList;
      } else {
        // Xử lý mã lỗi cụ thể nếu có
        print('Error listworkshop: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      // Xử lý lỗi nếu có
      print('Error listworkshop: $error');
      rethrow;
    }
  }

  Future<List<HomePageListRatingDTO>> listRating(
      int workshopId, int teacherId) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          '${ApiEndPoints.baseUrl}${ApiEndPoints.homePageEndPoints.listRating}?workshopId=$workshopId&teacherId=$teacherId');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<HomePageListRatingDTO> ratingList = parseRatingList(response.body);
        return ratingList;
      } else {
        // Xử lý mã lỗi cụ thể nếu có
        print('Error listworkshop: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      // Xử lý lỗi nếu có
      print('Error listworkshop: $error');
      rethrow;
    }
  }

  Future<List<ListTeacherSortRating>> ListTeacherSortByRating() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.homePageEndPoints.ListTeacherSortByRating);
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 202) {
        var json = jsonDecode(response.body);
        if (json['data'] != null) {
          Iterable data = json['data'];
          print(data);
          return List<ListTeacherSortRating>.from(
              data.map((model) => ListTeacherSortRating.fromJson(model)));
        } else {
          return [];
        }
      } else {
        print('Error ListTeacherSortByRating: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error ListTeacherSortByRating: $error');
      rethrow;
    }
  }

  Future<List<WorkshopRatingDTO>> ListWorkShopSortByRating() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.homePageEndPoints.ListWorkShopSortByRating);
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 202) {
        var json = jsonDecode(response.body);
        if (json['data'] != null) {
          Iterable data = json['data'];
          print(data);
          return List<WorkshopRatingDTO>.from(
              data.map((model) => WorkshopRatingDTO.fromJson(model)));
        } else {
          return [];
        }
      } else {
        print('Error ListWorkShopSortByRating: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error ListWorkShopSortByRating: $error');
      rethrow;
    }
  }
  //---------------------------------------------------------------Public Service//---------------------------------------------------------------//

  List<CourseResponses> parseWorkshopList(String responseBody) {
    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    List<dynamic> workshopData = jsonResponse['data'];
    List<CourseResponses> workshopList = workshopData
        .map((workshopJson) => CourseResponses.fromJson(workshopJson))
        .toList();
    return workshopList;
  }

  List<HomePageListRatingDTO> parseRatingList(String responseBody) {
    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    List<dynamic> workshopData = jsonResponse['data'];
    List<HomePageListRatingDTO> workshopList = workshopData
        .map((workshopJson) => HomePageListRatingDTO.fromJson(workshopJson))
        .toList();
    return workshopList;
  }

  List<workshopEndrollResponses> parseWorkshopEndroll(String responseBody) {
    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    List<dynamic> workshopData = jsonResponse['data'];
    List<workshopEndrollResponses> workshopList = workshopData
        .map((workshopJson) => workshopEndrollResponses.fromJson(workshopJson))
        .toList();
    return workshopList;
  }

//---------------------------------------------------------------Teacher Service//---------------------------------------------------------------//
  Future<List<CourseResponses>> listWorkShopTeacher(String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.teacherEndPoints.listWorkshop);

      final http.Response response = await http.get(url, headers: headers);
      print(response.body);
      List<CourseResponses> workshopList = parseWorkshopList(response.body);
      return workshopList;
    } catch (error) {
      throw error.toString();
    }
  }

//---------------------------------------------------------------Teacher Service//---------------------------------------------------------------//

//---------------------------------------------------------------Student Service//---------------------------------------------------------------//
  Future<dynamic> rating(int? teacherId, String? targetType, int? workshopId,
      double rating, String? comment, String? token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.studentEndPoints.ratings);
      Map body = {
        "teacherId": teacherId,
        "targetType": targetType,
        "workshopId": workshopId,
        "rating": rating,
        "comment": comment
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<FavoriteDTO>> listfavorite(String? token) async {
    
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.studentEndPoints.listFavorite);
      http.Response response = await http.get(url, headers: headers);
      print('url trong hàm listfavorite: ${url}');

      print('token trong hàm listfavorite: ${token}');
      print('response.statusCode : ${response.statusCode}');

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        var data = jsonBody['data'];
        List<dynamic> jsonData = data;
        return jsonData.map((item) => FavoriteDTO.fromJson(item)).toList();
      } else {
        // Xử lý các trường hợp phản hồi không thành công
        throw Exception('Failed to load favorites');
      }
    } catch (error) {
      // Xử lý lỗi mạng hoặc lỗi xử lý dữ liệu
      rethrow;
    }
  }

  Future<dynamic> like(int? teacherId, String? targetType, int? workshopId,
      String? token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.studentEndPoints.like);
      Map body = {
        "teacherId": teacherId,
        "workshopId": workshopId,
        "targetType": targetType,
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      print(response.statusCode);
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> checklike(int? workshopId, String? token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          '${ApiEndPoints.baseUrl}${ApiEndPoints.studentEndPoints.checklike}?course_id=$workshopId');

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(response.body);
        var data = body['data'];
        if (data == true) {
          return true;
        } else {
          return false;
        }
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> checklikeMentor(int? mentorId, String? token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          '${ApiEndPoints.baseUrl}${ApiEndPoints.studentEndPoints.checklikementor}?teacher_id=$mentorId');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(response.body);
        var data = body['data'];
        if (data == true) {
          return true;
        } else {
          return false;
        }
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }
  Future<List<workshopEndrollResponses>> listWorkShopByStudent(
      String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.studentEndPoints.workshopEndroll);
      final http.Response response = await http.get(url, headers: headers);
      List<workshopEndrollResponses> workshopList =
          parseWorkshopEndroll(response.body);
      return workshopList;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<UserInfoResponse> getinforStudent(String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.studentEndPoints.studentInfo);
      final http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 202) {
        final dynamic jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == 'Success') {
          final Map<String, dynamic> userData = jsonResponse['data'];
          print(userData);
          final UserInfoResponse user = UserInfoResponse.fromJson(userData);

          return user;
        } else {
          throw jsonResponse['message'] ?? 'Unknown Error Occurred';
        }
      } else {
        final dynamic errorResponse = jsonDecode(response.body);
        throw errorResponse?['Message'] ?? 'Unknown Error Occurred';
      }
    } catch (error) {
      print('Error in getinforStudent: $error');

      return UserInfoResponse.defaultData();
    }
  }

  Future<List<CourseResponses>> listWorkShopDetailByStudent(
      String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.studentEndPoints.workshopDetailList);
      final http.Response response = await http.get(url, headers: headers);
      // print(response.body);
      List<CourseResponses> workshopList = parseWorkshopList(response.body);
      return workshopList;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<walletResponses> walletStudent(String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.studentEndPoints.wallet);
      final http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final dynamic jsonResponse = jsonDecode(response.body);
        // print(jsonResponse);

        if (jsonResponse['status'] == 'success') {
          final Map<String, dynamic> Data = jsonResponse['data'];

          final walletResponses wallet = walletResponses.fromJson(Data);
          print(wallet);
          return wallet;
        } else {
          throw jsonResponse['message'] ?? 'Unknown Error Occurred';
        }
      } else {
        final dynamic errorResponse = jsonDecode(response.body);
        throw errorResponse?['Message'] ?? 'Unknown Error Occurred';
      }
    } catch (error) {
      throw error.toString(); // Convert the error to a string
    }
  }

  Future<dynamic> deposit(double valueDeposit, String? token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.studentEndPoints.deposit);
      Map body = {
        'type': "string",
        'requestId': 0,
        'status': "string",
        'item_register_id': 0,
        'locationId': 0,
        'amount': valueDeposit,
        'discountAmount': 0,
        'discountCode': "string",
        "paymentName": "string",
        "paymentStatus": "success"
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> checkWorkshopIsFree(String? email, int workshopId) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    // print(email);
    // print(workshopId);
    try {
      var url = Uri.parse(
          '${ApiEndPoints.baseUrl}${ApiEndPoints.homePageEndPoints.checkUserInCourse}?user_email=$email&course_id=$workshopId');
      http.Response response = await http.get(url, headers: headers);
      // print(response.body);

      if (response.statusCode == 202) {
        final dynamic body = jsonDecode(response.body);
        var data = body['data'];
        if (data == true) {
          return true;
        } else {
          return false;
        }
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<int> checkDiscountWorkshop(
      String? token, int courseId, String code) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          '${ApiEndPoints.baseUrl}${ApiEndPoints.studentEndPoints.checkDiscount}?courseId=$courseId&code=$code');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 202) {
        final dynamic body = jsonDecode(response.body);
        var data = body['data'];
        return data;
      } else if (response.statusCode == 200) {
        return 0;
      } else {
        print('Error: ${response.statusCode}');
        return -1;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<int> buyWorkshop(
      String? token,
      String? paymentType,
      int item_register_id,
      double amount,
      double? discountAmount,
      String? discountCode) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.studentEndPoints.buyWorkshop);
      Map body = {
        'type': "string",
        'requestId': 0,
        'status': paymentType,
        'item_register_id': item_register_id,
        'locationId': 0,
        'amount': amount,
        'discountAmount': discountAmount,
        'discountCode': discountCode,
        "paymentName": "string",
        "paymentStatus": "success"
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      print(response.statusCode);
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> checkQrCode(String? token, int userId, int workshopId) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          '${ApiEndPoints.baseUrl}${ApiEndPoints.teacherEndPoints.checkTicket}?userId=$userId&workshopId=$workshopId');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 202) {
        // final dynamic body = jsonDecode(response.body);
        return true;
      } else if (response.statusCode == 200) {
        return false;
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<void> addNewWorkshop({
    required CourseRequest workshop,
    required String token,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.teacherEndPoints.addWorshop);

      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(workshop.toJson()),
      );

      if (response.statusCode == 201) {
        final responseBody = response.body.toString();
        if (responseBody.isNotEmpty) {
          final json = jsonDecode(responseBody);
          if (json['status'] == 'success') {
            var data = json['data'];
            var user = data['user'];
            return user;
          } else if (json['code'] == 1) {
            throw json['message'] ?? 'Unknown error';
          }
        } else {
          throw 'Empty response body';
        }
      } else {
        // Handle different HTTP status codes with more detailed messages
        if (response.statusCode == 400) {
          throw 'Bad Request: ${jsonDecode(response.body)['message']}';
        } else if (response.statusCode == 401) {
          throw 'Unauthorized: ${jsonDecode(response.body)['message']}';
        } else if (response.statusCode == 403) {
          throw 'Forbidden: ${jsonDecode(response.body)['message']}';
        } else if (response.statusCode == 404) {
          throw 'Not Found: ${jsonDecode(response.body)['message']}';
        } else {
          throw 'HTTP ${response.statusCode}: ${jsonDecode(response.body)['message']}';
        }
      }
    } catch (error) {
      print('Error when adding workshop: $error');
      throw error;
    }
  }

  Future<List<CourseResponses>> getWorkshopById(int id, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse(
        '${ApiEndPoints.baseUrl}${ApiEndPoints.teacherEndPoints.listWorshopId}/{id}?courseId=$id',
      );

      final http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<CourseResponses> workshopList = parseWorkshopList(response.body);

        if (workshopList.isNotEmpty) {
          // Fix: Use workshopList instead of jsonResponse
          return workshopList;
        } else {
          throw 'Empty response body';
        }
      } else {
        // Handle different HTTP status codes with more detailed messages
        // ...
        throw 'HTTP ${response.statusCode}: ${jsonDecode(response.body)['message']}';
      }
    } catch (error) {
      print('Error when getting workshop by ID: $error');
      throw error;
    }
  }

  Future<dynamic> depositTeacher(double valueDeposit, String? token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.teacherEndPoints.withdraw);
      Map body = {
        'type': "string",
        'requestId': 0,
        'status': "string",
        'item_register_id': 0,
        'locationId': 0,
        'amount': valueDeposit,
        'discountAmount': 0,
        'discountCode': "string",
        "paymentName": "string",
        "paymentStatus": "success"
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> editWorkshop({
    required int workshopId,
    required CourseUpdateRequest updatedWorkshop,
    required String token,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    print(updatedWorkshop.toJson());

    try {
      var url = Uri.parse(
        '${ApiEndPoints.baseUrl}${ApiEndPoints.teacherEndPoints.editWorshop}/$workshopId',
      );
      // var requestBody = {
      //   // 'workshopId': workshopId,
      //   // 'updatedWorkshop':
      //   updatedWorkshop.toJson(),
      // };
      var requestBody = updatedWorkshop.toJson();
      print('Request body before encoding: ${updatedWorkshop.toJson()}');
      http.Response response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.body.isEmpty) {
        throw 'Empty response body';
      }

      try {
        final json = jsonDecode(response.body);
        // Xử lý JSON ở đây
        if (json['status'] == 'success') {
          // Workshop edited successfully
        } else if (json['code'] == 1) {
          throw json['message'] ?? 'Unknown error';
        }
      } catch (e) {
        print('Error decoding JSON: $e');
        // Xử lý lỗi giải mã JSON
      }

      if (response.statusCode == 201) {
        final responseBody = response.body.toString();
        // Use 'responseBody' for something later in your code
        print('Response body: $responseBody');
        // Có thể xử lý thêm ở đây nếu cần
      } else {
        // Handle different HTTP status codes with more detailed messages
        if (response.statusCode == 400) {
          throw 'Bad Request: ${jsonDecode(response.body)['message']}';
        } else if (response.statusCode == 401) {
          throw 'Unauthorized: ${jsonDecode(response.body)['message']}';
        } else if (response.statusCode == 403) {
          throw 'Forbidden: ${jsonDecode(response.body)['message']}';
        } else if (response.statusCode == 404) {
          throw 'Not Found: ${jsonDecode(response.body)['message']}';
        } else {
          throw 'HTTP ${response.statusCode}: ${jsonDecode(response.body)['message']}';
        }
      }
    } catch (error) {
      print('Error when editing workshop: $error');
      throw error;
    }
  }

  Future<dynamic> withdraw(double valueDeposit, String? token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.teacherEndPoints.withdraw);
      Map body = {
        'type': "string",
        'requestId': 0,
        'status': "string",
        'item_register_id': 0,
        'locationId': 0,
        'amount': valueDeposit,
        'discountAmount': 0,
        'discountCode': "string",
        "paymentName": "string",
        "paymentStatus": "success"
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

Future<dynamic> editProfile({
   int? id,
  String? full_name,
  String? user_name,
  String? email,
  int? phoneNumber,
  String? image_url,
  String? state,
  String? address,
  String? city,
  int? postalCode,
}) async {
  var headers = {
    'Content-Type': 'application/json',
  };

  try {
    var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.editProfile);

    Map body = {
      "full_name": full_name,
      "user_name": user_name,
      "email": email,
      "phoneNumber": phoneNumber,
      "image_url": image_url,
      "userAddresses": [
        {
          "id": id,
          "state": state,
          "address": address,
          "city": city,
          "postalCode": postalCode,
        }
      ],
    };

    http.Response response =
        await http.put(url, body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // Handle the response as needed
      return json;
    } else {
      throw 'Failed to edit profile: ${response.statusCode}';
    }
  } catch (error) {
    rethrow;
  }
}


}
