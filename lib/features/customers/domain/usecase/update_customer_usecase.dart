import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';
import 'package:sharq_crm/features/customers/domain/repository/customer_repo.dart';

class UpdateCustomerUseCase extends UseCaseUpdate<void,CustomerModel, String >{
   CustomerRepository repository;

  UpdateCustomerUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(CustomerModel params,String customerId) async{
 return await repository.updateCuctomers(params,customerId);
  }

}