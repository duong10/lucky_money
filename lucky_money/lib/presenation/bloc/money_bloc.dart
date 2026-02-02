import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../data/models/obj_money.dart';
import '../../data/models/transaction.dart';

part 'money_event.dart';
part 'money_state.dart';

class MoneyBloc extends HydratedBloc<MoneyEvent, MoneyState> {
  MoneyBloc() : super(const MoneyState()) {
    on<AddTransactionEvent>(_onAddTransaction);
    on<RemoveObjEvent>(_onRemoveObjEvent);
    on<AddObjMoneyEvent>(_onAddObjMoneyEvent);
    on<IsEditEvent>(_onIsEditEvent);
  }

  void _onAddTransaction(AddTransactionEvent event, Emitter<MoneyState> emit) {
    final existingIndex = state.listObjMoney.indexWhere(
      (e) => e.name.toLowerCase() == event.name.toLowerCase(),
    );

    if (existingIndex != -1) {
      final existingObj = state.listObjMoney[existingIndex];
      final newTransactions = List<Transaction>.from(existingObj.transactions)
        ..add(event.transactionItem);
      final newObj = existingObj.copyWith(transactions: newTransactions);

      final newList = List<ObjMoney>.from(state.listObjMoney);
      newList[existingIndex] = newObj;
      emit(state.copyWith(listObjMoney: newList));
    } else {
      final newObj = ObjMoney(
        name: event.name,
        transactions: [event.transactionItem],
      );
      final newList = List<ObjMoney>.from(state.listObjMoney)..add(newObj);
      emit(state.copyWith(listObjMoney: newList));
    }
  }

  void _onRemoveObjEvent(RemoveObjEvent event, Emitter<MoneyState> emit) {
    final existingIndex = state.listObjMoney.indexWhere(
      (e) => e.id == event.id,
    );

    final removeObj = state.listObjMoney[existingIndex];
    final newList = List<ObjMoney>.from(state.listObjMoney)..remove(removeObj);

    emit(state.copyWith(listObjMoney: newList));
  }

  void _onAddObjMoneyEvent(AddObjMoneyEvent event, Emitter<MoneyState> emit) {
    emit(state.copyWith(objMoney: event.objMoney));
  }

  void _onIsEditEvent(IsEditEvent event, Emitter<MoneyState> emit) {
    emit(state.copyWith(isEdit: event.isEdit, isEditItem: event.isEditItem));
  }

  @override
  MoneyState? fromJson(Map<String, dynamic> json) {
    return MoneyState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(MoneyState state) {
    return state.toJson();
  }
}
