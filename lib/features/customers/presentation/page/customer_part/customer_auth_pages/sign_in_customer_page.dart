
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/build_logo_widget.dart';
import '../../../bloc/customer_cubit.dart';
import '../../../bloc/customer_state.dart';
import 'confirm_customer_page_for_signin.dart';


class SignInCustomerPage extends StatefulWidget {
  SignInCustomerPage({Key? key}) : super(key: key);

  @override
  State<SignInCustomerPage> createState() => _SignUpCustomerPageState();
}

class _SignUpCustomerPageState extends State<SignInCustomerPage> {


  TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance; //I need make this clean code :)
  bool loading = false;
   String _inOrIndicator="Kirish";

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
                        BuildLogoWidget(),
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
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {

                                _inOrIndicator="Iltimos, kuting!";
setState(() {
  
});
                                await auth.verifyPhoneNumber(
                                  //
                                    phoneNumber: _phoneController.text.trim(),
                                    //
                                    timeout: const Duration(seconds: 10),
                                    //
                                    verificationCompleted: (_) async {
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    verificationFailed: (e) {
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    codeSent:
                                        (String verificationId, int? token) async {
                                      setState(() {
                                        loading = false;
                                      });

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  ConfirmationPageCustomerForSignIn(
                                                      verificationId:
                                                      verificationId,
                                                      name: '',
                                                      loading: loading)),
                                              (route) => false);
                                    },
                                    codeAutoRetrievalTimeout: (_) {});
                              }
                            },
                            child: Text(_inOrIndicator)),
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
