// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names

import 'package:json_annotation/json_annotation.dart';

part 'workshopResponses.g.dart';

@JsonSerializable()
class CourseResponses {
  late final int id;
  late final String name;
  late final String description;
  late final double price;
  late final DateTime startDate;
  late final DateTime endDate;
  late final int student_count;
  late final String type;
  late final int teacher_id;
  late final String teacher;
  late final String teacher_img;
  late final bool isPublic;
  late final List<StudentEnrollment> studentEnrollments;
  late final List<CourseMediaInfo> courseMediaInfos;
  late final List<CourseLocation> courseLocations;
  late final List<DiscountDTO> discountDTOS;
  late final bool isFree;

  CourseResponses({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.student_count,
    required this.type,
    required this.teacher_id,
    required this.teacher,
    required this.teacher_img,
    required this.isPublic,
    this.isFree = false,
    List<StudentEnrollment>? studentEnrollments,
    List<CourseMediaInfo>? courseMediaInfos,
    List<CourseLocation>? courseLocations,
    List<DiscountDTO>? discountDTOS,
  })  : studentEnrollments = studentEnrollments ?? [],
        courseMediaInfos = courseMediaInfos ?? [],
        courseLocations = courseLocations ?? [],
        discountDTOS = discountDTOS ?? [];

  factory CourseResponses.fromJson(Map<String, dynamic> json) {
    return CourseResponses(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'empty',
      description: json['description'] as String? ?? 'empty',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      startDate: DateTime.parse(json['startDate'] as String? ?? 'empty'),
      endDate: DateTime.parse(json['endDate'] as String? ?? 'empty'),
      student_count: json['student_count'] as int? ?? 0,
      type: json['type'] as String? ?? 'empty',
      teacher_id: json['teacher_id'] as int? ?? 0,
      teacher: json['teacher'] as String? ?? 'empty',
      teacher_img: json['teacher_img'] as String? ?? 'https://thietbiquayphim.com/wp-content/uploads/2022/05/meo-chup-anh-cun-cung.png',

      isPublic: json['public'] as bool? ?? false,
      studentEnrollments: (json['studentEnrollments'] as List<dynamic>?)
              ?.map((e) => StudentEnrollment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      courseMediaInfos: (json['courseMediaInfos'] as List<dynamic>?)
              ?.map((e) => CourseMediaInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      courseLocations: (json['courseLocations'] as List<dynamic>?)
              ?.map((e) => CourseLocation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      discountDTOS: (json['discountDTOS'] as List<dynamic>?)
              ?.map((e) => DiscountDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
  
  Map<String, dynamic> toJson() => _$CourseResponsesToJson(this);
}

@JsonSerializable()
class StudentEnrollment {
  late final int id;
  late final String name;

  StudentEnrollment({
    required this.id,
    required this.name,
  });

  factory StudentEnrollment.fromJson(Map<String, dynamic> json) {
    return StudentEnrollment(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'empty',
    );
  }

  Map<String, dynamic> toJson() => _$StudentEnrollmentToJson(this);
}

@JsonSerializable()
class CourseMediaInfo {
  late final int id;
  late final String urlMedia;
  late final String urlImage;
  late final String thumbnailSrc;
  late final String title;

  CourseMediaInfo({
    required this.id,
    required this.urlMedia,
    required this.urlImage,
    required this.thumbnailSrc,
    required this.title,
  });

  factory CourseMediaInfo.fromJson(Map<String, dynamic> json) {
    return CourseMediaInfo(
      id: json['id'] as int? ?? 0,
      urlMedia: json['urlMedia'] as String? ?? 'empty',
      urlImage: json['urlImage'] as String? ?? 'empty',
      thumbnailSrc: json['thumbnailSrc'] as String? ?? 'empty',
      title: json['title'] as String? ?? 'empty',
    );
  }
  
  Map<String, dynamic> toJson() => _$CourseMediaInfoToJson(this);
}

@JsonSerializable()
class CourseLocation {
  late final int id;
  late final String area;
  late final DateTime schedule_Date;
  late final locationResponse locationDTO;

  CourseLocation({
    required this.id,
    required this.area,
    required this.schedule_Date,
    required this.locationDTO,
  });

  factory CourseLocation.fromJson(Map<String, dynamic> json) {
    return CourseLocation(
      id: json['id'] as int? ?? 0,
      area: json['area'] as String? ?? 'empty',
      schedule_Date: DateTime.parse(json['schedule_Date'] as String),
      locationDTO: locationResponse.fromJson(
        json['locationDTO'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => _$CourseLocationToJson(this);
}

@JsonSerializable()
class locationResponse {
  late final int id;
  late final String name;
  late final String statusAvailable;
  late final String address;
  late final String description;

  locationResponse({
    required this.id,
    required this.name,
    required this.statusAvailable,
    required this.address,
    required this.description,
  });

  factory locationResponse.fromJson(Map<String, dynamic> json) {
    return locationResponse(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'empty',
      statusAvailable: json['statusAvailable'] as String? ?? 'empty',
      address: json['address'] as String? ?? 'empty',
      description: json['description'] as String? ?? 'empty',
    );
  }
  
  Map<String, dynamic> toJson() => _$locationResponseToJson(this);
}

@JsonSerializable()
class DiscountDTO {
  late final int id;
  late final int quantity;
  late final DateTime redemptionDate;
  late final int valueDiscount;
  late final String name;
  late final String description;
  late final int remainingUses;

  DiscountDTO({
    required this.id,
    required this.quantity,
    required this.redemptionDate,
    required this.valueDiscount,
    required this.name,
    required this.description,
    required this.remainingUses,
  });

  factory DiscountDTO.fromJson(Map<String, dynamic> json) {
    return DiscountDTO(
      id: json['id'] as int? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      redemptionDate: DateTime.parse(json['redemptionDate'] as String),
      valueDiscount: json['valueDiscount'] as int? ?? 0,
      name: json['name'] as String? ?? 'empty',
      description: json['description'] as String? ?? 'empty',
      remainingUses: json['remainingUses'] as int? ?? 0,
    );
  }
  
  Map<String, dynamic> toJson() => _$DiscountDTOToJson(this);
}
