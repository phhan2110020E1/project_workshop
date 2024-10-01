// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';
part 'userEditRequest.g.dart';
// ignore_for_file: non_constant_identifier_names
@JsonSerializable()
class UserEditRequest {
  String full_name;
  String user_name;
  String email;
  String phoneNumber;
  double balance;
  String image_url;
  bool isEnable;
  List<UserAddress> userAddresses;
  List<UserBank> userBanks;

  UserEditRequest({
    required this.full_name,
    required this.user_name,
    required this.email,
    required this.phoneNumber,
    required this.balance,
    required this.image_url,
    required this.userAddresses,
    required this.userBanks,
    required this.isEnable,
  });

   factory UserEditRequest.fromJson(Map<String, dynamic> json) => _$UserEditRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserEditRequestToJson(this);
}
@JsonSerializable()
class UserAddress {
  int id;
  String Address;
  String City;
  String State;
  int PostalCode;

  UserAddress({
    required this.id,
    required this.Address,
    required this.City,
    required this.State,
    required this.PostalCode,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) =>
      _$UserAddressFromJson(json);
  Map<String, dynamic> toJson() => _$UserAddressToJson(this);
}
@JsonSerializable()
class UserBank {
  int id;
  String bankName;
  String bankAccount;

  UserBank({
    required this.id,
    required this.bankName,
    required this.bankAccount,
  });

  factory UserBank.fromJson(Map<String, dynamic> json) =>
      _$UserBankFromJson(json);
  Map<String, dynamic> toJson() => _$UserBankToJson(this);

}
