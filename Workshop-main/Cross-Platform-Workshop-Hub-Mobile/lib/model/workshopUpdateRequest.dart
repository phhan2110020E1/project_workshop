// ignore_for_file: file_names, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'workshopUpdateRequest.g.dart';
@JsonSerializable()
class CourseUpdateRequest {
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

  @JsonKey(name: 'courseMediaInfos')
  late List<CourseMediaInfoDTO> courseMediaInfos;

  @JsonKey(name: 'discountDTOS')
  late List<DiscountDTO> discountDTOS;

  @JsonKey(name: 'courseLocations')
  late List<CourseLocationDTO> courseLocations;

  CourseUpdateRequest({
    required this.name,
    required this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.student_count,
    required this.type,
    required this.courseMediaInfos,
    required this.discountDTOS,
    required this.courseLocations
  });

  factory CourseUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$CourseUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CourseUpdateRequestToJson(this);
}

@JsonSerializable()
class CourseMediaInfoDTO {
  late int id;
  late String urlMedia;
  late String urlImage;
  late String thumbnailSrc;
  late String title;

  CourseMediaInfoDTO({
    required this.id,
    required this.urlMedia,
    required this.urlImage,
    required this.thumbnailSrc,
    required this.title,
  });

  factory CourseMediaInfoDTO.fromJson(Map<String, dynamic> json) {
    return CourseMediaInfoDTO(
      id: json['id'] as int? ?? 0,
      urlMedia: (json['urlMedia'] as String?) ?? '',
      urlImage: (json['urlImage'] as String?) ?? '',
      thumbnailSrc: (json['thumbnailSrc'] as String?) ?? '',
      title: (json['title'] as String?) ?? '', 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'urlMedia': urlMedia ?? '', // Use an empty string if 'urlMedia' is null
      'urlImage': urlImage ?? '',
      'thumbnailSrc': thumbnailSrc ?? '',
      'title': title ?? '',
    };
  }
 @override
  String toString() {
    return 'CourseMediaInfoDTO{id: $id, urlMedia: $urlMedia,urlImage: $urlImage,thumbnailSrc: $thumbnailSrc,title: $title}'; // Include other relevant properties
  }
}

@JsonSerializable()
class DiscountDTO {
  late int id;
  late int quantity;
  late DateTime redemptionDate;
  late int valueDiscount;
  late String name;
  late String description;
  late int remainingUses;

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
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      remainingUses: json['remainingUses'] as int? ?? 0,
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
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
  late int id;
  late String area;
  late DateTime schedule_Date;

  CourseLocationDTO({
    required this.id,
    required this.area,
    required this.schedule_Date,
  });

  factory CourseLocationDTO.fromJson(Map<String, dynamic> json) {
    return CourseLocationDTO(
      id: json['id'] as int? ?? 0,
      area: json['area'] as String? ??
          '', 
      schedule_Date: DateTime.parse(json['schedule_Date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area': area,
      'schedule_Date': schedule_Date.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'CourseLocationDTO{area: $area, schedule_Date: $schedule_Date}';
  }
}
