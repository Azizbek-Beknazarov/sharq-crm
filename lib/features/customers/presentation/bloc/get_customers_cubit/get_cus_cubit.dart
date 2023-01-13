// void loadCustomer() async {
//   if (state is InitialState) {
//     return;
//   }
//   final currentState = state;
//   var list = <CustomerModel>[];
//   if (currentState is AllCustomersLoaded) {
//     list = currentState.allCustomersLoaded;
//     emit(AllCustomersLoaded(allCustomersLoaded: list));
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';

import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/get_customers_cubit/get_cus_state.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/util/constants.dart';
import '../../../domain/usecase/delete_customer.dart';
import '../../../domain/usecase/get_all_cus_usecase.dart';
import '../../../domain/usecase/update_customer_usecase.dart';

class CustomerCubit extends Cubit<CustomersState> {
  final GetAllCustomersUseCase getAllCus;
  CustomerDeleteUseCase deleteCus;
  UpdateCustomerUseCase updateCus;

  CustomerCubit({
    required this.getAllCus,
    required this.deleteCus,
    required this.updateCus
  }) : super(CustomerEmpty());

  void loadCustomer() async {
    if (state is CustomerLoading) return;

    final failureOr = await getAllCus(NoParams());

    failureOr.fold(
        (error) => emit(CustomerError(message: _mapFailureToMessage(error))),
        (character) {
      emit(CustomersLoaded(customersLoaded: character));
    });
  }

  void deleteCustomer(String id) async {
    if (state is CustomerLoading) return;
    final failOrDel = await deleteCus.call(id);
    failOrDel.fold((l) => CustomerError(message: 'dont delete'),
        (r) => CustomerDelState());
  }

  void updateCustomer(CustomerEntity customerEntity, String customerId) async {
    if (state is CustomerLoading) return;
    final failOr = await updateCus.call(CustomerUpdateParams(customerEntity, customerId));
    failOr.fold((l) => CustomerError(message: 'dont update'),
        (r) => CustomerUpdateState());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
