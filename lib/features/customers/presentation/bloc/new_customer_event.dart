part of 'new_customer_bloc.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [props];
}

class AddCustomerEvent extends CustomerEvent {
  final CustomerModel customerModel;

  AddCustomerEvent(this.customerModel) : super([customerModel]);
}
 // class CustomerUpdateEvent extends CustomerEvent{
 //   final CustomerModel customerModel;
 //
 //  CustomerUpdateEvent(this.customerModel):super([customerModel]);
 // }
