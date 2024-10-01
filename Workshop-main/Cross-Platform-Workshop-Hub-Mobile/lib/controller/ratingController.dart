// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:workshop_mobi/api/api_service.dart';

class RatingController extends GetxController {
  final ApiService apiSerivice = ApiService();
  TextEditingController? commentController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController typerController = TextEditingController();
  var isLoading = false.obs;
  Future<void> commentAndRating(int teacherId, int workshopId) async {
    isLoading(true); // Bắt đầu loading
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    double ratingValue =
        double.tryParse(ratingController.text) ?? 0.0; // Chuyển đổi sang double
    await apiSerivice.rating(teacherId, typerController.text, workshopId,
        ratingValue, commentController?.text, token);
    isLoading(false);
  }
}
