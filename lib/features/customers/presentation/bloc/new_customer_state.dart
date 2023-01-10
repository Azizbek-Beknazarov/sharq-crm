part of 'new_customer_bloc.dart';

abstract class AddNewCustomerState {}

class InitialState extends AddNewCustomerState {}

class CustomerAddingState extends AddNewCustomerState {}

class CustomerAddedState extends AddNewCustomerState {}

class AddNewCustomerFailedState extends AddNewCustomerState {
  final String error;
  AddNewCustomerFailedState(this.error);
}
class CustomerUpdatedState extends AddNewCustomerState{}

