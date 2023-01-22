import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

import 'package:uuid/uuid.dart';

import '../../../bloc/customer_cubit.dart';
import '../../../bloc/customer_state.dart';
import 'confirm_customer_page.dart';

class SignUpCustomerPage extends StatefulWidget {
  SignUpCustomerPage({Key? key}) : super(key: key);

  @override
  State<SignUpCustomerPage> createState() => _SignUpCustomerPageState();
}

class _SignUpCustomerPageState extends State<SignUpCustomerPage> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  final uuid = Uuid();
  final _formKey = GlobalKey<FormState>();
  final auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomersState>(
        builder: (context, state) {
      return Form(
        key: _formKey,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, ismingizni kiriting!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: 'Ism', border: OutlineInputBorder()),
                      controller: _nameController,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, telefon raqamingizni kiriting!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: '99 999 99 99',
                          border: OutlineInputBorder()),
                      controller: _phoneController,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {

                            auth.verifyPhoneNumber(
                              phoneNumber: _phoneController.text,
                                verificationCompleted: (_){},
                                verificationFailed:(e){
                                return ;
                                } ,
                                codeSent: (String verificationId, int? token){
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ConfirmationPageCustomer(verificationId: verificationId,)),
                                          (route) => false);
                                },
                                codeAutoRetrievalTimeout:(_){}

                            );
                            final int dt =
                                DateTime.now().millisecondsSinceEpoch;

                            // CustomerEntity customerEntity = CustomerEntity(
                            //     name: _nameController.text,
                            //     phone: _phoneController.text,
                            //     id: uuid.v4(),
                            //     dateOfSignUp: dt,
                            //     );
                            // context
                            //     .read<CustomerCubit>()
                            //     .addNewCustomer(customerEntity);


                          }
                        },
                        child: Text('Kirish')),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
    ;
  }
}
