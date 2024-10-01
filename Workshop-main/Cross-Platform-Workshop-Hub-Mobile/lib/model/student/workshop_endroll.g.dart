// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshop_endroll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

workshopEndrollResponses _$workshopEndrollResponsesFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'name',
      'description',
      'price',
      'startDate',
      'endDate',
      'student_count',
      'student_endroll',
      'teacher',
      'public',
      'urlQrCode'
    ],
  );
  return workshopEndrollResponses(
    id: json['id'] as int,
    name: json['name'] as String?,
    description: json['description'] as String?,
    price: (json['price'] as num).toDouble(),
    startDate: DateTime.parse(json['startDate'] as String),
    endDate: DateTime.parse(json['endDate'] as String),
    student_count: json['student_count'] as int,
    student_endroll: json['student_endroll'] as int,
    teacher: json['teacher'] as String?,
    public: json['public'] as bool,
    urlQrCode: json['urlQrCode'] as String?,
    courseLocations: (json['courseLocations'] as List<dynamic>?)
            ?.map((e) => CourseLocationMobi.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$workshopEndrollResponsesToJson(
        workshopEndrollResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'student_count': instance.student_count,
      'student_endroll': instance.student_endroll,
      'teacher': instance.teacher,
      'public': instance.public,
      'urlQrCode': instance.urlQrCode,
      'courseLocations': instance.courseLocations,
    };

CourseLocationMobi _$CourseLocationMobiFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'schedule_Date',
      'statusAvailable',
      'name',
      'address',
      'description',
      'area'
    ],
  );
  return CourseLocationMobi(
    id: json['id'] as int,
    schedule_Date: DateTime.parse(json['schedule_Date'] as String),
    statusAvailable: json['statusAvailable'] as String?,
    name: json['name'] as String?,
    address: json['address'] as String?,
    description: json['description'] as String?,
    area: json['area'] as String?,
  );
}

Map<String, dynamic> _$CourseLocationMobiToJson(CourseLocationMobi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'schedule_Date': instance.schedule_Date.toIso8601String(),
      'statusAvailable': instance.statusAvailable,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'area': instance.area,
    };
