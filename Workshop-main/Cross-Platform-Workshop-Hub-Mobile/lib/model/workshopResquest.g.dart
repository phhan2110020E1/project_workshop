// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'workshopResquest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseRequest _$CourseRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'name',
      'description',
      'price',
      'startDate',
      'endDate',
      'student_count',
      'type'
    ],
  );
  return CourseRequest(
    name: json['name'] as String,
    description: json['description'] as String,
    price: (json['price'] as num).toDouble(),
    startDate: DateTime.parse(json['startDate'] as String),
    endDate: DateTime.parse(json['endDate'] as String),
    student_count: json['student_count'] as int,
    type: json['type'] as String,
    mediaInfoList: (json['mediaInfoList'] as List<dynamic>)
        .map((e) => CourseMediaInfoDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
    discountDTOS: (json['discountDTOS'] as List<dynamic>)
        .map((e) => DiscountDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
    courseLocation: (json['courseLocation'] as List<dynamic>)
        .map((e) => CourseLocationDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CourseRequestToJson(CourseRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'student_count': instance.student_count,
      'type': instance.type,
      'mediaInfoList': instance.mediaInfoList,
      'discountDTOS': instance.discountDTOS,
      'courseLocation': instance.courseLocation,
    };

CourseMediaInfoDTO _$CourseMediaInfoDTOFromJson(Map<String, dynamic> json) =>
    CourseMediaInfoDTO(
      urlMedia: json['urlMedia'] as String,
      urlImage: json['urlImage'] as String,
      thumbnailSrc: json['thumbnailSrc'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$CourseMediaInfoDTOToJson(CourseMediaInfoDTO instance) =>
    <String, dynamic>{
      'urlMedia': instance.urlMedia,
      'urlImage': instance.urlImage,
      'thumbnailSrc': instance.thumbnailSrc,
      'title': instance.title,
    };

DiscountDTO _$DiscountDTOFromJson(Map<String, dynamic> json) => DiscountDTO(
      quantity: json['quantity'] as int,
      redemptionDate: DateTime.parse(json['redemptionDate'] as String),
      valueDiscount: json['valueDiscount'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      remainingUses: json['remainingUses'] as int,
    );

Map<String, dynamic> _$DiscountDTOToJson(DiscountDTO instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'redemptionDate': instance.redemptionDate.toIso8601String(),
      'valueDiscount': instance.valueDiscount,
      'name': instance.name,
      'description': instance.description,
      'remainingUses': instance.remainingUses,
    };

CourseLocationDTO _$CourseLocationDTOFromJson(Map<String, dynamic> json) =>
    CourseLocationDTO(
      area: json['area'] as String,
      schedule_Date: DateTime.parse(json['schedule_Date'] as String),
    );

Map<String, dynamic> _$CourseLocationDTOToJson(CourseLocationDTO instance) =>
    <String, dynamic>{
      'area': instance.area,
      'schedule_Date': instance.schedule_Date.toIso8601String(),
    };
