// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'workshopResponses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseResponses _$CourseResponsesFromJson(Map<String, dynamic> json) =>
    CourseResponses(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      student_count: json['student_count'] as int,
      type: json['type'] as String,
      teacher_id: json['teacher_id'] as int,
      teacher: json['teacher'] as String,
      teacher_img: json['teacher_img'] as String,
      isPublic: json['isPublic'] as bool,
      isFree: json['isFree'] as bool? ?? false,
      studentEnrollments: (json['studentEnrollments'] as List<dynamic>?)
          ?.map((e) => StudentEnrollment.fromJson(e as Map<String, dynamic>))
          .toList(),
      courseMediaInfos: (json['courseMediaInfos'] as List<dynamic>?)
          ?.map((e) => CourseMediaInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      courseLocations: (json['courseLocations'] as List<dynamic>?)
          ?.map((e) => CourseLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      discountDTOS: (json['discountDTOS'] as List<dynamic>?)
          ?.map((e) => DiscountDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseResponsesToJson(CourseResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'student_count': instance.student_count,
      'type': instance.type,
      'teacher_id': instance.teacher_id,
      'teacher': instance.teacher,
      'teacher_img': instance.teacher_img,
      'isPublic': instance.isPublic,
      'studentEnrollments': instance.studentEnrollments,
      'courseMediaInfos': instance.courseMediaInfos,
      'courseLocations': instance.courseLocations,
      'discountDTOS': instance.discountDTOS,
      'isFree': instance.isFree,
    };

StudentEnrollment _$StudentEnrollmentFromJson(Map<String, dynamic> json) =>
    StudentEnrollment(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$StudentEnrollmentToJson(StudentEnrollment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CourseMediaInfo _$CourseMediaInfoFromJson(Map<String, dynamic> json) =>
    CourseMediaInfo(
      id: json['id'] as int,
      urlMedia: json['urlMedia'] as String,
      urlImage: json['urlImage'] as String,
      thumbnailSrc: json['thumbnailSrc'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$CourseMediaInfoToJson(CourseMediaInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'urlMedia': instance.urlMedia,
      'urlImage': instance.urlImage,
      'thumbnailSrc': instance.thumbnailSrc,
      'title': instance.title,
    };

CourseLocation _$CourseLocationFromJson(Map<String, dynamic> json) =>
    CourseLocation(
      id: json['id'] as int,
      area: json['area'] as String,
      schedule_Date: DateTime.parse(json['schedule_Date'] as String),
      locationDTO: locationResponse
          .fromJson(json['locationDTO'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseLocationToJson(CourseLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'area': instance.area,
      'schedule_Date': instance.schedule_Date.toIso8601String(),
      'locationDTO': instance.locationDTO,
    };

locationResponse _$locationResponseFromJson(Map<String, dynamic> json) =>
    locationResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      statusAvailable: json['statusAvailable'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$locationResponseToJson(locationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'statusAvailable': instance.statusAvailable,
      'address': instance.address,
      'description': instance.description,
    };

DiscountDTO _$DiscountDTOFromJson(Map<String, dynamic> json) => DiscountDTO(
      id: json['id'] as int,
      quantity: json['quantity'] as int,
      redemptionDate: DateTime.parse(json['redemptionDate'] as String),
      valueDiscount: json['valueDiscount'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      remainingUses: json['remainingUses'] as int,
    );

Map<String, dynamic> _$DiscountDTOToJson(DiscountDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'redemptionDate': instance.redemptionDate.toIso8601String(),
      'valueDiscount': instance.valueDiscount,
      'name': instance.name,
      'description': instance.description,
      'remainingUses': instance.remainingUses,
    };
