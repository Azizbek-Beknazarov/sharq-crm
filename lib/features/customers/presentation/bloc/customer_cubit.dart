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
import 'package:sharq_crm/features/customers/presentation/bloc/customer_state.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/util/constants.dart';
import '../../domain/usecase/delete_customer.dart';
import '../../domain/usecase/get_all_cus_usecase.dart';
import '../../domain/usecase/get_current_customer.dart';
import '../../domain/usecase/new_customer_add_usecase.dart';
import '../../domain/usecase/update_customer_usecase.dart';

class CustomerCubit extends Cubit<CustomersState> {
  final GetAllCustomersUseCase getAllCus;
  final CustomerDeleteUseCase deleteCus;
  final UpdateCustomerUseCase updateCus;
  final AddNewCustomerUseCase addNewCus;
  final GetCurrentCustomerUsecase getCurrentCustomer;

  CustomerCubit(
      {required this.getAllCus,
      required this.deleteCus,
      required this.updateCus,
      required this.addNewCus,required this.getCurrentCustomer})
      : super(CustomerEmpty());


  //1
  void loadCustomer() async {
    if (state is CustomerLoading) return;

    final failureOr = await getAllCus(NoParams());

    failureOr.fold(
        (error) => emit(CustomerError(message: _mapFailureToMessage(error))),
        (customer) {
      emit(CustomersLoaded(customersLoaded: customer));
    });
  }


  //2
  void deleteCustomer(String id) async {
    if (state is CustomerLoading) return;
    final failOrDel = await deleteCus.call(id);
    failOrDel.fold((l) => CustomerError(message: 'dont delete'),
        (r) => CustomerDelState());
  }

  //3
  void updateCustomer(CustomerEntity customerEntity, String customerId) async {
    if (state is CustomerLoading) return;
    final failOr =
        await updateCus.call(CustomerUpdateParams(customerEntity, customerId));
    failOr.fold((l) => CustomerError(message: 'dont update'),
        (r) => CustomerUpdateState());
  }

  //4
  void addNewCustomer(CustomerEntity customerEntity)async{
    if (state is CustomerLoading) return;
    final failOr =await addNewCus.call(params: customerEntity);
    failOr.fold(
            (error) => CustomerError(message: 'dont added'),
            (customer) => CustomerAddedState());
  }

  //5
  void getCurrentCustomerEvent()async{
    if (state is CustomerLoading) return;
    final failureOr = await getCurrentCustomer.call(NoParams());
    emit(failureOr.fold(
          (_) => CustomerEmpty(),
          (customer) => CustomerGetLoadedState(getLoadedCustomer: customer),
    ));



  }



  //
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
