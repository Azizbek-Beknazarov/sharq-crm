import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_bloc.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_event.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_state.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../orders/domain/entity/car_entity.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../widget/customer_phone_call_widget.dart';

class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({Key? key, required this.customer})
      : super(key: key);


  final CustomerEntity customer;

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  List<CarEntity> cars = [];
  bool update = false;
  TextEditingController carNameController = TextEditingController();
  final uuid = Uuid();

  //
  //
  @override
  void setState(VoidCallback fn) {
    context.read<CarBloc>().add(CarGetAllEvent(widget.customer.id));
    print('CarGetAllEvent chaqirildi:');
    if (update == true) {
      print('Update chaqirildi: true buldi');
      context.read<CarBloc>().add(CarGetAllEvent(widget.customer.id));
    }

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    print('CustomerDetailPage ichidagi build() chaqirildi');
    context.read<CarBloc>().add(CarGetAllEvent(widget.customer.id));
    int ts = widget.customer.dateOfSignUp;
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts);
    String datetime = tsdate.year.toString() + "/" + tsdate.month.toString() + "/" + tsdate.day.toString()+" | "+tsdate.hour.toString()+":"+tsdate.minute.toString();

    return BlocBuilder<CarBloc, CarStates>(builder: (context, state) {
      if (state is CarLoadedState) {
        cars = state.cars;
      }
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.customer.name,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              // call to customer phone
              CustomerCallWidget( customer: widget.customer,),
              // order cars
              _carOrder(cars),
              Text(datetime),

            ],
          ),
        ),

        floatingActionButton: SpeedDial(
          children: [
           SpeedDialChild(child: Text('car'),onTap: ()=>_floatingCar(update)),
           SpeedDialChild(child: Text('photo')),
           SpeedDialChild(child: Text('club')),
            //

          ],
        ),
        // _floatingActionButton(update),
      );
    });

  }

  //1 car
  _floatingCar(bool update) {
    return
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Car add'),
                content: Column(
                  children: [
                    TextFormField(
                      controller: carNameController,
                    )
                  ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        CarEntity newCar = CarEntity(
                            carId: uuid.v4(), name: carNameController.text, carNumber: '', color: '', address: '', dateTime: 1, price: 1);
                        final customerID = widget.customer.id;

                        context
                            .read<CarBloc>()
                            .add(CarAddNewEvent(newCar, customerID));
                        carNameController.clear();

                        setState(() {
                          update = true;
                          print("update true buldi button ichida");
                        });
                        Navigator.pop(context);
                      },
                      child: Text("add"))
                ],
              );
            });

        // MaterialPageRoute route = MaterialPageRoute(
        //     builder: (_) => CarPage(
        //           customer: widget.customer, update: update
        //         ));
        //
        // Navigator.push(context, route);


  }

  //2
  Widget _carOrder(List<CarEntity> cars) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
          color: Colors.amber.shade200,
          borderRadius: BorderRadius.all(Radius.circular(11))),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.all(6),
          itemCount: cars.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  color: Colors.amber.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(11))),
              child: ListTile(
                title: Container(
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.black, width: 3),
                        color: Colors.amber.shade200,
                        borderRadius:
                        BorderRadius.all(Radius.circular(11))),
                    child: Text(cars[index].name)),
              ),
            );
          }),
    );
  }

  //3

}
