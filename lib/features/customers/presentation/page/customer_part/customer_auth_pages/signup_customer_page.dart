import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

import 'package:uuid/uuid.dart';

import '../../../bloc/customer_cubit.dart';
import '../../../bloc/customer_state.dart';
import 'confirm_customer_page.dart';
import 'login_customer_page.dart';



class SignUpCustomerPage extends StatelessWidget {
  SignUpCustomerPage({Key? key}) : super(key: key);
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passConfirmController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final uuid=Uuid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomersState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: 'Name', border: OutlineInputBorder()),
                    controller: _nameController,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Phone', border: OutlineInputBorder()),
                    controller: _phoneController,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: 'Password', border: OutlineInputBorder()),
                    controller: _passController,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: 'Password confirm',
                        border: OutlineInputBorder()),
                    controller: _passConfirmController,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final int dt=DateTime.now().millisecondsSinceEpoch;




                        CustomerEntity customerEntity = CustomerEntity(
                            name: _nameController.text,
                            phone: _phoneController.text,
                            id: uuid.v4(),
                            dateOfSignUp:dt ,
                        password: _passController.text
                        );
                        context.read<CustomerCubit>().addNewCustomer(
                            customerEntity);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ConfirmationPageCustomer()),
                                (route) => false);
                      },
                      child: Text('Sign Up!')),
                  Row(
                    children: [
                      Text('Have a account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LogInCustomerPage()),
                                    (route) => false);
                          },
                          child: Text('LogIn'))
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
    ;
  }
}
