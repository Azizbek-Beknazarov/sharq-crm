import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/orders/data/model/car_model.dart';

abstract class CarRemoteDataSource {
  Future<void> addNewCar(CarModel newCar, String customerId);

// Future<List<CarModel>> getAllCars();
//
// Future<void> deleteCar(String carId);
//
// Future<void> updateCar(CarModel updateCar, String carId);
}

class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  CollectionReference carRreference =
      FirebaseFirestore.instance.collection('customers');

  @override
  Future<void> addNewCar(CarModel newCar, String customerId) async {
    return await carRreference
        .doc(customerId)
        .collection('cars')
        .doc(newCar.carId)
        .set(newCar.toJson());
  }
}
