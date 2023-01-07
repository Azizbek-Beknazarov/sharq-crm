import 'package:sharq_crm/features/auth/domain/entity/manager_entity.dart';

class ManagerModel extends ManagerEntity {
  ManagerModel({
    required String id,
    required String name,
    required String email,

  }) : super(
    id: id,
    name: name,
    email: email,

  );

  //FROM JSON
  factory ManagerModel.fromJson(Map<String, dynamic> json) {
    return ManagerModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  //TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,

    };
  }
}
