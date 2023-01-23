import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_home_page.dart';

import '../../../../domain/entity/customer_entity.dart';
import '../../../bloc/customer_cubit.dart';

class ConfirmationPageCustomer extends StatefulWidget {
  ConfirmationPageCustomer(
      {Key? key,
      required this.verificationId,
      required this.name,
      required this.loading})
      : super(key: key);
  final String verificationId;
  final String name;
  bool loading;

  @override
  State<ConfirmationPageCustomer> createState() =>
      _ConfirmationPageCustomerState();
}

class _ConfirmationPageCustomerState extends State<ConfirmationPageCustomer> {
  TextEditingController _confirmController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Iltimos, raqamlarni kiriting!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'SMS orqali yuborilgan kodni kiriting!',
                    border: OutlineInputBorder()),
                controller: _confirmController,
              ),
              Divider(
                color: Colors.black,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final credential = PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: _confirmController.text.trim().toString());

                      final int dt = DateTime.now().millisecondsSinceEpoch;

                      final firebaseCustomer =
                          await auth.signInWithCredential(credential);
                      setState(() {
                        widget.loading = true;
                      });
                      if (widget.loading) {
                        CustomerEntity customerEntity = CustomerEntity(
                          name: widget.name,
                          phone: firebaseCustomer.user!.phoneNumber ?? "",
                          customerId: firebaseCustomer.user!.uid ?? "",
                          dateOfSignUp: dt,
                          managerAdded: false,
                        );

                        context
                            .read<CustomerCubit>()
                            .addNewCustomer(customerEntity);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CustomerHomePage()),
                            (route) => false);
                      } else
                        print('confirmation false buldi');
                    }
                  },
                  child: Text('Tasdiqlash')),
            ],
          ),
        ),
      ),
    );
  }
}
