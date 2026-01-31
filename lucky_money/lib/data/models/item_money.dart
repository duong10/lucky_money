class ItemMoney {
  final String currency;
  final double money;
  final DateTime dateMoney;

  ItemMoney({
    required this.currency,
    required this.money,
    required this.dateMoney,
  });

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'money': money,
      'dateMoney': dateMoney.toIso8601String(),
    };
  }

  factory ItemMoney.fromJson(Map<String, dynamic> json) {
    return ItemMoney(
      currency: json['currency'] as String,
      money: (json['money'] as num).toDouble(),
      dateMoney: DateTime.parse(json['dateMoney'] as String),
    );
  }
}
