// ignore_for_file: non_constant_identifier_names


import 'package:json_annotation/json_annotation.dart';

 part 'request.g.dart';

@JsonSerializable()
class RequestDTO {
  late String type;
  late int  requestId;
  late String status;
  late int  item_register_id;
  late int  locationId;
  late double amount;
  late double discountAmount;
  late String discountCode;
  late String paymentName;
  late String paymentStatus;

  RequestDTO({
    required this.type,
    required this.requestId,
    required this.status,
    required this.item_register_id,
    required this.locationId,
    required this.amount,
    required this.discountAmount,
    required this.discountCode,
    required this.paymentName,
    required this.paymentStatus,
  });

  factory RequestDTO.fromJson(Map<String, dynamic> json) =>
      _$RequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RequestDTOToJson(this);
}
