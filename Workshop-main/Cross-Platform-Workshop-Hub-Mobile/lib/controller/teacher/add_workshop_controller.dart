import 'package:get/get.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/workshopResquest.dart';

class AddWorkshopController extends GetxController {
  final String token;

  AddWorkshopController({required this.token});

  final ApiService apiService = ApiService();

  RxString name = "".obs;
  RxString description = "".obs;
  RxDouble price = 0.0.obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().add(const Duration(days: 7)).obs;
  RxInt studentCount = 0.obs;
  RxString type = "".obs;
  RxList<Map<String, dynamic>> mediaInfoList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> discountDTOs = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> courseLocation = <Map<String, dynamic>>[].obs;

  set workshop(CourseRequest workshop) {}

  void setStepData({
    required RxString name,
    required RxString description,
    required RxDouble price,
    required Rx<DateTime> startDate,
    required Rx<DateTime> endDate,
    required RxInt studentCount,
    required RxString type,
    required RxList<Map<String, dynamic>> mediaInfoList,
    required RxList<Map<String, dynamic>> discountDTOs,
    required RxList<Map<String, dynamic>> courseLocation,
  }) {
    this.name = name;
    this.description = description;
    this.price = price;
    this.startDate = startDate;
    this.endDate = endDate;
    this.studentCount = studentCount;
    this.type = type;
    this.mediaInfoList = mediaInfoList;
    this.discountDTOs = discountDTOs;
    this.courseLocation = courseLocation;
  }

  void clearData() {
    name.value = "";
    description.value = "";
    price.value = 0.0;
    startDate.value = DateTime.now();
    endDate.value = DateTime.now().add(const Duration(days: 7));
    studentCount.value = 0;
    type.value = "";
    mediaInfoList.clear();
    discountDTOs.clear();
    courseLocation.clear();
  }

  bool isStep1Completed() {
    return 
     mediaInfoList.isNotEmpty &&
        mediaInfoList.every((media) =>
            media['urlMedia'] != null && media['urlImage'] != null)&&
        name.isNotEmpty &&
        description.isNotEmpty &&
        price > 0 &&
        startDate.value != null &&
        endDate.value != null;
  }

  bool isStep2Completed() {
    return courseLocation.isNotEmpty &&
        courseLocation.every((location) =>
            location['schedule_Date'] != null && location['area'] != null);
  }


  bool isStep3Completed() {
    return discountDTOs.isNotEmpty &&
        discountDTOs.every((discount) =>
            discount['quantity'] != null &&
            discount['redemptionDate'] != null &&
            discount['valueDiscount'] != null &&
            discount['name'] != null &&
            discount['description'] != null &&
            discount['remainingUses'] != null);
  }

  bool isAllStepsCompleted() {
    return isStep1Completed() && isStep2Completed() && isStep3Completed();
  }

  void showAllData() {
    // print('Step 1 Data:');
    // print('Name: ${name.value}');
    // print('Description: ${description.value}');
    // print('Price: ${price.value}');
    // print('Start Date: ${startDate.value}');
    // print('End Date: ${endDate.value}');
    // print('Student Count: ${studentCount.value}');
    // print('Type: ${type.value}');

    // print('\nStep 2 Data:');
    for (var i = 0; i < mediaInfoList.length; i++) {
      final mediaInfo = CourseMediaInfoDTO.fromJson(mediaInfoList[i]);
      // print('Media Info $i: ${mediaInfo.urlImage}');
    }
    // print('\nStep 2 Data:');
    for (var i = 0; i < courseLocation.length; i++) {
      final location = CourseLocationDTO.fromJson(courseLocation[i]);
      // print(
      //     'Location Info $i: area=${location.area}, schedule_Date=${location.schedule_Date}');
    }

    // print('\nStep 3 Data:');
    // for (var i = 0; i < discountDTOs.length; i++) {
    //   final discount = DiscountDTO.fromJson(discountDTOs[i]);
    //   // print(
    //   //     'Discount Info $i: quantity=${discount.quantity}, redemptionDate=${discount.redemptionDate}, valueDiscount=${discount.valueDiscount}, name=${discount.name}, description=${discount.description}, remainingUses=${discount.remainingUses}');
    // }
  }



  void addMediaInfo({
    required String urlMedia,
    required String urlImage,
    required String thumbnailSrc,
    required String title,
  }) {
    mediaInfoList.add({
      'urlMedia': urlMedia ?? '',
      'urlImage': urlImage ?? '',
      'thumbnailSrc': thumbnailSrc,
      'title': title,
    });
  }

  void addDiscountDTO({
    required int quantity,
    required DateTime redemptionDate,
    required int valueDiscount,
    required String name,
    required String description,
    required int remainingUses,
  }) {
    discountDTOs.add({
      'quantity': quantity,
      'redemptionDate': redemptionDate.toIso8601String(),
      'valueDiscount': valueDiscount,
      'name': name,
      'description': description,
      'remainingUses': remainingUses,
    });
  }

  void addCourseLocation({
    required DateTime scheduleDate,
    required String area,
  }) {
    // In giá trị area để kiểm tra

    // Add to the list
    courseLocation.add({
      'schedule_Date': scheduleDate.toIso8601String(),
      'area': area ?? '', // Sử dụng chuỗi trống nếu area là null
    });
  }


  CourseRequest buildWorkshop() {
    

    // print('buildWorkshop Data: ');
    List<CourseMediaInfoDTO> mediaInfoListData = mediaInfoList.map((map) {
      final mediaInfo = CourseMediaInfoDTO.fromJson(map);
      // print('Media Info: $mediaInfo');
      return mediaInfo;
    }).toList();

    List<DiscountDTO> discountDTOsData = discountDTOs.map((map) {
      final discount = DiscountDTO.fromJson(map);
      // print('Discount Info: $discount');
      return discount;
    }).toList();

    List<CourseLocationDTO> courseLocationData = courseLocation.map((map) {
      final location = CourseLocationDTO.fromJson(map);
      // print('Location Info: $location');
      return location;
    }).toList();
    return CourseRequest(
      name: name.value,
      description: description.value,
      price: price.value,
      startDate: startDate.value,
      endDate: endDate.value,
      student_count: studentCount.value,
      type: type.value,
      mediaInfoList: mediaInfoListData,
      discountDTOS: discountDTOsData,
      courseLocation: courseLocationData,
    );
  }

  // Modify addNewWorkshop to use the buildWorkshop method
  Future<void> addNewWorkshop() async {
    try {
      // print('Workshop Data');

      // Construct the workshop object
      final workshop = buildWorkshop();
      // print('Workshop Data: ${workshop}');

      // Call the API service to add a new workshop
      await apiService.addNewWorkshop(
        token: token,
        workshop: workshop,
      );

      // Check for a specific condition (e.g., successful creation)
      // print('Workshop successfully created!');
      // Clear data after successful addition
      clearData();
    } catch (e) {
      // Handle errors appropriately
      print('Error adding new workshop: $e');
    }
  }
}
