import 'package:equatable/equatable.dart';

import '../../../data/model/customer_model.dart';

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
  final List<CustomerModel> customersLoaded;

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