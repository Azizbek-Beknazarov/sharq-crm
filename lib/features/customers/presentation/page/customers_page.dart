import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sharq_crm/features/customers/data/model/customer_model.dart';
import 'package:uuid/uuid.dart';

import '../bloc/new_customer_bloc.dart';
import '../widget/customer_list.dart';

class CustomersPage extends StatelessWidget {
  CustomersPage({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomerList(),

      //
      floatingActionButton: BlocBuilder<CustomerBloc, AddNewCustomerState>(
          builder: (context, state) {
        return FloatingActionButton(
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
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
                });
          },
          child: Icon(Icons.add),
        );
      }),
    );
  }
}
