import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/workshopUpdateRequest.dart';

class EditWorkshopController extends GetxController {
  final String token;
  final int workshopId;

  EditWorkshopController({required this.token, required this.workshopId});

  final ApiService apiService = ApiService();

  RxString name = "".obs;
  RxString description = "".obs;
  RxDouble price = 0.0.obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().add(const Duration(days: 7)).obs;
  RxInt studentCount = 0.obs;
  RxString type = "".obs;
  RxList<Map<String, dynamic>> courseMediaInfos = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> discountDTOS = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> courseLocations = <Map<String, dynamic>>[].obs;

  set workshop(CourseUpdateRequest workshop) {}

  void setStepData({
    required RxString name,
    required RxString description,
    required RxDouble price,
    required Rx<DateTime> startDate,
    required Rx<DateTime> endDate,
    required RxInt studentCount,
    required RxString type,
    required RxList<Map<String, dynamic>> courseMediaInfos,
    required RxList<Map<String, dynamic>> discountDTOS,
    required RxList<Map<String, dynamic>> courseLocations,
  }) {
    this.name = name;
    this.description = description;
    this.price = price;
    this.startDate = startDate;
    this.endDate = endDate;
    this.studentCount = studentCount;
    this.type = type;
    this.courseMediaInfos = courseMediaInfos;
    this.discountDTOS = discountDTOS;
    this.courseLocations = courseLocations;
  }

  void clearData() {
    name.value = "";
    description.value = "";
    price.value = 0.0;
    startDate.value = DateTime.now();
    endDate.value = DateTime.now().add(const Duration(days: 7));
    studentCount.value = 0;
    type.value = "";
    courseMediaInfos.clear();
    discountDTOS.clear();
    courseLocations.clear();
  }



  void addMediaInfo({
    required int id,
    required String urlMedia,
    required String urlImage,
    required String thumbnailSrc,
    required String title,
  }) {
    print('Addingmedia imager: $urlMedia, scheduleDate: $urlImage');

    courseMediaInfos.add({
      'id': id,
      'urlMedia': urlMedia ?? '',
      'urlImage': urlImage ?? '',
      'thumbnailSrc': thumbnailSrc,
      'title': title,
    });
  }

  void addDiscountDTO({
    required int id,
    required int quantity,
    required DateTime redemptionDate,
    required int valueDiscount,
    required String name,
    required String description,
    required int remainingUses,
  }) {
    discountDTOS.add({
      'id': id,
      'quantity': quantity,
      'redemptionDate': redemptionDate.toIso8601String(),
      'valueDiscount': valueDiscount,
      'name': name,
      'description': description,
      'remainingUses': remainingUses,
    });
      print('Discount DTO added: $discountDTOS');

  }

  void addcourseLocations({
     required int id,
    required DateTime scheduleDate,
    required String area,
  }) {
    // In giá trị area để kiểm tra
    print('Adding Course Location - area: $area, scheduleDate: $scheduleDate');

    // Add to the list
    courseLocations.add({
       'id': id,
      'area': area ?? '',
      'schedule_Date': scheduleDate.toIso8601String(),
        // Sử dụng chuỗi trống nếu area là null
    });
  }


  CourseUpdateRequest buildWorkshop() {
    print('buildWorkshop Data: ');
    List<CourseMediaInfoDTO> courseMediaInfosData = courseMediaInfos.map((map) {
      final mediaInfo = CourseMediaInfoDTO.fromJson(map);
      print('Media Info: $mediaInfo');
      return mediaInfo;
    }).toList();

    List<DiscountDTO> discountDTOSData = discountDTOS.map((map) {
      final discount = DiscountDTO.fromJson(map);
      print('Discount Info: $discount');
      return discount;
    }).toList();

    List<CourseLocationDTO> courseLocationsData = courseLocations.map((map) {
      final location = CourseLocationDTO.fromJson(map);
      print('Location Info: $location');
      return location;
    }).toList();
    return CourseUpdateRequest(
      name: name.value,
      description: description.value,
      price: price.value,
      startDate: startDate.value,
      endDate: endDate.value,
      student_count: studentCount.value,
      type: type.value,
      courseMediaInfos: courseMediaInfosData,
      discountDTOS: discountDTOSData,
      courseLocations: courseLocationsData,
    );
  }

  // Modify addNewWorkshop to use the buildWorkshop method
  Future<void> editWorkshop() async {
    try {
      print('Workshop Data');

      // Construct the workshop object
      final workshop = buildWorkshop();
      print('Workshop Data: ${workshop}');

      // Call the API service to add a new workshop
      await apiService.editWorkshop(
        token: token,
        updatedWorkshop: workshop,
        workshopId: workshopId
      );

      // Check for a specific condition (e.g., successful creation)
      print('Workshop successfully created!');
      // Clear data after successful addition
      clearData();
    } catch (e) {
      // Handle errors appropriately
      print('Error adding new workshop: $e');
    }
  }
}
