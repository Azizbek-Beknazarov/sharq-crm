
import 'package:sharq_crm/features/orders/data/datasourse/car_datasource.dart';
import 'package:sharq_crm/features/orders/data/model/car_model.dart';
import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';
import 'package:sharq_crm/features/orders/domain/repository/car_repo.dart';

import '../../../../core/network/network_info.dart';



class CarRepoImpl implements CarRepo {
  NetworkInfo info;
  final CarRemoteDataSource carRemoteDataSource;

  CarRepoImpl({required this.carRemoteDataSource, required this.info});

  final _convert = (CarEntity e) => CarModel(carId: e.carId, name: e.name);

  @override
  Future<void> addNewCar(CarEntity newCar , String customerID) async {

    CarEntity entity = CarModel(carId: newCar.carId, name: newCar.name);
    CarModel model = _convert(entity);
    return await carRemoteDataSource.addNewCar(model, customerID);
  }
}
