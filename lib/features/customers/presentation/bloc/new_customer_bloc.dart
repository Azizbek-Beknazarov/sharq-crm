import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/customer_model.dart';

import '../../domain/usecase/new_customer_add_usecase.dart';

part 'new_customer_state.dart';

part 'new_customer_event.dart';

class CustomerBloc extends Bloc<CustomerEvent, AddNewCustomerState> {
  final AddNewCustomerUseCase _addNewCustomerUseCase;

  CustomerBloc(
    this._addNewCustomerUseCase,
  ) : super(InitialState()) {
    on<AddCustomerEvent>((event, emit) async {
      if (event is AddCustomerEvent) {
        emit(CustomerAddingState());
        await _addNewCustomerUseCase
            .call(params: event.customerModel)
            .then((value) => emit(CustomerAddedState()))
            .catchError((e) => AddNewCustomerFailedState(e));
      }
    });
  }
}
