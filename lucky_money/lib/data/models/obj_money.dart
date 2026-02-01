import 'package:equatable/equatable.dart';
import 'transaction.dart';

class ObjMoney extends Equatable {
  final String name;
  final List<Transaction> transactions;

  ObjMoney({required this.name, required this.transactions});

  @override
  List<Object?> get props => [name, transactions];

  double get totalAmount {
    double total = 0;
    for (var item in transactions) {
      if (item.isGive) {
        total += item.amount;
      } else {
        total -= item.amount;
      }
    }
    return total;
  }

  ObjMoney copyWith({String? name, List<Transaction>? transactions}) {
    return ObjMoney(
      name: name ?? this.name,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'transactions': transactions.map((e) => e.toJson()).toList(),
    };
  }

  factory ObjMoney.fromJson(Map<String, dynamic> json) {
    return ObjMoney(
      name: json['name'] as String? ?? '',
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

