import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  CustomerModel({required super.name, required super.phone, required super.id});

  static CustomerModel fromJson(Map<String, dynamic> json) {
    return CustomerModel(
        name: json['name'] ?? "",
        phone: json['phone'] ?? "",
        id: json['id'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
}
