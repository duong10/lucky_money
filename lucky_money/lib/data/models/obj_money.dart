import 'item_money.dart';

class ObjMoney {
  final String name;
  final List<ItemMoney> itemMoney;

  ObjMoney({
    required this.name,
    required this.itemMoney,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'itemMoney': itemMoney.map((e) => e.toJson()).toList(),
    };
  }

  factory ObjMoney.fromJson(Map<String, dynamic> json) {
    return ObjMoney(
      name: json['name'] as String,
      itemMoney: (json['itemMoney'] as List<dynamic>)
          .map((e) => ItemMoney.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
