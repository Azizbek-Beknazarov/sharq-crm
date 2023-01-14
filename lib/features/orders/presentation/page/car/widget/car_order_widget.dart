import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/car_entity.dart';

class CarOrderWidget extends StatefulWidget {
  const CarOrderWidget({Key? key, required this.cars}) : super(key: key);
  final List<CarEntity> cars;

  @override
  State<CarOrderWidget> createState() => _CarOrderWidgetState();
}

class _CarOrderWidgetState extends State<CarOrderWidget> {
  @override
  Widget build(BuildContext context) {

    return _orderCar();
  }

  Widget _orderCar() {
    final cars = widget.cars;
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        print(cars[index].name);
        return ListTile(title: Text(cars[index].name),);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemCount: cars.length,
    );
  }
}
