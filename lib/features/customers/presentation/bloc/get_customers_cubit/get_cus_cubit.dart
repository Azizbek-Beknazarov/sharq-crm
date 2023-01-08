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
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/get_customers_cubit/get_cus_state.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/util/constants.dart';
import '../../../domain/usecase/get_all_cus_usecase.dart';

class CustomerCubit extends Cubit<CustomersState>{
 final GetAllCustomersUseCase getAllCus;

  CustomerCubit({required this.getAllCus}):super (CustomerEmpty());

 void loadCustomer() async {
   if (state is CustomerLoading) return;

   final failureOr = await getAllCus(NoParams( ));

   failureOr.fold(
           (error) => emit(CustomerError(message: _mapFailureToMessage(error))),
           (character) {
         emit(CustomersLoaded(customersLoaded: character));
       });
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