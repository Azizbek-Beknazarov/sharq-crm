import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customers_page.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entity/customer_entity.dart';
import '../../bloc/customer_cubit.dart';

class NewCustomerAddPage extends StatefulWidget {
  const NewCustomerAddPage({Key? key}) : super(key: key);

  @override
  State<NewCustomerAddPage> createState() => _NewCustomerAddPageState();
}

class _NewCustomerAddPageState extends State<NewCustomerAddPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  final uuid = Uuid();

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
                    'Yangi mijoz qo\'shish.',
                    style: TextStyle(fontSize: 22),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ismni kiriting!';
                      } else if (value.length < 2) {
                        return 'Kamida 3 ta harf';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      name = val;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'Ismi',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Telefon raqamni kiriting!';
                      }else if (value.length <9) {
                        return 'Kamida 9 ta raqam';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      phone = val;
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
                            name: name,
                            phone: phone,
                            dateOfSignUp: DateTime.now().millisecondsSinceEpoch,
                            customerId: uuid.v4(),
                            managerAdded: true);
                        BlocProvider.of<CustomerCubit>(context, listen: false)
                            .addNewCustomer(customerEntity);

                        
                        setState(() {});
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>CustomersPage()), (route) => false);
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
