import 'package:equatable/equatable.dart';

import 'transaction.dart';

class ObjMoney extends Equatable {
  final int? id;
  final String name;
  final List<Transaction> transactions;

  ObjMoney({int? id, required this.name, required this.transactions})
    : id = id ?? _generateId();

  // Hàm sinh id unique (kết hợp thời gian + random)
  static int _generateId() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final random =
        DateTime.now().microsecond * 1000 + DateTime.now().millisecond;
    return now + random;
  }

  @override
  List<Object?> get props => [id, name, transactions];

  double get totalVND {
    double total = 0;
    for (var item in transactions) {
      if (item.currency == 'VND') {
        if (item.isGive) {
          total += item.amount;
        } else {
          total -= item.amount;
        }
      }
    }
    return total;
  }

  double get totalUSD {
    double total = 0;
    for (var item in transactions) {
      if (item.currency == 'USD') {
        if (item.isGive) {
          total += item.amount;
        } else {
          total -= item.amount;
        }
      }
    }
    return total;
  }

  ObjMoney copyWith({
    int? id,
    String? name,
    List<Transaction>? transactions,
  }) {
    return ObjMoney(
      id: id ?? this.id,
      name: name ?? this.name,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'transactions': transactions.map((e) => e.toJson()).toList(),
    };
  }

  factory ObjMoney.fromJson(Map<String, dynamic> json) {
    return ObjMoney(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
