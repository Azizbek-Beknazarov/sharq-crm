import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  CustomerModel(
      {required String name,
      required  String phone,
      required  String id,
      required  String dateOfSignUp}):super(name: name,phone: phone,id: id,dateOfSignUp: dateOfSignUp);

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
        name: json['name'] ?? "",
        phone: json['phone'] ?? "",
        id: json['id'] ?? "",
        dateOfSignUp: json['dateOfSignUp']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'dateOfSignUp':dateOfSignUp
    };
  }
}
