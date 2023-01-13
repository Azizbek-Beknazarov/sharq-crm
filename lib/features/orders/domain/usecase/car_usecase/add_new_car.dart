import 'package:sharq_crm/core/usecase/usecase.dart';

import 'package:sharq_crm/features/orders/domain/repository/car_repo.dart';

class AddNewCarUseCase extends UseCaseCar<void, CarParams> {
  final CarRepo carRepo;

  AddNewCarUseCase({required this.carRepo});

  @override
  Future<void> call({required CarParams params}) async{
    return await carRepo.addNewCar(params.carParam, params.customerID);
  }
}
