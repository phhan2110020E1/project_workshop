// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestDTO _$RequestDTOFromJson(Map<String, dynamic> json) => RequestDTO(
      type: json['type'] as String,
      requestId: json['requestId'] as int,
      status: json['status'] as String,
      item_register_id: json['item_register_id'] as int,
      locationId: json['locationId'] as int,
      amount: (json['amount'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      discountCode: json['discountCode'] as String,
      paymentName: json['paymentName'] as String,
      paymentStatus: json['paymentStatus'] as String,
    );

Map<String, dynamic> _$RequestDTOToJson(RequestDTO instance) =>
    <String, dynamic>{
      'type': instance.type,
      'requestId': instance.requestId,
      'status': instance.status,
      'item_register_id': instance.item_register_id,
      'locationId': instance.locationId,
      'amount': instance.amount,
      'discountAmount': instance.discountAmount,
      'discountCode': instance.discountCode,
      'paymentName': instance.paymentName,
      'paymentStatus': instance.paymentStatus,
    };
