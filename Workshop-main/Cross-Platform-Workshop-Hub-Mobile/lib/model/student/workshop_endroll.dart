// your_file_name.dart

// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:json_annotation/json_annotation.dart';

part 'workshop_endroll.g.dart';
@JsonSerializable()
class workshopEndrollResponses {
  late final int id;
  @JsonKey(required: true)
  late final String? name;
  @JsonKey(required: true)
  late final String? description;
  @JsonKey(required: true)
  late final double price;
  @JsonKey(required: true)
  late final DateTime startDate;
  @JsonKey(required: true)
  late final DateTime endDate;
  @JsonKey(required: true)
  late final int student_count;
  @JsonKey(required: true)
  late final int student_endroll;
  @JsonKey(required: true)
  late final String? teacher;
  @JsonKey(required: true)
  late final bool public;
  @JsonKey(required: true)
  late final String? urlQrCode;
  @JsonKey(defaultValue: [])
  late final List<CourseLocationMobi> courseLocations;

  workshopEndrollResponses({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.student_count,
    required this.student_endroll,

    required this.teacher,
    required this.public,
    required this.urlQrCode,
    required this.courseLocations,
  }) {
    _initialize();
  }

  void _initialize() {
    name ??= '';
    description ??= '';
    price ??= 0;
    startDate ??= DateTime.now();
    endDate ??= DateTime.now();
    student_count ??= 0;
    student_endroll ??= 0;
    teacher ??= '';
    public ??= false;
    urlQrCode ??= '';
    courseLocations ??= [];
  }

  factory workshopEndrollResponses.fromJson(Map<String, dynamic> json) =>
      _$workshopEndrollResponsesFromJson(json)
        .._initialize();

  Map<String, dynamic> toJson() => _$workshopEndrollResponsesToJson(this);
}

@JsonSerializable()
class CourseLocationMobi {
  late final int id;
  @JsonKey(required: true)
  late final DateTime schedule_Date;
  @JsonKey(required: true)
  late final String? statusAvailable;
  @JsonKey(required: true)
  late final String? name;
  @JsonKey(required: true)
  late final String? address;
  @JsonKey(required: true)
  late final String? description;
  @JsonKey(required: true)
  late final String? area;

  CourseLocationMobi({
    required this.id,
    required this.schedule_Date,
    required this.statusAvailable,
    required this.name,
    required this.address,
    required this.description,
    required this.area,
  }) {
    _initialize();
  }

  void _initialize() {
    schedule_Date ??= DateTime.now();
    address ??= '';
    description ??= '';
    area ??= '';
    name ??= '';
    statusAvailable ??= '';
  }

  factory CourseLocationMobi.fromJson(Map<String, dynamic> json) =>
      _$CourseLocationMobiFromJson(json)
        .._initialize();

  Map<String, dynamic> toJson() => _$CourseLocationMobiToJson(this);
}

