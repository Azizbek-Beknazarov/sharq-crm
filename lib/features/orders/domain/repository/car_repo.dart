import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';

abstract class CarRepo {
  Future<void> addNewCar(CarEntity newCar, String customerID);

//   Future<List<CarEntity>> getAllCars();
//
//   Future<void> deleteCar(String carId);
//
//   Future<void> updateCar(CarEntity updateCar, String carId);
}
