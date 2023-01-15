import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/orders/data/model/car_model.dart';

abstract class CarRemoteDataSource {
  Future<void> addNewCar(CarModel newCar, String customerId);

  Future<List<CarModel>> getAllCars(String customerId);
//
// Future<void> deleteCar(String carId);
//
// Future<void> updateCar(CarModel updateCar, String carId);
}

class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  CollectionReference carReference =
      FirebaseFirestore.instance.collection('customers');

  @override
  Future<void> addNewCar(CarModel newCar, String customerId) async {
    return await carReference
        .doc(customerId)
        .collection('cars')
        .doc(newCar.carId)
        .set(newCar.toJson());
  }

  @override
  Future<List<CarModel>> getAllCars(String customerId) async {
    QuerySnapshot snapshot =
        await carReference.doc(customerId).collection('cars').get();

    List<CarModel> cars = snapshot.docs
        .map((e) => CarModel(carId: e['carId'], name: e['name'], carNumber: '', color: '', address: '', dateTime: 1, price: 1))
        .toList();

    return Future.value(cars);
  }
}
