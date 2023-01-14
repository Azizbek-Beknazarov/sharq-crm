import 'package:equatable/equatable.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';



abstract class CustomersState extends Equatable {
  const CustomersState();

  @override
  List<Object> get props => [];
}

class CustomerEmpty extends CustomersState {
  @override
  List<Object> get props => [];
}

class CustomerLoading extends CustomersState {


  @override
  List<Object> get props => [];
}

class CustomersLoaded extends CustomersState {
  final List<CustomerEntity> customersLoaded;

  CustomersLoaded({required this.customersLoaded});
  @override
  List<Object> get props => [customersLoaded];
}

class CustomerError extends CustomersState {
  final String message;

  const CustomerError({required this.message});

  @override
  List<Object> get props => [message];
}

class CustomerDelState extends CustomersState{

  CustomerDelState();
  @override
  List<Object> get props => [];
}
class CustomerUpdateState extends CustomersState{

}
class CustomerAddedState extends CustomersState{

}