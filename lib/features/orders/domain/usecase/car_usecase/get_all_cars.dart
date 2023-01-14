import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';
import 'package:sharq_crm/features/orders/domain/repository/car_repo.dart';

class GetAllCarsUseCase extends UseCase<List<CarEntity>, CarsParams> {
  final CarRepo repo;

  GetAllCarsUseCase({required this.repo});

  @override
  Future<Either<Failure, List<CarEntity>>> call(CarsParams params) async {
    return await repo.getAllCars(params.customerID);
  }
}
