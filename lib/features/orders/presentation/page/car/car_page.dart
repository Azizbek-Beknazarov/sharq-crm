import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_bloc.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_event.dart';
import 'package:uuid/uuid.dart';

import '../../../../customers/domain/entity/customer_entity.dart';
import '../../../../customers/presentation/page/customer_detail_page.dart';

class CarPage extends StatefulWidget {
   CarPage({Key? key, required this.customer,required this.update}) : super(key: key);
  final CustomerEntity customer;
  bool update;

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  TextEditingController carNameController = TextEditingController();
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New car adding'),
      ),
      body: (Column(
        children: [
          TextField(
            controller: carNameController,
          ),
          ElevatedButton(
              onPressed: () {
                CarEntity newCar =
                    CarEntity(carId: uuid.v4(), name: carNameController.text, carNumber: '', color: '', address: '', dateTime: 1, price: 1, );
                final customerID = widget.customer.id;

                setState(() { widget.update=true;
                  context
                      .read<CarBloc>()
                      .add(CarAddNewEvent(newCar, customerID));
                  carNameController.clear();
                });
                Navigator.pop(context);
              },
              child: Text('add car')),
        ],
      )),
    );
  }
}
