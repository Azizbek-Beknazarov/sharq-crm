import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_bloc.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_event.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_state.dart';
import 'package:sharq_crm/features/orders/presentation/page/car/car_page.dart';
import 'package:sharq_crm/features/customers/presentation/widget/customer_call_widget.dart';

import '../../../orders/domain/entity/car_entity.dart';
import '../../../orders/presentation/page/car/widget/car_order_widget.dart';


class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({Key? key, required this.customer})
      : super(key: key);
  final CustomerEntity customer;

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  @override
  void setState(VoidCallback fn) {
    context.read<CarBloc>().add(CarGetAllEvent(widget.customer.id));
    print('CarGetAllEvent chaqirildi:');
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.parse(widget.customer.dateOfSignUp.toString());
    return BlocBuilder<CarBloc,CarStates>(

        builder: (context, carState) {
          List<CarEntity> cars=[];
          if (carState is CarLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (carState is CarLoadedState) {

            setState(() {
              cars = carState.cars;

            });

          } else if (carState is CarErrorState) {
            return Text(
              carState.error,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            );
          }

      return Scaffold(
        appBar: AppBar(
          title: Text(widget.customer.name),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                CustomerCallWidget(phone: widget.customer.phone),
                SizedBox(height: 5,),
                CarOrderWidget(cars: cars),


                Text(widget.customer.id),
                Text(time.toString()),
              ],
            ),
          ),
        ),
        floatingActionButton: _floatingActionButton(),
      );
    });
  }

  //1
  _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (_) => CarPage(
                  customer: widget.customer,
                ));
        Navigator.push(context, route);
      },
      child: Icon(Icons.add),
    );
  }




}
