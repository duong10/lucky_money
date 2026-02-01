import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final double amount;
  final DateTime date;
  final String comment;
  final bool isGive;

  Transaction({
    required this.amount,
    required this.date,
    required this.comment,
    required this.isGive,
  });

  @override
  List<Object?> get props => [amount, date, comment, isGive];

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date': date.toIso8601String(),
      'comment': comment,
      'isGive': isGive,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      comment: json['comment'] as String? ?? '',
      isGive: json['isGive'] as bool? ?? true,
    );
  }
}

