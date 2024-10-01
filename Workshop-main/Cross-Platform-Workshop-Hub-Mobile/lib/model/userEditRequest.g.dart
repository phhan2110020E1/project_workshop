// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userEditRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEditRequest _$UserEditRequestFromJson(Map<String, dynamic> json) =>
    UserEditRequest(
      full_name: json['full_name'] as String,
      user_name: json['user_name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      balance: (json['balance'] as num).toDouble(),
      image_url: json['image_url'] as String,
      userAddresses: (json['userAddresses'] as List<dynamic>)
          .map((e) => UserAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      userBanks: (json['userBanks'] as List<dynamic>)
          .map((e) => UserBank.fromJson(e as Map<String, dynamic>))
          .toList(),
      isEnable: json['isEnable'] as bool,
    );

Map<String, dynamic> _$UserEditRequestToJson(UserEditRequest instance) =>
    <String, dynamic>{
      'full_name': instance.full_name,
      'user_name': instance.user_name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'balance': instance.balance,
      'image_url': instance.image_url,
      'isEnable': instance.isEnable,
      'userAddresses': instance.userAddresses,
      'userBanks': instance.userBanks,
    };

UserAddress _$UserAddressFromJson(Map<String, dynamic> json) => UserAddress(
      id: json['id'] as int,
      Address: json['Address'] as String,
      City: json['City'] as String,
      State: json['State'] as String,
      PostalCode: json['PostalCode'] as int,
    );

Map<String, dynamic> _$UserAddressToJson(UserAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'Address': instance.Address,
      'City': instance.City,
      'State': instance.State,
      'PostalCode': instance.PostalCode,
    };

UserBank _$UserBankFromJson(Map<String, dynamic> json) => UserBank(
      id: json['id'] as int,
      bankName: json['bankName'] as String,
      bankAccount: json['bankAccount'] as String,
    );

Map<String, dynamic> _$UserBankToJson(UserBank instance) => <String, dynamic>{
      'id': instance.id,
      'bankName': instance.bankName,
      'bankAccount': instance.bankAccount,
    };
