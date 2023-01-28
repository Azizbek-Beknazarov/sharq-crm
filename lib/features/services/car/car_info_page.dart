import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';

class CarInfoPage extends StatelessWidget {
  CarInfoPage({Key? key, required this.car}) : super(key: key);
  final CarEntity car;
  TextEditingController _addressController=TextEditingController();
  TextEditingController _timeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text(car.name),
              subtitle: Text(car.carId),
            ),
          ),
          Card(
            child: ElevatedButton(
              onPressed: () {
                showDialog(context: context, builder: (ctx) {
                  return Center(
                      child: AlertDialog(
                        title: Text('Wedding infos'),
                        content: Column(
                          children: [
                            TextField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.add_moderator_outlined),
                                labelText: 'Address',
                              ),
                              controller: _addressController,
                            ),
                            TextField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.timer),
                                labelText: 'time',
                              ),
                              controller: _timeController,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Add to card'),
                            onPressed: () {
                              // final customerId = customerList.id;
                              // CustomerEntity entity = CustomerEntity(
                              //     password: '',
                              //     name: widget.nameController.text,
                              //     phone: widget.phoneController.text,
                              //     dateOfSignUp: DateTime.now().millisecondsSinceEpoch,
                              //     id: customerList.id);
                              //
                              // context
                              //     .read<CustomerCubit>()
                              //     .updateCustomer(entity, customerId);
                              // setState(() {
                              //   widget.nameController.clear();
                              //   widget.phoneController.clear();
                              // });
                              // Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
                });
              },

              child: Text('To Orders'),
            ),
          )
        ],
      ),
    );
  }
}
