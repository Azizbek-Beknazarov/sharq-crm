import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_auth_pages/confirm_customer_page.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_home_page.dart';
import 'package:uuid/uuid.dart';

import '../../../../domain/entity/customer_entity.dart';
import '../../../bloc/customer_cubit.dart';
import '../../../bloc/customer_state.dart';


class SignUpCustomerPage extends StatefulWidget {
  SignUpCustomerPage({Key? key}) : super(key: key);

  @override
  State<SignUpCustomerPage> createState() => _SignUpCustomerPageState();
}

class _SignUpCustomerPageState extends State<SignUpCustomerPage> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();




  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  bool loading=false;

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
                          hintText: '+998945678090',
                          border: OutlineInputBorder()),
                      controller: _phoneController,
                    ),


                    Divider(
                      color: Colors.black,
                    ),

                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {

                            String name=_nameController.text.trim();

                            await auth.verifyPhoneNumber(
                              //
                                phoneNumber: _phoneController.text.trim(),
                                //
                                timeout: const Duration(seconds: 60),
                                //
                                verificationCompleted: (_) async{
setState(() {
  loading=false;
});

                                },
                                verificationFailed: (  e) {
                                  setState(() {
                                    loading=false;
                                  });
                                },
                                codeSent: (String verificationId, int? token) async{
                                  setState(() {
                                    loading=false;
                                  });

                         Navigator.pushAndRemoveUntil(context,
                             MaterialPageRoute(builder: (ctx)=>
                                 ConfirmationPageCustomer(verificationId: verificationId, name: name, loading: loading)), (route) => false);




                                },
                                codeAutoRetrievalTimeout: (_) {
                                  setState(() {
                                    loading=false;
                                  });
                                });
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
