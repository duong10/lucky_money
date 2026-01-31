import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/obj_money.dart';

part 'money_event.dart';
part 'money_state.dart';

class MoneyBloc extends HydratedBloc<MoneyEvent, MoneyState> {
  MoneyBloc() : super(const MoneyState()) {
    on<AddTransactionEvent>(_onAddTransaction);
  }

  void _onAddTransaction(AddTransactionEvent event, Emitter<MoneyState> emit) {
    final updatedList = List<ObjMoney>.from(state.listObjMoney)..add(event.transaction);
    emit(MoneyState(listObjMoney: updatedList));
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
