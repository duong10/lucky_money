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

class RemoveTransEvent extends MoneyEvent {
  final int id;
  final int idTrans;

  const RemoveTransEvent(this.id, {required this.idTrans});

  @override
  List<Object> get props => [idTrans, id];
}

class EditTransEvent extends MoneyEvent {
  final int id;
  final String? newName;
  final Transaction transaction;

  const EditTransEvent(this.id, {this.newName, required this.transaction});

  @override
  List<Object> get props => [transaction, id, newName ?? ''];
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
