import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_bloc.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_event.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_state.dart';

import '../../../../customers/domain/entity/customer_entity.dart';
import '../../../domain/entity/car_entity.dart';

class CarExample extends StatelessWidget {
   CarExample({Key? key,required this.customer}) : super(key: key);
  final CustomerEntity customer;
   List<CarEntity> cars=[];
  @override

  Widget build(BuildContext context) {
    context.read<CarBloc>().add(CarGetAllEvent(customer.id));
    return BlocBuilder<CarBloc,CarStates>(builder: (context,state){
      if(state is CarLoadedState){
        cars=state.cars;

      }
      return Scaffold(body: ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index){
        return ListTile(title: Text(cars[index].name),);
      }),);
    });
  }
}
