import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/orders/data/model/car_model.dart';

abstract class CarRemoteDataSource {
  Future<void> addNewCar(CarModel newCar);

  Future<List<CarModel>> getAllCars();
//
// Future<void> deleteCar(String carId);
//
// Future<void> updateCar(CarModel updateCar, String carId);
}

class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  CollectionReference carReference =
      FirebaseFirestore.instance.collection('cars');

  @override
  Future<void> addNewCar(CarModel newCar) async {
    return await carReference.doc(newCar.carId).set(newCar.toJson());
  }

  @override
  Future<List<CarModel>> getAllCars() async {
    QuerySnapshot snapshot =
        await carReference.get();

    List<CarModel> cars = snapshot.docs
        .map((e) => CarModel(
            carId: e['carId'],
            name: e['name'],
            carNumber: '',
            color: '',
            address: '',
            dateTime: 1,
            price: 1))
        .toList();

    return Future.value(cars);
  }
}
