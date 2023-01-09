import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';
import 'package:sharq_crm/features/customers/domain/repository/customer_repo.dart';

class UpdateCustomerUseCase extends UseCase<void,CustomerModel>{
  final CustomerRepository repository;
  final String id;
  UpdateCustomerUseCase({required this.repository, required this.id});

  @override
  Future<Either<Failure, void>> call(CustomerModel params) async{
 return await repository.updateCuctomers(params, id);
  }

}