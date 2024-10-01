// ignore_for_file: file_names, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'workshopResquest.g.dart';

@JsonSerializable()
class CourseRequest {
  @JsonKey(required: true)
  late String name;

  @JsonKey(required: true)
  late String description;

  @JsonKey(required: true)
  late double price;

  @JsonKey(required: true)
  late DateTime startDate;

  @JsonKey(required: true)
  late DateTime endDate;

  @JsonKey(required: true)
  late int student_count;

  @JsonKey(required: true)
  late String type;

  @JsonKey(name: 'mediaInfoList')
  late List<CourseMediaInfoDTO> mediaInfoList;

  @JsonKey(name: 'discountDTOS')
  late List<DiscountDTO> discountDTOS;

  @JsonKey(name: 'courseLocation')
  late List<CourseLocationDTO> courseLocation;

  CourseRequest({
    required this.name,
    required this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.student_count,
    required this.type,
    required this.mediaInfoList,
    required this.discountDTOS,
    required this.courseLocation,
  });

  factory CourseRequest.fromJson(Map<String, dynamic> json) =>
      _$CourseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CourseRequestToJson(this);
}

@JsonSerializable()
class CourseMediaInfoDTO {
  late String urlMedia;
  late String urlImage;
  late String thumbnailSrc;
  late String title;

  CourseMediaInfoDTO({
    required this.urlMedia,
    required this.urlImage,
    required this.thumbnailSrc,
    required this.title,
  });


  factory CourseMediaInfoDTO.fromJson(Map<String, dynamic> json) {
    return CourseMediaInfoDTO(
      urlMedia: (json['urlMedia'] as String?) ?? '',
      urlImage: (json['urlImage'] as String?) ?? '',
      thumbnailSrc: (json['thumbnailSrc'] as String?) ?? '',
      title: (json['title'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'urlMedia': urlMedia ?? '', // Use an empty string if 'urlMedia' is null
      'urlImage': urlImage ?? '',
      'thumbnailSrc': thumbnailSrc ?? '',
      'title': title ?? '',
    };
  }

  factory CourseMediaInfoDTO.fromMap(Map<String, dynamic> map) {
    return CourseMediaInfoDTO(
      urlMedia: map['urlMedia'] as String? ??
          '', // Use an empty string if 'urlMedia' is null
      urlImage: map['urlImage'] as String? ?? '',
      thumbnailSrc: map['thumbnailSrc'] as String? ?? '',
      title: map['title'] as String? ?? '',
    );
  }
}

@JsonSerializable()
class DiscountDTO {
  late int quantity;
  late DateTime redemptionDate;
  late int valueDiscount;
  late String name;
  late String description;
  late int remainingUses;

  DiscountDTO({
    required this.quantity,
    required this.redemptionDate,
    required this.valueDiscount,
    required this.name,
    required this.description,
    required this.remainingUses,
  });

  factory DiscountDTO.fromJson(Map<String, dynamic> json) =>
      _$DiscountDTOFromJson(json);

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'redemptionDate': redemptionDate.toIso8601String(),
      'valueDiscount': valueDiscount,
      'name': name,
      'description': description,
      'remainingUses': remainingUses,
    };
  }

  @override
  String toString() {
    return 'DiscountDTO{quantity: $quantity, redemptionDate: $redemptionDate, valueDiscount: $valueDiscount, name: $name, description: $description, remainingUses: $remainingUses}';
  }
}

@JsonSerializable()
class CourseLocationDTO {
  final String area;
  final DateTime schedule_Date;

  CourseLocationDTO({
    required this.area,
    required this.schedule_Date,
  });

  factory CourseLocationDTO.fromJson(Map<String, dynamic> json) {
    return CourseLocationDTO(
      area: json['area'] as String? ??
          '', // Use an empty string if 'Area' is null
      schedule_Date: DateTime.parse(json['schedule_Date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'schedule_Date': schedule_Date.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'CourseLocationDTO{area: $area, schedule_Date: $schedule_Date}';
  }
}
