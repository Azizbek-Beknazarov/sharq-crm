import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sharq_crm/features/customers/data/model/customer_model.dart';
import 'package:uuid/uuid.dart';

import '../bloc/get_customers_cubit/get_cus_cubit.dart';
import '../bloc/new_customer_bloc.dart';
import '../widget/customer_list.dart';

class CustomersPage extends StatefulWidget {
  CustomersPage({Key? key}) : super(key: key);

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  final uuid = Uuid();

  @override
  void setState(VoidCallback fn) {
    context.read<CustomerCubit>().loadCustomer();
    print('customers_page ichida loadCustomer() chaqirildi.}');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, AddNewCustomerState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(),
        body: CustomerList(),

        //
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog<void>(
                context: context,
                builder: (ctx) {
                  return Center(
                      child: AlertDialog(
                    title: Text('New customer'),
                    content: Column(
                      children: [
                        TextField(
                          controller: nameController,
                        ),
                        TextField(
                          controller: phoneController,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Add'),
                        onPressed: () {
                          var customerModel = CustomerModel(
                              name: nameController.text,
                              phone: phoneController.text,
                              id: uuid.v4());

                          context
                              .read<CustomerBloc>()
                              .add(AddCustomerEvent(customerModel));
                          setState(() {
                            nameController.clear();
                            phoneController.clear();
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
                });
          },
          child: Icon(Icons.add),
        ),
      );
    });
  }
}
