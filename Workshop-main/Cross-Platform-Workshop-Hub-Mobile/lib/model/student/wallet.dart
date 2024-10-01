// your_file_name.dart



// ignore_for_file: non_constant_identifier_names, unnecessary_nullable_for_final_variable_declarations, camel_case_types

import 'package:json_annotation/json_annotation.dart';

part 'wallet.g.dart';

@JsonSerializable()
class walletResponses {

  @JsonKey(required: true)
  late final double? current_balance;
  late final List<Transactions> transactions;
  walletResponses({
    required this.current_balance,
    required this.transactions,
  }) {
    _initialize();
  }

  void _initialize() {
    current_balance ??= 0;
    transactions ??= [];
  }

  factory walletResponses.fromJson(Map<String, dynamic> json) {
  final List<Transactions>? transactionsList = json['transactions'] != null
      ? (json['transactions'] as List)
          .map((item) => Transactions.fromJson(item))
          .toList()
      : [];

  return walletResponses(
    current_balance: (json['current_balance'] as num?)?.toDouble(),
    transactions: transactionsList ?? [],
  ).._initialize();
}

  Map<String, dynamic> toJson() => _$walletResponsesToJson(this);
}

@JsonSerializable()
class Transactions {
  late final int id;
  @JsonKey(required: true)
  late final double? amount;
  @JsonKey(required: true)
  late final String? status;
  @JsonKey(required: true)
  late final String? type;
  @JsonKey(required: true)
  late final DateTime transaction_date;

  Transactions({
    required this.amount,
    required this.status,
    required this.type,
    required this.transaction_date,
  }) {
    _initialize();
  }

  void _initialize() {
    transaction_date ??= DateTime.now();
    type ??= '';
    status ??= '';
    amount ??= 0;
  }

  factory Transactions.fromJson(Map<String, dynamic> json) =>
      _$TransactionsFromJson(json).._initialize();

  Map<String, dynamic> toJson() => _$TransactionsToJson(this);
}
