import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/customer_entity.dart';
import '../../bloc/customer_cubit.dart';
import 'customers_page.dart';

class CustomerUpdatePage extends StatefulWidget {
  CustomerUpdatePage({
    Key? key,
    required this.customerList,
  }) : super(key: key);

  CustomerEntity customerList;

  @override
  State<CustomerUpdatePage> createState() => _CustomerUpdatePageState();
}

class _CustomerUpdatePageState extends State<CustomerUpdatePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(58.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Mijoz ma\'lumotlarini yangilash.',
                    style: TextStyle(fontSize: 22),
                  ),
                  TextFormField(
                    initialValue: widget.customerList.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ismni kiriting!';
                      } else if (value.length < 2) {
                        return 'Kamida 3 ta harf';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      widget.customerList.name = val;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'Ismi',
                    ),
                  ),
                  TextFormField(
                    initialValue: widget.customerList.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Telefon raqamni kiriting!';
                      } else if (value.length < 9) {
                        return 'Kamida 9 ta raqam';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      widget.customerList.phone = val;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      labelText: '+998901234567',
                    ),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Tasdiqlash'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        CustomerEntity customerEntity = CustomerEntity(
                            name: widget.customerList.name,
                            phone: widget.customerList.phone,
                            dateOfSignUp: DateTime.now().millisecondsSinceEpoch,
                            customerId: widget.customerList.customerId,
                            managerAdded: true);
                        BlocProvider.of<CustomerCubit>(context, listen: false)
                            .updateCustomer(customerEntity,
                                widget.customerList.customerId!);

                        setState(() {});
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => CustomersPage()),
                            (route) => false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
