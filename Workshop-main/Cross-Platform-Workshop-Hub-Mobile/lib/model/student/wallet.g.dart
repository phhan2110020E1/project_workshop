// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

walletResponses _$walletResponsesFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['current_balance'],
  );
  return walletResponses(
    current_balance: (json['current_balance'] as num?)?.toDouble(),
    transactions: (json['transactions'] as List<dynamic>)
        .map((e) => Transactions.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$walletResponsesToJson(walletResponses instance) =>
    <String, dynamic>{
      'current_balance': instance.current_balance,
      'transactions': instance.transactions,
    };

Transactions _$TransactionsFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['amount', 'status', 'type', 'transaction_date'],
  );
  return Transactions(
    amount: (json['amount'] as num?)?.toDouble(),
    status: json['status'] as String?,
    type: json['type'] as String?,
    transaction_date: DateTime.parse(json['transaction_date'] as String),
  )..id = json['id'] as int;
}

Map<String, dynamic> _$TransactionsToJson(Transactions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'status': instance.status,
      'type': instance.type,
      'transaction_date': instance.transaction_date.toIso8601String(),
    };
