import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  CustomerModel(
      {required String name,
      required String phone,
      required String id,
      required int dateOfSignUp,
      String? password})
      : super(
            name: name,
            phone: phone,
            id: id,
            dateOfSignUp: dateOfSignUp,
            password: password);

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
        name: json['name'] ?? "",
        phone: json['phone'] ?? "",
        id: json['id'] ?? "",
        dateOfSignUp: json['dateOfSignUp'] ?? "",
        password: json['password'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'dateOfSignUp': dateOfSignUp,
      'password':password,
    };
  }
}
