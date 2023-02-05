import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  CustomerModel({
    required String name,
    required String phone,
     required String customerId,
    required int dateOfSignUp,
    required bool managerAdded,
  }) : super(
          name: name,
          phone: phone,
         customerId: customerId,
          dateOfSignUp: dateOfSignUp,
    managerAdded: managerAdded,
        );

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['name'] ?? "",
      phone: json['phone'] ?? "",
      customerId: json['customerId'] ?? "",
      dateOfSignUp: json['dateOfSignUp'] ?? "",
      managerAdded: json['managerAdded']??false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'name': name,
      'phone': phone,
      'dateOfSignUp': dateOfSignUp,
      "managerAdded":managerAdded,
    };
  }
}
