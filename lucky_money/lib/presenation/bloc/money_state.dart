part of 'money_bloc.dart';

class MoneyState extends Equatable {
  final List<ObjMoney> listObjMoney;

  const MoneyState({this.listObjMoney = const []});

  @override
  List<Object> get props => [listObjMoney];

  Map<String, dynamic> toJson() {
    return {
      'listObjMoney': listObjMoney.map((e) => e.toJson()).toList(),
    };
  }

  factory MoneyState.fromJson(Map<String, dynamic> json) {
    return MoneyState(
      listObjMoney: (json['listObjMoney'] as List<dynamic>?)
              ?.map((e) => ObjMoney.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
