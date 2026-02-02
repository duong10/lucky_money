part of 'money_bloc.dart';

class MoneyState extends Equatable {
  final List<ObjMoney> listObjMoney;
  final ObjMoney? objMoney;
  final bool? isEdit;
  final bool? isEditItem;

  const MoneyState({
    this.listObjMoney = const [],
    this.objMoney,
    this.isEdit = false,
    this.isEditItem = false,
  });

  MoneyState copyWith({
    List<ObjMoney>? listObjMoney,
    ObjMoney? objMoney,
    bool? isEdit,
    bool? isEditItem,
  }) {
    return MoneyState(
      listObjMoney: listObjMoney ?? this.listObjMoney,
      objMoney: objMoney ?? this.objMoney,
      isEdit: isEdit ?? this.isEdit,
      isEditItem: isEditItem ?? this.isEditItem,
    );
  }

  @override
  List<Object?> get props => [listObjMoney, objMoney, isEdit, isEditItem];

  Map<String, dynamic> toJson() {
    return {
      'listObjMoney': listObjMoney.map((e) => e.toJson()).toList(),
      'objMoney': objMoney?.toJson(),
    };
  }

  factory MoneyState.fromJson(Map<String, dynamic> json) {
    return MoneyState(
      listObjMoney:
          (json['listObjMoney'] as List<dynamic>?)
              ?.map((e) => ObjMoney.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      objMoney:
          json['objMoney'] != null
              ? ObjMoney.fromJson(json['objMoney'] as Map<String, dynamic>)
              : null,
    );
  }
}
