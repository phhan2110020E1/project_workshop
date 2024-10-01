import 'package:flutter/material.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/userInforResponse.dart';

class AppState extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  late UserInfoResponse _response;

  UserInfoResponse get response => _response;

  Future<void> getStudentInfo(String accessToken) async {
    _response = await _apiService.getinforStudent(accessToken);
    notifyListeners();
  }

  Future<void> initialize(String accessToken) async {
    await getStudentInfo(accessToken);
  }
}
