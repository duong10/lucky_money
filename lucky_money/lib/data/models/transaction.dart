import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final int? idTransaction;
  final double amount;
  final String currency;
  final DateTime date;
  final String comment;
  final bool isGive;

  Transaction({
    int? idTransaction,
    required this.amount,
    this.currency = 'VND',
    required this.date,
    required this.comment,
    required this.isGive,
  }) : idTransaction = idTransaction ?? _generateIdTransaction();

  static int _generateIdTransaction() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final random =
        DateTime.now().microsecond * 1000 + DateTime.now().millisecond + 18;
    return now + random;
  }

  @override
  List<Object?> get props =>
      [idTransaction, amount, currency, date, comment, isGive];

  Transaction copyWith({
    int? idTransaction,
    double? amount,
    String? currency,
    DateTime? date,
    String? comment,
    bool? isGive,
  }) {
    return Transaction(
      idTransaction: idTransaction ?? this.idTransaction,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      date: date ?? this.date,
      comment: comment ?? this.comment,
      isGive: isGive ?? this.isGive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idTransaction': idTransaction,
      'amount': amount,
      'currency': currency,
      'date': date.toIso8601String(),
      'comment': comment,
      'isGive': isGive,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      idTransaction: json['idTransaction'] as int?,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'VND',
      date: DateTime.parse(json['date'] as String),
      comment: json['comment'] as String? ?? '',
      isGive: json['isGive'] as bool? ?? true,
    );
  }
}
