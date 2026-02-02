part of 'money_bloc.dart';

abstract class MoneyEvent extends Equatable {
  const MoneyEvent();

  @override
  List<Object> get props => [];
}

class AddTransactionEvent extends MoneyEvent {
  final String name;
  final Transaction transactionItem;

  const AddTransactionEvent({
    required this.name,
    required this.transactionItem,
  });

  @override
  List<Object> get props => [name, transactionItem];
}

class RemoveObjEvent extends MoneyEvent {
  final int id;

  const RemoveObjEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class IsEditEvent extends MoneyEvent {
  final bool? isEdit;
  final bool? isEditItem;

  const IsEditEvent({this.isEditItem, this.isEdit});
}

class AddObjMoneyEvent extends MoneyEvent {
  final ObjMoney objMoney;

  const AddObjMoneyEvent({required this.objMoney});
}
