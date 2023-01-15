import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_bloc.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_state.dart';

import '../../bloc/car_bloc/car_event.dart';

class CarServicePage extends StatelessWidget {
  CarServicePage({Key? key}) : super(key: key);

  List<CarEntity> cars = [];

  @override
  Widget build(BuildContext context) {
    context.read<CarBloc>().add(CarGetAllEvent());
    return BlocBuilder<CarBloc, CarStates>(builder: (context, carState) {
      if (carState is CarLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (carState is CarLoadedState) {
        cars = carState.cars;
      } else if (carState is CarErrorState) {
        return Center(
          child: Text(carState.error),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('car service page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: cars
                .map((e) => Card(
                      child: ListTile(
                        title: Text(e.name),
                        subtitle: Text(e.carId),
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    });
  }
}
