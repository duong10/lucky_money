class ItemMoney {
  final double amount;
  final DateTime date;
  final String comment;
  final bool isGive;

  ItemMoney({
    required this.amount,
    required this.date,
    required this.comment,
    required this.isGive,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date': date.toIso8601String(),
      'comment': comment,
      'isGive': isGive,
    };
  }

  factory ItemMoney.fromJson(Map<String, dynamic> json) {
    return ItemMoney(
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      comment: json['comment'] as String? ?? '',
      isGive: json['isGive'] as bool? ?? true,
    );
  }
}
