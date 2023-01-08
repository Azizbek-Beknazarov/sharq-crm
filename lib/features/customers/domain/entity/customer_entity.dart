import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
   String id;
  String name;
  String phone;

  CustomerEntity({required this.name , required this.phone,required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,phone];
}
