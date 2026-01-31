part of 'money_bloc.dart';

abstract class MoneyEvent extends Equatable {
  const MoneyEvent();

  @override
  List<Object> get props => [];
}

class AddTransactionEvent extends MoneyEvent {
  final ObjMoney transaction;
  const AddTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}
